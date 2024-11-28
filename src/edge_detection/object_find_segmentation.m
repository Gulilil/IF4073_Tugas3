function image_segmentation_result = object_find_segmentation(img, image_edge_detection, binarization_method, segmentation_method, radius, min_pixel_area)
    % Melakukan segmentasi objek berdasarkan hasil deteksi tepi

    % Transformasi citra hasil pendeteksian tepi menjadi citra biner
    % fprintf("Pilihan metode binerisasi:\n");
    % fprintf("1. Metode Otsu\n");
    % fprintf("2. Metode Adaptive\n");
    % binerization_method = input("Pilih metode binerisasi: ");

    % while binerization_method < 1 || binerization_method > 2
    %     fprintf("Metode binerisasi tidak valid. Silahkan pilih metode binerisasi yang valid.\n");
    %     binarization_method = input("Pilih metode binerisasi: ");
    % end

    % Binerisasi citra hasil deteksi tepi
    if binarization_method == "Otsu"
        binarize_result = imbinarize(image_edge_detection, graythresh(image_edge_detection));
    elseif binarization_method == "Adaptive"
        binarize_result = imbinarize(image_edge_detection, 'Adaptive');
    end

    % fprintf("\n")

    % Pemilihan cara segmentasi objek
    % fprintf("Pilihan metode segmentasi objek:\n");
    % fprintf("1. Morphological and Component Analysis\n");
    % fprintf("2. Border Clearing and Hole Filling\n");

    % segmentation_method = input("Pilih metode segmentasi objek: ");

    % while segmentation_method < 1 || segmentation_method > 2
    %     fprintf("Metode segmentasi objek tidak valid. Silahkan pilih metode segmentasi objek yang valid.\n");
    %     segmentation_method = input("Pilih metode segmentasi objek: ");
    % end

    % Segmentasi objek berdasarkan metode yang dipilih
    if segmentation_method == "Morphological"
        % Morphological operation
        cleaned_edges = imclose(binarize_result, strel('disk', radius));

        % Connected Component Analysis
        [labeled_objects, ~] = bwlabel(cleaned_edges);

        % % Visualization of segmented objects in black and white
        % figure;
        % subplot(1, 3, 1);
        % imshow(labeled_objects);
        % title('Segmented Objects');
        % 
        % subplot(1, 3, 2);
        % imshow(labeled_objects, []);
        % title('Segmented Objects (Intensity Scaled)');
        % 
        % subplot(1, 3, 3);
        % imshow(label2rgb(labeled_objects, 'jet', 'k'));
        % title(['Segmented Objects: ', num2str(num_objects)]);

        % Hasil akhir segmentasi objek
        largest_region_mask = labeled_objects;
    elseif segmentation_method == "Border Clearing"
        % radius = input("Masukkan radius untuk operasi closing dan opening pixel: ");
        % min_pixel_area = input("Masukkan luas minimum pixel untuk penghilangan region kecil: ");

        % Operasi closing pixel
        cleaned_edges = imclose(binarize_result, strel('disk', radius));
        
        % Operasi untuk menghilangkan border
        cleaned_edges = imclearborder(cleaned_edges);

        % Operasi untuk mengisi lubang
        cleaned_edges = imfill(cleaned_edges, 'holes');

        % Operasi opening pixel
        cleaned_edges = imopen(cleaned_edges, strel('disk', radius));

        % Operasi untuk menghilangkan region kecil
        cleaned_edges = bwareaopen(cleaned_edges, min_pixel_area);

        % Hasil akhir segmentasi objek
        largest_region_mask = cleaned_edges;
    end

    % Membuat mask
    mask = uint8(largest_region_mask);

    % Return the result based on labeled objects
    image_segmentation_result = img .* mask;

    % % Menyimpan atau menampilkan hasil segmentasi berdasarkan mask
    % figure;
    % imshow(image_segmentation_result);
    % title('Final Segmentation Result');
end