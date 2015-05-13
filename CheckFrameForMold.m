


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

    filteredImage = FilterImage4Step(frameToCheck, referenceImage);
    
    %count the remaining objects in view
    objCount = CountObjects(filteredImage);
    
    moldFound = false;
end

function filteredImage = FilterImage4Step(frameToCheck, referenceImage)
    %edge detect and subtract
    reducedImage = FindSubtractedEdge(frameToCheck, referenceImage);
    figure;
    imshow(reducedImage);
    
    %remove small invalid objects from image
    cleanedImage = EliminateInvalidObjects(reducedImage, 1000, 10);
    
    imshow(cleanedImage);
    %TODO: enlarge remaining structures
    
    %TODO: remove remaining invalid structures
    
    %TODO: return cleaned image
    
    filteredImage = cleanedImage;
    
end

function objCount = CountObjects(image)
    objCount = 1;
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
 
    %find the edges of the image to subtract from
    im = edge(image);
    
    %find the edges of the reference image(image to subtract)
    rim = edge(refImg);
    
    %return the result of the subtraction
    returnImage = im - rim;    
end