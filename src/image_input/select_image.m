% Fungsi untuk memilih gambar input
function filename = select_image()
    % Import image by name (without file extension)
    while true
        filename = input("Masukkan nama gambar yang ingin diproses: ", "s");
        
        % Define possible file extensions
        extensions = {'.jpg', '.png', '.jpeg', '.bmp', '.tiff'};

        % Loop untuk mencari apakah file ada
        for i = 1:length(extensions)
            full_filename = strcat("img_test\", filename, extensions{i});
            if exist(full_filename, 'file')
                filename = full_filename;
                return;
            end
        end
        
        % Jika file tidak ada, input kembali
        disp('File tidak ada. Coba lagi');
    end
end

