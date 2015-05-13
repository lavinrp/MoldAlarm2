function image = GetImage(filePath, tifFile, cropRect)

   %Find the file for the image
   imageName = tifFile.name; 
   imagePath = strcat(filePath,'/',imageName);  %finds the filepath
   uncroppedImage = imread(imagePath);
   
   %crop the image to fit the reference image
   image = imcrop(uncroppedImage(:,:,1), cropRect);
   
   %display the image to the user
   imshow(image);
end