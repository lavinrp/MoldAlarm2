

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
    moldFound = false;
    for i = 1:length(frameToCheck)
        %pause(1);
        filteredImage = FilterImage(frameToCheck{i}, referenceImage{i});

        %count the remaining objects in view
        objCount = CountObjects(filteredImage);

        %returns true if more objects were found than were expected
        if objCount > 1
            moldFound = true;
        end
    end
end

function filteredImage = FilterImage(frameToCheck, referenceImage)
    %edge detect and subtract
    reducedImage = FindSubtractedEdge(frameToCheck, referenceImage);
    
    %reducedImage = EliminateInvalidObjects(reducedImage, 700, 30);
    %reducedImage = EnlargeObjects(reducedImage, 1);
    %figure;
    imshow(reducedImage);
    title('subtracted')
    %pause(1);
    
    %remove small invalid objdects from image
    cleanedImage = EliminateInvalidObjects(reducedImage, 350, 200);
    
    imshow(cleanedImage);
    title('cleaned')
    
    %%pause(1);
    
    %enlarge remaining structures
    %enhancedImage = EnlargeObjects(cleanedImage, 3);
    
    %imshow(enhancedImage);
    
    %TODO: remove remaining invalid structures
    
    
    %return cleaned image
    filteredImage = cleanedImage;
    
end


function returnImage = EnlargeObjects(image, radius)
    structureElement = strel('disk', radius, 0);
    %structureElement = strel('square', 5); alternate dialation option
    returnImage = imdilate(image, structureElement);
end

function objCount = CountObjects(image)
    CC = bwconncomp(image); 
    objCount = CC.NumObjects();
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

    %TODO: subtract out last image too?
    
    imshow(image);
    
    %sharpen the image 
    sharpImage = imsharpen(image);
    imshow(sharpImage);
    title('sharp');
    %pause(1);
    
    %sharpen the reference image
    sharpRef = imsharpen(refImg);
 
    %find the edges of the image to subtract from
    %im = edge(image);
    im = edge(sharpImage);
    
    %find the edges of the reference image(image to subtract)
    rim = edge(sharpRef);
    
    %Enlarge all objects in reference image to get rid of more noise
    rim = EnlargeObjects(rim, 3);
    
    %return the result of the subtraction
    returnImage = im - rim;    
    
    %testing
    %TODO: change back to subtracted version
    returnImage = edge(im);
    
    %TODO:  test to see if imfill is worth while
    returnImage = imfill(returnImage, 'holes');
end

