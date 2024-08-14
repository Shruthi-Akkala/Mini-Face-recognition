clear;
clc;

path = "E:\CS 663\HW4\ORL\s"; 
img = zeros(10304, 1);


for i = 1:32
    for j = 1:6
        path_new = path + i + "/" + j + ".pgm";
        image = imread(path_new);
        image = double(image(:));
        img = [img, image];
    end
end


img = img(:, 2:end);

trainimage = img/255;
mean = sum(trainimage, 2)/192;
trainimage = trainimage - mean;
L = (trainimage')*trainimage;
[V, lamda] = eig(L);

V = trainimage*V;

% to get the eigen values in descending order we do filp the covariance
% matrix

%[eigenvals_ATA, idx] = sort(diag(eigenvals_ATA), 'descend');
[lamda, sortedIndices] = sort(diag(lamda), 'descend');
V = V(:, sortedIndices);


val = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];
mat= zeros(size(val));

for k = 1:13
    
    V_K = V(:, 1:val(k));
    V_K = V_K./max(V_K);
    
    train_img_coeffients = V_K'*trainimage;

    corr_face = 0;
    
    for i = 1:32
        for j = 7:10
            
            path_new = path + i + "/" + j + ".pgm";
            image = imread(path_new);
            image = double(image(:));
            image = image/255;
            image = image - mean;
            
            a = V_K'*image;
            
            error = sum((train_img_coeffients - a).^2);
            
            [mini, index] = min(error);
            prediction = ceil(index/6);
            
            if(prediction == i)
                corr_face = corr_face +1;
            end
    
        end
    end
mat(k) = (corr_face*100)/128;
end


disp(mat);
figure
plot(val,mat);
xlabel('Number of Eigenfaces (k)');
ylabel('Recognition Rate (%)');
title('Recognition Rate vs. Number of Eigenfaces');

eigenface(V);
reconstruct(V,mean);
