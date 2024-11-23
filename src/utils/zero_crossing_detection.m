function edge_image = zero_crossing_detection(img)
    % Detect zero-crossings in an image
    [rows, cols] = size(img);
    edge_image = zeros(rows, cols);
    
    for i = 2:rows-1
        for j = 2:cols-1
            % Check neighbors for sign changes (zero-crossing detection)
            if (img(i, j) > 0 && (img(i-1, j) < 0 || img(i+1, j) < 0 || img(i, j-1) < 0 || img(i, j+1) < 0)) || ...
               (img(i, j) < 0 && (img(i-1, j) > 0 || img(i+1, j) > 0 || img(i, j-1) > 0 || img(i, j+1) > 0))
                edge_image(i, j) = 1; % Mark as edge
            end
        end
    end
end