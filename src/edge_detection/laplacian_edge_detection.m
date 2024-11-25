function image_edge_detection = laplacian_edge_detection(img, nKernel)
    addpath("src\matrix\");
    % Konversi Image ke Double
    img = double(img);
    
    % Generate Laplacian kernel
    laplacian_kernel = generate_laplacian_kernel(double(nKernel));

    fprintf("\n")
    
    % Deteksi tepi menggunakan metode Laplacian
    image_edge_detection = convolution(img, laplacian_kernel, nKernel);
end