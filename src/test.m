addpath("img_test\")
addpath("src\image_input\")
addpath("src\edge_detection\")
addpath("src\matrix\")

% Pilih dan load program, 'same'
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
    image_edge_detection = laplacian_edge_detection(img, 3, "[0 1 0; 1 -4 1; 0 1 0]");
elseif method == 2
    image_edge_detection = laplacian_of_gaussian_edge_detection(img, 3, 0.4, "[0 1 0; 1 -4 1; 0 1 0]");
elseif method == 3
    image_edge_detection = sobel_prewitt_roberts_edge_detection(img, "Sobel", 1);
elseif method == 4
    image_edge_detection = sobel_prewitt_roberts_edge_detection(img, "Prewitt", 7);
elseif method == 5
    image_edge_detection = sobel_prewitt_roberts_edge_detection(img, "Roberts", 5);
elseif method == 6
    image_edge_detection = canny_edge_detection(img);
end

% Melakukan segmentasi objek berdasarkan hasil deteksi tepi
image_segmentation_result = object_find_segmentation(img, image_edge_detection, "Otsu", "Morphological", 5, 100);

% Menampilkan hasil sebelum dan sesudah deteksi tepi
figure;
subplot(1, 3, 1);
imshow(img);
title("Gambar Asli");

subplot(1, 3, 2);
imshow(image_edge_detection);
title("Gambar Hasil Deteksi Tepi");

subplot(1, 3, 3);
imshow(image_segmentation_result);
title("Gambar Hasil Segmentasi Objek dengan " + method);