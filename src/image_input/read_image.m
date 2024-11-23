function img = read_image(filename)
    % Membaca gambar dengan nama spesifik
    fprintf('Membaca gambar input dari file: %s\n', filename);
    img = imread(filename);
end