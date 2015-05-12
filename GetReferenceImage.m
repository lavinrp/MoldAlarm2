function [refImage, cropRect]= GetReferenceImage(filePath, referenceNumber, tifFiles)
  
   
   %tifFiles = dir(strcat(filePath,'/*.tif')); 
   
   %find reference Image
   refImageName = tifFiles(1).name; %reference image should always be the first image
   refImagePath = strcat(filePath,'/',refImageName);  %finds the filepath
   uncroppedRefImage = imread(refImagePath);
   [refImage, cropRect] = imcrop(uncroppedRefImage(:,:,1));

%     refImageName = refImagePath.name;
%     fullImagePath= strcat(filePath,'/',refImageName);  %finds the filepath
%     
%     origImage = imread(fullImagePath);
%     [refImage, cropRect] = imcrop(origImage(:,:,1));
%     
%     axes(axes1);
end