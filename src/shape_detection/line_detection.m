function [edge_detected_image, parameter_domain_image, shape_detected_image] = line_detection(img)
    addpath("src\edge_detection\");
    
    % edge_detected_image = sobel_prewitt_roberts_edge_detection(img, "sobel", 1);
    edge_detected_image = canny_edge_detection(img);
    
    % adjust edge detected image
    threshold = 0.25;
    if max(edge_detected_image(:)) > 1  % If the image has values greater than 1
        edge_detected_image = (double(edge_detected_image) / 255) >= threshold; % Scale to [0, 1] and make in binary
    else
        edge_detected_image = edge_detected_image; % Leave it as it is
    end
    
    range = 256;
    accumulator = zeros(range, range);
    [rows, cols, n_channel] = size(edge_detected_image);
        
    R_TO_D = 0.017453;
    sqrt_val = sqrt(double(rows * rows) + double(cols * cols));
    for i = 1:rows
        for j = 1:cols
            if (edge_detected_image(i, j) == 1)
                for a_idx = 1:range
                    theta = double(a_idx) * 360 / range  * R_TO_D;
                    r = i * cos(theta) + j * sin(theta);
                    r = r + sqrt_val;
                    r = r / (sqrt_val * 2.0);
                    r = r * (i-1);
                    r = r + 0.5;
                    r = floor(r);
                    % fprintf("%d %d %d\n", a_idx, theta, r);
                    if (r > 0 && r <= range)
                        accumulator(a_idx, r) = accumulator(a_idx, r) + 1;
                    end
                end
            end
        end
    end
    
    % Accumulator to display
    accumulator = double(accumulator) / max(accumulator(:));
    disp(accumulator);
    % imshow(accumulator);


    parameter_domain_image = [];
    shape_detected_image = [];

end

