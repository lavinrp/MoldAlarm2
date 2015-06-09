function [refImage, cropRect]= GetReferenceImage(filePath, referenceNumber, containerNumber, tifFiles)
  
   
   %tifFiles = dir(strcat(filePath,'/*.tif')); 
for i = 1:containerNumber
   %find reference Image
   refImageName = tifFiles(referenceNumber).name; %reference image should always be the first image
   refImagePath = strcat(filePath,'/',refImageName);  %finds the filepath
   uncroppedRefImage = imread(refImagePath);
   [refImage{i}, cropRect{i}] = imcrop(uncroppedRefImage(:,:,1));

%     refImageName = refImagePath.name;
%     fullImagePath= strcat(filePath,'/',refImageName);  %finds the filepath
%     
%     origImage = imread(fullImagePath);
%     [refImage, cropRect] = imcrop(origImage(:,:,1));
%     
%     axes(axes1);
    end
end

