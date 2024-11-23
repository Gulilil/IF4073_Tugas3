function image_edge_detection = prewitt_edge_detection(img)
    % Konversi Image ke Grayscale jika diperlukan
    if size(img, 3) == 3
        img = rgb2gray(img);
    end

    % Input pengali kernel
    multiplier_scale = input('Masukkan nilai skala pengali kernel (Contoh 1 untuk kernel Prewitt): ');
    
    % Mendeteksi tepi menggunakan metode Prewitt
    PrewittX = [-1, 0, 1; -1, 0, 1; -1, 0, 1];  % Prewitt kernel untuk arah X
    PrewittY = [-1, -1, -1; 0, 0, 0; 1, 1, 1];  % Prewitt kernel untuk arah Y

    % Mengalikan kernel dengan skala
    PrewittX = PrewittX * multiplier_scale;
    PrewittY = PrewittY * multiplier_scale;
    
    % Mencari ukuran gambar
    [rows, cols] = size(img);
    
    % Inisialisasi gambar hasil deteksi tepi
    image_edge_detection = zeros(rows, cols);
    
    % Looping untuk deteksi tepi menggunakan metode Prewitt
    for i = 2:rows-1
        for j = 2:cols-1
            % Ambil region 3x3 dari gambar
            region = img(i-1:i+1, j-1:j+1);
            
            % Hitung gradien menggunakan kernel Prewitt
            grad_x = sum(sum(PrewittX .* double(region)));
            grad_y = sum(sum(PrewittY .* double(region)));
            
            % Hitung magnitudo gradien
            image_edge_detection(i, j) = sqrt(grad_x^2 + grad_y^2);
        end
    end
    
    % Konversi gambar hasil deteksi tepi ke tipe data uint8
    image_edge_detection = uint8(image_edge_detection);
end