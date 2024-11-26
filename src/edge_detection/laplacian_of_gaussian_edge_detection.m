function image_edge_detection = laplacian_of_gaussian_edge_detection(img, nMask, sigma)
    addpath("src\matrix\");
    % Konversi Image ke Grayscale
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    
    % Membuat Gaussian Matrix
    gaussian_mask = generate_gaussian_matrix(nMask, sigma);

    % Membuat Laplacian Kernel
    laplacian_kernel = generate_laplacian_kernel(double(nMask));

    % Konvolusi antara Gaussian and Laplacian untuk membuat LoG kernel
    log_kernel = log_convolution(gaussian_mask, laplacian_kernel);

    % Konvolusi LoG Kernel dengan gambar 
    image_edge_detection = log_convolution(img, log_kernel);
end