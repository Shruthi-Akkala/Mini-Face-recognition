function reconstruct(V,X)

image_to_reconstruct = imread('6.pgm');
image_to_reconstruct = double(image_to_reconstruct);

image_vector = image_to_reconstruct(:);
image_vector = image_vector - X; 


k_values = [2, 10, 20, 50, 75, 100, 125, 150, 175];


figure;
for i = 1:length(k_values)
    k = k_values(i);
    
    
    selected_eigenfaces = V(:, 1:k);
    
    
    eigen_coefficients = selected_eigenfaces' * image_vector;
    
    
    reconstructed_image_vector = selected_eigenfaces * eigen_coefficients;
    reconstructed_image_vector = reconstructed_image_vector + X;
    
    reconstructed_image = reshape((reconstructed_image_vector),[112,92]);
    
    subplot(3, 3, i);
    imshow(reconstructed_image, []);
    title(['k = ' num2str(k)]);
end

end
