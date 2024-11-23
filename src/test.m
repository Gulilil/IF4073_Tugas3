addpath("img_test\")
addpath("src\image_input\")
addpath("src\utils\")
addpath("src\edge_detection\")

% Pilih dan load program
filename = select_image();
img = read_image(filename);

% Pemilihan metode input untuk pendeteksian tepi
fprintf("\n")
fprintf("Pilih metode input untuk pendeteksian tepi:\n");
fprintf("1. Laplacian\n");
fprintf("2. Laplacian of Gaussian\n");
fprintf("3. Sobel\n");
fprintf("4. Prewitt\n");
fprintf("5. Roberts\n");
fprintf("6. Canny\n");

% Pilih metode input
method = input("Pilih metode input: ");

% Deteksi tepi berdasarkan metode input
while method < 1 || method > 6
    fprintf("Metode input tidak valid. Silahkan pilih metode input yang valid.\n");
    method = input("Pilih metode input: ");
end

fprintf("\n")

% Deteksi tepi berdasarkan metode input
if method == 1
    image_edge_detection = laplacian_edge_detection(img);
elseif method == 2
    image_edge_detection = laplacian_of_gaussian_edge_detection(img);
elseif method == 3
    image_edge_detection = sobel_edge_detection(img);
elseif method == 4
    image_edge_detection = prewitt_edge_detection(img);
elseif method == 5
    image_edge_detection = roberts_edge_detection(img);
elseif method == 6
    image_edge_detection = canny_edge_detection(img);
end

% Menampilkan hasil sebelum dan sesudah deteksi tepi
figure;
subplot(1, 2, 1);
imshow(img);
title("Gambar Asli");

subplot(1, 2, 2);
imshow(image_edge_detection);
title("Gambar Hasil Deteksi Tepi");