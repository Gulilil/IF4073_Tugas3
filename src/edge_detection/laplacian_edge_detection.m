function image_edge_detection = laplacian_edge_detection(img)
    % Konversi Image ke Double
    img = double(img);
    
    % Meminta input dari pengguna untuk ukuran mask
    nMask = input('Masukkan ukuran mask n x n (Contoh 3 untuk mask ukuran 3x3): ');

    fprintf("\n")
    
    % Check apakah mask valid
    validMask = false;
    
    while ~validMask
        % Minta input dari pengguna untuk mask Laplacian
        disp(['Masukkan matriks mask Laplacian berukuran ', num2str(nMask), 'x', num2str(nMask)]);
        
        % Input mask dalam bentuk string
        laplacian_mask_str = input('Masukkan matriks mask: ', 's');
        
        % Konversi input string ke dalam bentuk numerik
        laplacian_mask = str2num(laplacian_mask_str);
        
        % Cek apakah mask memiliki ukuran n x n
        [rows, cols] = size(laplacian_mask);
        if rows ~= nMask || cols ~= nMask
            fprintf(['Mask harus berukuran ', num2str(nMask), 'x', num2str(nMask), '!\n']);
            continue;
        end
        
        % Cek simetri mask
        if ~isequal(laplacian_mask, laplacian_mask')
            fprintf('Mask harus simetris!\n');
            continue;
        end
        
        % Cek apakah jumlah elemen mask adalah nol
        if sum(laplacian_mask(:)) ~= 0
            fprintf('Jumlah elemen dalam mask harus nol!\n');
            continue;
        end
        
        % Jika aman, validMask jadi true
        validMask = true;
    end

    fprintf("\n")
    
    % Deteksi tepi menggunakan metode Laplacian
    image_edge_detection = convolution(img, laplacian_mask, nMask);
end