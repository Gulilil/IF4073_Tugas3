function image_edge_detection = sobel_prewitt_roberts_edge_detection(img, type, multiplier_scale)
    % Konversi Image ke Grayscale
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    
    % Mendeteksi tepi menggunakan pilihan metode
    if upper(type) == "SOBEL"
        MatrixX = [-1, 0, 1; -2, 0, 2; -1, 0, 1];  % Sobel kernel untuk arah X
        MatrixY = [-1, -2, -1; 0, 0, 0; 1, 2, 1];  % Sobel kernel untuk arah Y
    elseif upper(type) == "PREWITT"
        MatrixX = [-1, 0, 1; -1, 0, 1; -1, 0, 1];  % Prewitt kernel untuk arah X
        MatrixY = [-1, -1, -1; 0, 0, 0; 1, 1, 1];  % Prewitt kernel untuk arah Y
    elseif upper(type) == "ROBERTS"
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