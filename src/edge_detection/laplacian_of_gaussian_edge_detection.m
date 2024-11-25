function image_edge_detection = laplacian_of_gaussian_edge_detection(img, nMask, sigma)
    addpath("src\matrix\");
    % Konversi Image ke Grayscale jika diperlukan
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    
    % Konversi Image ke Double
    img = double(img);
    
    % Generate Gaussian matrix
    gaussian_mask = generate_gaussian_matrix(nMask, sigma);

    % Generate Laplacian kernel
    laplacian_kernel = generate_laplacian_kernel(double(nMask));

    % Combine Gaussian and Laplacian to create LoG kernel
    log_kernel = log_convolution(gaussian_mask, laplacian_kernel);

    % Apply LoG kernel to the image
    image_edge_detection = log_convolution(img, log_kernel);
end