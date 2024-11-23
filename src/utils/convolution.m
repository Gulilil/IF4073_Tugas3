function result_img = convolution(img, mask, n_mask)
    [row, col, num_channels] = size(img);
    
    pixel_border = floor(n_mask/2);   
    sum_mask = sum_mat(mask);

    % Img details
    fprintf("[INFO] An image size [%d, %d] is inputted!\n", row, col);
    result_img = zeros(row, col, num_channels, 'uint8');

     for channel = 1: num_channels
        channel_result = zeros(row, col);
        img_channel = img(:, :, channel);   % Each Color channel
    
        parfor r=1:row
            rowResult = zeros(1, col);
    
            for c=1:col
                % For border
                % If pixel is in border, set it to black (0)
                if (is_border_pixel(img_channel, r, c, pixel_border))
                    rowResult(c) = 0;  % Set to black
                else
                    local_mat = get_local_mat(img_channel, r, c, n_mask);
                    if(sum_mask == 0)
                        result_pixel = round(dot_product(local_mat, mask))
                    else
                        result_pixel = round(dot_product(local_mat, mask) / sum_mask)
                    end
                    conv_result = validate_pixel(result_pixel);
                    rowResult(c) = conv_result;
                end
            end
            channel_result(r, :) = rowResult;
        end
        result_img(:,:, channel) = channel_result;
     end
    disp("[FINISHED] Finish processing!");
end