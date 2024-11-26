function image_edge_detection = laplacian_edge_detection(img, nKernel)
    % Konversi Image ke Grayscale
    if size(img, 3) == 3
        img = rgb2gray(img);
    end

    % Check apakah ukuran kernel ganjil dan bilangan bulat
    while mod(nKernel, 2) == 0 || nKernel ~= floor(nKernel)
        fprintf("Ukuran kernel harus ganjil. Silahkan masukkan ukuran kernel yang benar.\n");
        nKernel = input("Masukkan ukuran kernel n x n (n ganjil): ");
    end

    % Membuat Laplacian Kernel
    laplacian_kernel = generate_laplacian_kernel(double(nKernel));
        
    % Deteksi tepi menggunakan metode Laplacian memanfaatkan konvolusi
    image_edge_detection = conv2(img, laplacian_kernel, 'same');

    % Konversi gambar hasil deteksi tepi ke tipe data uint8
    image_edge_detection = uint8(image_edge_detection);