function [image_segmentation_result, method] = object_find_segmentation(img, image_edge_detection)
    % Melakukan segmentasi objek berdasarkan hasil deteksi tepi

    % Transformasi citra hasil pendeteksian tepi menjadi citra biner
    fprintf("Pilihan metode binerisasi:\n");
    fprintf("1. Metode Otsu\n");
    fprintf("2. Metode Adaptive\n");
    fprintf("3. Metode Manual\n");
    binerization_method = input("Pilih metode binerisasi: ");

    % Binerisasi citra hasil deteksi tepi
    if binerization_method == 1
        binarize_result = imbinarize(image_edge_detection, graythresh(image_edge_detection));
        method = "Otsu";
    elseif binerization_method == 2
        binarize_result = imbinarize(image_edge_detection, 'Adaptive');
        method = "Adaptive";
    elseif binerization_method == 3
        threshold = input("Masukkan nilai threshold (0-1): ");
        binarize_result = imbinarize(image_edge_detection, threshold);
        method = "Manual";
    end

    % Morphological operation
    cleaned_edges = imclose(binarize_result, strel('disk', 5));

    % Connected Component Analysis
    [labeled_objects, num_objects] = bwlabel(cleaned_edges);

    % Visualization of segmented objects in black and white
    figure;
    subplot(1, 3, 1);
    imshow(labeled_objects);
    title('Segmented Objects');

    subplot(1, 3, 2);
    imshow(labeled_objects, []);
    title('Segmented Objects (Intensity Scaled)');

    subplot(1, 3, 3);
    imshow(label2rgb(labeled_objects, 'jet', 'k'));
    title(['Segmented Objects: ', num2str(num_objects)]);

    if binerization_method == 2
        % Mengidentifikasi region terbesar
        stats = regionprops(labeled_objects, 'Area', 'PixelIdxList');
        [~, largest_idx] = max([stats.Area]); % Menemukan index region terbesar
    
        % Membuat mask untuk region terbesar
        largest_region_mask = false(size(labeled_objects));
        largest_region_mask(stats(largest_idx).PixelIdxList) = true;
    else
        largest_region_mask = labeled_objects;
    end

    % Menampilkan mask dari region terbesar
    % figure;
    % imshow(largest_region_mask);
    % title('Mask of Largest Region');

    % Membuat hasil segmentasi gambar berdasarkan mask terbesar
    mask = uint8(largest_region_mask);
    image_segmentation_result = img .* mask;

    % Menyimpan atau menampilkan hasil segmentasi berdasarkan mask
    figure;
    imshow(image_segmentation_result);
    title('Final Segmentation Result with Largest Region');
end