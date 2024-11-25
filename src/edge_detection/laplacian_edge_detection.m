function image_edge_detection = laplacian_edge_detection(img, nKernel)
    addpath("src\matrix\");
    % Konversi Image ke Double
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    
    % Generate Laplacian kernel
    laplacian_kernel = generate_laplacian_kernel(double(nKernel));

    fprintf("\n")
    
    % Deteksi tepi menggunakan metode Laplacian
    image_edge_detection = convolution(img, laplacian_kernel, nKernel);
end