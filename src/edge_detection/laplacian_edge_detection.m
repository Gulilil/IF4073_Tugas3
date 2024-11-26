function image_edge_detection = laplacian_edge_detection(img, nKernel)
    addpath("src\matrix\");
    % Konversi Image ke Grayscale
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    
    % Membuat Laplacian Kernel
    laplacian_kernel = generate_laplacian_kernel(double(nKernel));

    fprintf("\n")
    
    % Deteksi tepi menggunakan metode Laplacian memanfaatkan konvolusi
    image_edge_detection = convolution(img, laplacian_kernel, nKernel);
end