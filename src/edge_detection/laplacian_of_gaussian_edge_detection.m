function image_edge_detection = laplacian_of_gaussian_edge_detection(img, nMask, sigma, kernel_str)
    % Konversi Image ke Grayscale
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    
    % Check apakah ukuran kernel ganjil dan bilangan bulat
    if mod(nMask, 2) == 0 || nMask ~= floor(nMask)
        fprintf("Ukuran kernel harus ganjil. Silahkan masukkan ukuran kernel yang benar.\n");
        % nMask = input("Masukkan ukuran kernel n x n (n ganjil): ");
    else
        % Membuat Gaussian Matrix
        gaussian_mask = generate_gaussian_matrix(nMask, sigma);
    
        % Membuat Laplacian Kernel
        laplacian_kernel = generate_laplacian_kernel(double(nMask), kernel_str);
    
        % Konvolusi antara Gaussian and Laplacian untuk membuat LoG kernel
        log_kernel = conv2(gaussian_mask, laplacian_kernel, 'same');
    
        % Konvolusi LoG Kernel dengan gambar 
        image_edge_detection = conv2(img, log_kernel, 'same');
    
        % Konversi gambar hasil deteksi tepi ke tipe data uint8
        image_edge_detection = uint8(image_edge_detection);
    end
    
   