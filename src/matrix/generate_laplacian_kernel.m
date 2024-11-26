function laplacian_kernel = generate_laplacian_kernel(nKernel, laplacian_kernel_str)
    % Check apakah kernel valid
    validKernel = false;
    
    while ~validKernel
        % Minta input dari pengguna untuk kernel Laplacian
        % disp(['Masukkan matriks Laplacian kernel berukuran ', num2str(nKernel), 'x', num2str(nKernel)]);

        % % Informasi terkait matriks kernel Laplacian
        % fprintf('Syarat Matriks Laplacian:\n')
        % fprintf('1. Matriks kernel harus simetris\n');
        % fprintf('2. Jumlah elemen dalam kernel harus nol\n');
        
        % % Input kernel dalam bentuk string
        % laplacian_kernel_str = input('Masukkan matriks kernel: ', 's');
        
        % Konversi input string ke dalam bentuk numerik
        laplacian_kernel = str2num(laplacian_kernel_str);
        
        % Cek apakah kernel memiliki ukuran n x n
        [rows, cols] = size(laplacian_kernel);
        if rows ~= nKernel || cols ~= nKernel
            fprintf(['Kernel harus berukuran ', num2str(nKernel), 'x', num2str(nKernel), '!\n']);
            continue;
        end
        
        % Cek simetri kernel
        if ~isequal(laplacian_kernel, laplacian_kernel')
            fprintf('Kernel harus simetris!\n');
            continue;
        end
        
        % Cek apakah jumlah elemen kernel adalah nol
        if sum(laplacian_kernel(:)) ~= 0
            fprintf('Jumlah elemen dalam kernel harus nol!\n');
            continue;
        end
        
        % Jika aman, validKernel jadi true
        validKernel = true;
    end