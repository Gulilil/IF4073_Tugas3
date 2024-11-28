function image_segmentation_result = object_find_segmentation(img, image_edge_detection, binarization_method, segmentation_method, radius, min_pixel_area)
    % Melakukan segmentasi objek berdasarkan hasil deteksi tepi

    % Binerisasi citra hasil deteksi tepi
    if binarization_method == "Otsu"
        binarize_result = imbinarize(image_edge_detection, graythresh(image_edge_detection));
    elseif binarization_method == "Adaptive"
        binarize_result = imbinarize(image_edge_detection, 'Adaptive');
    end

    % Segmentasi objek berdasarkan metode yang dipilih
    if segmentation_method == "Morphological"
        % Morphological operation
        cleaned_edges = imclose(binarize_result, strel('disk', radius));

        % Connected Component Analysis
        [labeled_objects, ~] = bwlabel(cleaned_edges);

        % Hasil akhir segmentasi objek
        largest_region_mask = labeled_objects;
    elseif segmentation_method == "Border Clearing"
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
end