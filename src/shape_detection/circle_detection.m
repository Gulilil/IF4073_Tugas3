function [edge_detected_image, parameter_domain_image, inversed_detected_image, shape_detected_image] = circle_detection(img, detection_threshold, input_num1, input_num2, input_text, input_type, radius)
    
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
    % Initialize accumulator
    inverse_detected_image = zeros(rows, cols);
    thetaRange = 0:1:359; % Range of theta values (in degrees)
    thetaRange = deg2rad(thetaRange);
    
    % Hough Transform
    for i = 1: rows
        for j = 1 : cols
            if (edge_detected_image(i, j) == 1)
                for theta_idx = 1: length(thetaRange)
                    theta = thetaRange(theta_idx);
                    a = round(i - radius * cos(theta));
                    b = round(j - radius * sin(theta));
                    % Full circle in radians
                    
                    % fprintf("%d %d %d\n", i, j, theta);
                    if (a > 0 && a <= rows && b > 0 && b <= cols)
                        inverse_detected_image(a, b) = inverse_detected_image(a, b) + 1;
                    end
                end
            end
        end
    end
    
    % Accumulator to display
    parameter_domain_image = double(inverse_detected_image) / max(inverse_detected_image(:));
    % imshow(parameter_domain_image);
    
    if (isstring(detection_threshold))
        detection_threshold = str2double(detection_threshold);
    end
    selected_parameter_domain_image = parameter_domain_image >= detection_threshold;
    % imshow(selected_parameter_domain_image);
    
    inversed_detected_image = zeros(rows, cols);
    % Inverse 
    for a = 1:rows
        for b = 1:cols
            if (selected_parameter_domain_image(a, b) == 1)
                for theta_idx = 1: length(thetaRange)
                    theta = thetaRange(theta_idx);
                    i = round(a + radius * cos(theta));
                    j = round(b + radius * sin(theta));

                    % Full circle in radians
                    % fprintf("%d %d %d %d %d\n", a, b, theta, i, j);
                    if (i > 0 && i <= rows && j > 0 && j <= cols)
                        inversed_detected_image(i, j) = inversed_detected_image(i, j) + 1;
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
                % fprintf("%d, %d, %d\n", shape_detected_image(r,c,1), shape_detected_image(r,c,2), shape_detected_image(r,c,3));
            end
        end
    end
end

