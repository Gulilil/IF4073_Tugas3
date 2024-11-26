function image_edge_detection = canny_edge_detection(img)
    % Konversi Image ke Grayscale
    if size(img, 3) == 3
        img = rgb2gray(img);
    end

    % Mendeteksi tepi menggunakan pilihan metode
        image_edge_detection = edge(img, 'canny');