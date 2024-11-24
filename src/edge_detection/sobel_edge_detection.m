function image_edge_detection = sobel_edge_detection(img, multiplier_scale)
    % Konversi Image ke Grayscale jika diperlukan
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    
    % Mendeteksi tepi menggunakan metode Sobel
    SobelX = [-1, 0, 1; -2, 0, 2; -1, 0, 1];  % Sobel kernel untuk arah X
    SobelY = [-1, -2, -1; 0, 0, 0; 1, 2, 1];  % Sobel kernel untuk arah Y

    % Mengalikan kernel dengan skala
    SobelX = SobelX * multiplier_scale;
    SobelY = SobelY * multiplier_scale;
    
    % Mencari ukuran gambar
    [rows, cols] = size(img);
    
    % Inisialisasi gambar hasil deteksi tepi
    image_edge_detection = zeros(rows, cols);
    
    % Looping untuk deteksi tepi menggunakan metode Sobel
    for i = 2:rows-1
        for j = 2:cols-1
            % Ambil region 3x3 dari gambar
            region = img(i-1:i+1, j-1:j+1);
            
            % Hitung gradien menggunakan kernel Sobel
            grad_x = sum(sum(SobelX .* double(region)));
            grad_y = sum(sum(SobelY .* double(region)));
            
            % Hitung magnitudo gradien
            image_edge_detection(i, j) = sqrt(grad_x^2 + grad_y^2);
        end
    end
    
    % Konversi gambar hasil deteksi tepi ke tipe data uint8
    image_edge_detection = uint8(image_edge_detection);
end