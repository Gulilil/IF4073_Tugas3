function image_edge_detection = laplacian_of_gaussian_edge_detection(img)
    % Konversi Image ke Grayscale jika diperlukan
    if ndims(img) == 3
        img = rgb2gray(img); % Convert to grayscale
    end
    
    % Konversi Image ke Double
    img = double(img);
    
    % Meminta input dari pengguna untuk ukuran mask
    nMask = input('Masukkan ukuran mask n x n (Contoh 3 untuk mask ukuran 3x3): ');
    sigma = input('Masukkan nilai sigma: ');

    fprintf("\n");
    
    % Generate Gaussian matrix
    gaussian_mask = generate_gaussian_matrix(nMask, sigma);

    % Generate Laplacian kernel
    laplacian_kernel = generate_laplacian_kernel(nMask);

    % Combine Gaussian and Laplacian to create LoG kernel
    log_kernel = log_convolution(gaussian_mask, laplacian_kernel);

    % Apply LoG kernel to the image
    filtered_img = log_convolution(img, log_kernel);

    % Detect edges by thresholding the zero-crossings
    image_edge_detection = zero_crossing_detection(filtered_img);
end