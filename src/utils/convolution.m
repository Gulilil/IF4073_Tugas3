function result_img = convolution(img, mask, n_mask)
    [row, col, num_channels] = size(img);
    
    pixel_border = floor(n_mask / 2);   
    sum_mask = sum(mask(:)); % Sum of all elements in the mask

    % Img details
    fprintf("[INFO] An image size [%d, %d] is inputted!\n", row, col);
    result_img = zeros(row, col, num_channels); % Use double for intermediate results

    for channel = 1:num_channels
        channel_result = zeros(row, col);
        img_channel = double(img(:, :, channel));   % Convert to double for computation
    
        for r = 1:row
            for c = 1:col
                % For border
                if (is_border_pixel(img_channel, r, c, pixel_border))
                    channel_result(r, c) = 0;  % Set to black
                else
                    local_mat = get_local_mat(img_channel, r, c, n_mask);
                    if (sum_mask == 0)
                        result_pixel = dot_product(local_mat, mask); % No normalization
                    else
                        result_pixel = dot_product(local_mat, mask) / sum_mask;
                    end
                    channel_result(r, c) = validate_pixel(result_pixel);
                end
            end
        end
        result_img(:, :, channel) = channel_result;
    end

    % Convert the final result back to uint8
    result_img = uint8(result_img);
    disp("[FINISHED] Finish processing!");
end