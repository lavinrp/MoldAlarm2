
function tifFiles = GetTifFiles(filePath)
    tifFiles = dir(strcat(filePath,'/*.tif')); 
end