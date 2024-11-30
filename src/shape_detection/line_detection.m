function [edge_detected_image, parameter_domain_image, inversed_detected_image, shape_detected_image] = line_detection(img, detection_threshold, input_num1, input_num2, input_text, input_type)
    
    % Adjusting to desired edge detection method
    if (input_type == "Laplace")
        edge_detected_image = laplacian_edge_detection(img, input_num1, input_text);
    elseif(input_type == "LoG")
        edge_detected_image = laplacian_of_gaussian_edge_detection(img, input_num1, input_num2, input_text);
    elseif(input_type == "Sobel" || input_type == "Prewitt" || input_type == "Roberts")
        edge_detected_image = sobel_prewitt_roberts_edge_detection(img, input_type, input_num1);
    else % input_type == "Canny"
        edge_detected_image = canny_edge_detection(img);
    end
    
    % Adjust edge detected image
    if max(edge_detected_image(:)) > 1  % If the image has values greater than 1
        threshold = 0.25;
        edge_detected_image = (double(edge_detected_image) / 255) >= threshold; % Scale to [0, 1] and make in binary
    end
    
    [rows, cols, ~] = size(edge_detected_image);
    sqrt_val = round(sqrt(double(rows * rows) + double(cols * cols)));

    rRange = -sqrt_val:1:sqrt_val; % Range of rho values
    thetaRange = -90:1:89; % Range of theta values (in degrees)
    accumulator = zeros(length(thetaRange), length(rRange));

    for i = 1:rows
        for j = 1:cols
            if (edge_detected_image(i, j) == 1)
                for theta_idx = 1:length(thetaRange)
                    theta = deg2rad(thetaRange(theta_idx));
                    r = i * cos(theta) + j * sin(theta);
                    r_idx = round(r + sqrt_val);
                    if r_idx > 0 && r_idx <= length(rRange)
                        accumulator(theta_idx, r_idx) = accumulator(theta_idx, r_idx) + 1;
                    end
                end
            end
        end
    end
    
    % Accumulator to display
    parameter_domain_image = double(accumulator) / max(accumulator(:));
    selected_parameter_domain_image = parameter_domain_image >= str2double(detection_threshold);
    
    inversed_detected_image = zeros(rows, cols);
    % Inverse 
    for theta_idx = 1:length(thetaRange)
        for r_idx = 1:length(rRange)
            if (selected_parameter_domain_image(theta_idx, r_idx) == 1)
                theta = deg2rad(thetaRange(theta_idx));
                r = rRange(r_idx);
                idx_list_x = [];
                idx_list_y = [];

                % Check based on the condition
                if (sin(theta) == 0)
                    y = 0;
                    for x = 1:rows
                        y = y + 1;
                        idx_list_x(end+1) = x;
                        idx_list_y(end+1) = y;
                    end
                elseif (cos(theta) == 0)
                    x = 0;
                    for y = 1:cols
                        x = x+1;
                        idx_list_x(end+1) = x;
                        idx_list_y(end+1) = y;
                    end
                else % sin(theta) ~= 0 && cos(theta) ~= 0
                    for x = 1:rows
                        y = (r - x * cos(theta)) / sin(theta);
                        y = round(y);
                        if (y >1 && y <= cols)
                            idx_list_x(end+1) = x;
                            idx_list_y(end+1) = y;
                        end
                    end
                end


                % Check to whether it is really a Line in edge detected image
                prev_x = 0;
                prev_y = 0;
                max_distance = 15;
                accumulated_distance = 0;
                count = 0;
                for i = 1:length(idx_list_x)
                    x = idx_list_x(i);
                    y = idx_list_y(i);
                    if (edge_detected_image(x,y) == 1)
                        if (prev_x ~= 0 && prev_y ~= 0)
                            distance = sqrt(double(x - prev_x)^2 + double(y - prev_y)^2);
                            accumulated_distance = accumulated_distance + distance;
                            count = count + 1;
                        end
                        prev_x = x;
                        prev_y = y;
                    end
                end
                % Only tolerable to 3 times neg_point
                if (double(accumulated_distance) / count <= max_distance)
                    for i = 1:length(idx_list_x)
                        x = idx_list_x(i);
                        y = idx_list_y(i);
                        inversed_detected_image(x, y) = inversed_detected_image(x, y) + 1;
                    end
                end
            end
        end
    end

    % If more than 1, make it 1
    inversed_detected_image = inversed_detected_image >= 1;
    
    % Make RGB format
    if (size(img, 3) == 1)
        if (max(img(:)) == 1)
            grayImage = double(img) * 255;
        else
            grayImage = img;
        end
        img = repmat(im2double(grayImage), [1, 1, 3]);
    end
    if (size(edge_detected_image, 3) == 1)
        grayImage = double(edge_detected_image) * 255;
        edge_detected_image = repmat(im2double(grayImage), [1, 1, 3]);
    end
    if (size(parameter_domain_image, 3) == 1)
        grayImage = double(parameter_domain_image) * 255;
        parameter_domain_image = repmat(im2double(grayImage), [1, 1, 3]);
    end
    if (size(inversed_detected_image, 3) == 1)
        grayImage = double(inversed_detected_image) * 255;
        inversed_detected_image = repmat(im2double(grayImage), [1, 1, 3]);
    end

    shape_detected_image = img;
    for r = 1 : rows
        for c = 1 : cols
            if (inversed_detected_image(r, c, 1) == 255)
                % Make Red for shape detected pixels
                shape_detected_image(r, c, 1) = 255;
                shape_detected_image(r, c, 2) = 0;
                shape_detected_image(r, c, 3) = 0;
            end
        end
    end
end

