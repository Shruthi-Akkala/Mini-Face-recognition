image=zeros(192*168,1);
Persons = 40;

for j=1:39
    if j<=9
        path = "E:\CS 663\HW4\CroppedYale\yaleB0" + j;
    elseif j==14
        continue;
    else
        path = "E:\CS 663\HW4\CroppedYale\yaleB" + j;
    end
        imagefiles=dir(path);
        c=0;
        for i=1:numel(imagefiles)
            if c==40
                break
            end
           if imagefiles(i).isdir
                continue
           else
               img=imread(fullfile(path,imagefiles(i).name));
               img=double(img(:));
               image=[image,img];
               c=c+1;
           end
           
         end
end



image=image(:, 2:end);
image = image/255;
meanofimages=sum(image,2)/1520;
meanimage=image-meanofimages;
covar=(meanimage'*meanimage);
[eigonvec,eigvec]=eig(covar);
coveigen=meanimage*eigonvec;
coveigen=(coveigen)./max(coveigen(:));

[eigvec, sortedIndices] = sort(diag(eigvec), 'descend');
eigonvec = eigonvec(:, sortedIndices);

k=[1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];
mat = zeros(size(k));
for h=1:17
    V_new=coveigen(:,1:k(h));
    train_img_coeffients = V_new'*meanimage;  
    correct_predict = 0;
    for j=4:39
    if j<=9
        path = "E:\CS 663\HW4\CroppedYale\yaleB0" + j;
    elseif j==14
        continue;
    else
        path = "E:\CS 663\HW4\CroppedYale\yaleB" + j;
    end
        imagefiles=dir(path);

        for i=41:numel(imagefiles)
           if imagefiles(i).isdir
                continue
           else
               img=imread(fullfile(path,imagefiles(i).name));
               img=double(img(:));
               img = img/255;
               image = img - meanofimages;
               a = V_new'*image;
            
               error = sum((train_img_coeffients - a).^2);
               [M, I] = min(error);
            prediction = ceil(I/Persons);
            if(prediction == j)
                correct_predict = correct_predict +1;
   
            end
           
           end
        end
     end
    
mat(h) = (correct_predict*100)/(38*24);
end

disp(mat);


plot(k, mat);

title("Accuracy graph for Test data all eigen value");
xlabel("Values of K");
ylabel("Accuracy/recognization rate");