function [mask_mat] = generate_gaussian_matrix(nMask, sigma)
    % Generate n x n Gaussian matrix (kernel) dengan standard deviation sigma
    % sigma: standard deviation for the Gaussian function
    
    % Membuat grid of (x, y) koordinat dengan center di (0, 0)
    half_size = (nMask - 1) / 2;
    [x, y] = meshgrid(-half_size:half_size, -half_size:half_size);
    
    % Fungsi Gaussian
    mask_mat = (1 / (2 * pi * sigma^2)) * exp(-(x.^2 + y.^2) / (2 * sigma^2));
    
    % Normalisasi matrix sehingga total semua elemen menjadi bernilai 1
    mask_mat = mask_mat / sum(mask_mat(:));
end