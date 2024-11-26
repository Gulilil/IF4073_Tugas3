function result = log_convolution(image, kernel)
    [rows, cols] = size(image);
    [kRows, kCols] = size(kernel);
    
    padSizeRow = floor(kRows / 2);
    padSizeCol = floor(kCols / 2);
    
    % Pad gambar dengan zeros
    padded_image = padarray(image, [padSizeRow, padSizeCol], 0, 'both');
    
    % Inisialisasi matriks hasil
    result = zeros(rows, cols);
    
    % Melakukan proses konvolusi
    for i = 1:rows
        for j = 1:cols
            local_patch = padded_image(i:i+kRows-1, j:j+kCols-1);
            result(i, j) = sum(sum(local_patch .* kernel));
        end
    end
end