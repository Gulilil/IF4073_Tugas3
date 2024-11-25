function image_edge_detection = sobel_prewitt_roberts_edge_detection(img, type)
    % Konversi Image ke Grayscale jika diperlukan
    if size(img, 3) == 3
        img = rgb2gray(img);
    end

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
    
    % Mencari ukuran gambar
    [rows, cols] = size(img);
    
    % Inisialisasi gambar hasil deteksi tepi
    image_edge_detection = zeros(rows, cols);
    
    % Looping untuk deteksi tepi menggunakan metode yang dipilih
    if type == "Roberts"
        % Roberts menggunakan matriks region 2x2
        for i = 1:rows-1
            for j = 1:cols-1
                region = img(i:i+1, j:j+1);

                % Perhitungan gradien
                grad_x = sum(sum(MatrixX .* double(region)));
                grad_y = sum(sum(MatrixY .* double(region)));

                % Perhitungan magnitude gradient
                image_edge_detection(i, j) = sqrt(grad_x^2 + grad_y^2);
            end
        end
    else
        % Sobel and Prewitt menggunakan matriks region 3x3
        for i = 2:rows-1
            for j = 2:cols-1
                region = img(i-1:i+1, j-1:j+1);

                % Perhitungan gradien
                grad_x = sum(sum(MatrixX .* double(region)));
                grad_y = sum(sum(MatrixY .* double(region)));

                % Perhitungan magnitude gradient
                image_edge_detection(i, j) = sqrt(grad_x^2 + grad_y^2);
            end
        end
    end
    
    % Konversi gambar hasil deteksi tepi ke tipe data uint8
    image_edge_detection = uint8(image_edge_detection);
end