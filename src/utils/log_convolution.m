function result = log_convolution(image, kernel)
    % Initialize the result matrix
    [rows, cols] = size(image);
    [kRows, kCols] = size(kernel);
    
    padSizeRow = floor(kRows / 2);
    padSizeCol = floor(kCols / 2);
    
    % Pad the image with zeros
    padded_image = padarray(image, [padSizeRow, padSizeCol], 0, 'both');
    
    % Initialize result matrix
    result = zeros(rows, cols);
    
    % Perform convolution
    for i = 1:rows
        for j = 1:cols
            % Extract the local patch
            local_patch = padded_image(i:i+kRows-1, j:j+kCols-1);
            
            % Perform element-wise multiplication and summation
            result(i, j) = sum(sum(local_patch .* kernel));
        end
    end
end