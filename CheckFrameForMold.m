


function moldFound = CheckFrameForMold(frameToCheck, referenceImage)
   
%     %edge detect and subtract
%     reducedImage = FindSubtractedEdge(frameToCheck, referenceImage);
%     figure;
%     imshow(reducedImage);
%     
%     %remove invalid objects from image
%     cleanedImage = EliminateInvalidObjects(reducedImage, 1000, 10);
%     
%     figure;
%     imshow(cleanedImage);
%     figure;

    filteredImage = FilterImage(frameToCheck, referenceImage);
    
    %count the remaining objects in view
    objCount = CountObjects(filteredImage);
    
    moldFound = false;
end

function filteredImage = FilterImage(frameToCheck, referenceImage)
    %edge detect and subtract
    reducedImage = FindSubtractedEdge(frameToCheck, referenceImage);
    figure;
    imshow(reducedImage);
    title('subtracted')
    pause(2);
    
    %remove small invalid objects from image
    cleanedImage = EliminateInvalidObjects(reducedImage, 1000, 5);
    
    imshow(cleanedImage);
    title('cleaned')
    
    %enlarge remaining structures
    %enhancedImage = EnlargeObjects(cleanedImage, 3);
    
    %imshow(enhancedImage);
    
    %TODO: remove remaining invalid structures
    
    
    %TODO: return cleaned image
    
    filteredImage = cleanedImage;
    
end


function returnImage = EnlargeObjects(image, radius)
    structureElement = strel('disk', radius, 0);
    %structureElement = strel('square', 5); alternate dialation option
    returnImage = imdilate(image, structureElement);
end

function objCount = CountObjects(image)
    objCount = 1;
    %TODO: fill stub
end

function cleanedImage = EliminateInvalidObjects(image, maxObjSize, minObjSize)

    cleanedImage = image;
    CC = bwconncomp(cleanedImage);    
    pixelArray = cellfun(@numel, CC.PixelIdxList);
    
    %identify invalid structures
    invalidStructures = find(pixelArray > maxObjSize | pixelArray <= minObjSize);
    
    %use to print the number of invalid structures found
    %size(invalid_structures)
    
    %remove invalid structures
    for k = 1:length(invalidStructures)
        invalid_pix = CC.PixelIdxList{invalidStructures(k)};
        %every invalid pixel gets set to black
        cleanedImage(invalid_pix) = 0;
    end

end

function returnImage = FindSubtractedEdge(image,refImg)
    %TODO: posabilities for better subtracted image
    %TODO: enlarge structures in refImg?
    %TODO: subtract out last image too?
 
    %find the edges of the image to subtract from
    im = edge(image);
    
    %find the edges of the reference image(image to subtract)
    rim = edge(refImg);
    
    %Enlarge all objects in reference image to get rid of more noise
    rim = EnlargeObjects(rim, 2);
    
    %return the result of the subtraction
    returnImage = im - rim;    
end