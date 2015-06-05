function image = GetImage(filePath, tifFile, cropRect)

   %Find the file for the image
   imageName = tifFile.name; 
   imagePath = strcat(filePath,'/',imageName);  %finds the filepath
   uncroppedImage = imread(imagePath);
   
   %crop the image to fit the reference image
   for i = 1:length(cropRect)
  
       image{i} = imcrop(uncroppedImage(:,:,1), cropRect{i});
   end
   %display the image to the user
   %imshow(image);
end