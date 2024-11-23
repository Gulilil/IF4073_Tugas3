function image_edge_detection = laplacian_edge_detection(img)
    % Konversi Image ke Double
    img = double(img);
    
    % Meminta input dari pengguna untuk ukuran kernel
    nKernel = input('Masukkan ukuran kernel n x n (Contoh 3 untuk kernel ukuran 3x3): ');

    fprintf("\n")
    
    % Generate Laplacian kernel
    laplacian_kernel = generate_laplacian_kernel(nKernel);

    fprintf("\n")
    
    % Deteksi tepi menggunakan metode Laplacian
    image_edge_detection = convolution(img, laplacian_kernel, nKernel);
end