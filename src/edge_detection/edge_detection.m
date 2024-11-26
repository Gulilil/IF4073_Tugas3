function image_edge_detection = edge_detection(img, type)
    % Konversi Image ke Grayscale
    if size(img, 3) == 3
        img = rgb2gray(img);
    end

    if type == "Laplacian"
        % Pemilihan ukuran kernel
        nKernel = input("Masukkan ukuran kernel n x n (n ganjil): ");

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

    elseif type == "LoG"
        % Pemilihan ukuran kernel
        nMask = input("Masukkan ukuran kernel n x n (n ganjil): ");

        % Check apakah ukuran kernel ganjil dan bilangan bulat
        while mod(nMask, 2) == 0 || nMask ~= floor(nMask)
            fprintf("Ukuran kernel harus ganjil. Silahkan masukkan ukuran kernel yang benar.\n");
            nMask = input("Masukkan ukuran kernel n x n (n ganjil): ");
        end

        % Pemilihan nilai sigma
        sigma = input("Masukkan nilai sigma: ");

        % Membuat Gaussian Matrix
        gaussian_mask = generate_gaussian_matrix(nMask, sigma);

        % Membuat Laplacian Kernel
        laplacian_kernel = generate_laplacian_kernel(double(nMask));

        % Konvolusi antara Gaussian and Laplacian untuk membuat LoG kernel
        log_kernel = conv2(gaussian_mask, laplacian_kernel, 'same');

        % Konvolusi LoG Kernel dengan gambar 
        image_edge_detection = conv2(img, log_kernel, 'same');

        % Konversi gambar hasil deteksi tepi ke tipe data uint8
        image_edge_detection = uint8(image_edge_detection);

    elseif type == "Sobel" || type == "Prewitt" || type == "Roberts"
        % Input pengali kernel
        multiplier_scale = input('Masukkan nilai skala pengali kernel: ');

        % Mendeteksi tepi menggunakan pilihan metode
        if type == "Sobel"
            MatrixX = [-1, 0, 1; -2, 0, 2; -1, 0, 1];  % Sobel kernel untuk arah X
            MatrixY = [-1, -2, -1; 0, 0, 0; 1, 2, 1];  % Sobel kernel untuk arah Y
        elseif type == "Prewitt"
            MatrixX = [-1, 0, 1; -1, 0, 1; -1, 0, 1];  % Prewitt kernel untuk arah X
            MatrixY = [-1, -1, -1; 0, 0, 0; 1, 1, 1];  % Prewitt kernel untuk arah Y
        elseif type == "Roberts"
            MatrixX = [1, 0; 0, -1];  % Roberts kernel untuk arah X
            MatrixY = [0, 1; -1, 0];  % Roberts kernel untuk arah Y
        else
            error('Metode tidak dikenal');
        end

        % Mengalikan kernel dengan skala
        MatrixX = MatrixX * multiplier_scale;
        MatrixY = MatrixY * multiplier_scale;
        
        % Konvolusi gambar dengan kernel X dan Y
        convolutionX = conv2(img, MatrixX, 'same');
        convolutionY = conv2(img, MatrixY, 'same');

        % Menghitung magnitude
        image_edge_detection = sqrt(convolutionX.^2 + convolutionY.^2);
        
        % Konversi gambar hasil deteksi tepi ke tipe data uint8
        image_edge_detection = uint8(image_edge_detection);

    elseif type == "Canny"
        image_edge_detection = edge(img, 'canny');
    else
        error('Metode tidak dikenal');
    end
end