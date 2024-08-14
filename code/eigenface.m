function eigenface(V)

k = 25;  % Number of eigenfaces to display
figure;

for i = 1:k
    subplot(5, 5, i);  % Assuming a 2x5 grid, adjust as needed
    eigenface = reshape(V(:, i), [112, 92]);  % Adjust 'height' and 'width' according to your data
    imshow(eigenface, []);
    
end

