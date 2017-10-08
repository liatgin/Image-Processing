function passed= ex1presub
display(' ');
display('Started ex1 pre-submission script.');
display(' ');
display('Disclaimer');
display('----------');
display('The purpose of this script is to make sure that your code is compliant');
display('with the exercise API and some of the requirements');
display('The script does not test the quality of your results.');
display('Don''t assume that passing this script will guarantee that you will get');
display('a high grade in the exercise');
display(' ');
display('- Closing all open figures (hope you don''t mind)...');
close all;

display(' ');
filename='monkey.jpg';
display('Section 3.1');
display('-----------');
try
    display('- Reading image...');
    imReadAndConvert(filename,1);
    imReadAndConvert(filename,2);
catch
    display('- Failed (caught an exception, looks like runtime error).');
    passed=0;
    return;
end
display('- Passed.');


display('Section 3.2');
display('-----------');
try
    display('- Displaying image...');
    imDisplay(filename, 1);
    imDisplay(filename, 2);
catch
    display('- Failed (caught an exception, looks like runtime error).');
    passed=0;
    return;
end
display('- Passed.');

display('Section 3.3');
display('-----------');
try
    display('- Transforming RGB to YIQ...');
    im = imReadAndConvert(filename, 2);
    imYIQ = transformRGB2YIQ(im);
    transformYIQ2RGB(imYIQ);
catch
    display('- Failed (caught an exception, looks like runtime error).');
    passed=0;
    return;
end
display('- Passed.');
close all;
display(' ');


display('Section 3.4');
display('-----------');
try
    display('- Histogram equalization...');
    imOrig = imReadAndConvert('Low Contrast.jpg', 2);
    [imEq, histOrig, histEq] = histogramEqualize(imOrig);
    imshow(imOrig);
    figure;
    imshow(imEq);
    input('Press any key to continue');
    [rows, cols]=size(histOrig);
    if (rows~=256 || cols~=1)
        display('wrong dimensions');
        error('wrong dimensions');
    end
    [rows, cols]=size(histEq);
    if (rows~=256 || cols~=1)
        display('wrong dimensions');
        error('wrong dimensions');
    end
    
catch
    display('- Failed');
    passed=0;
    return;
end
display('- Passed.');
close all;
display(' ');

display('Section 3.5');
display('-----------');
try
    display('- Image quantization...');
    imOrig = imReadAndConvert('jerusalem.jpg', 1);
    [imQuant, resError] = quantizeImage(imOrig, 6, 3);
    [rows, cols]=size(resError);
    if (rows~=3 || cols~=1)
        display('wrong dimensions');
        error('wrong dimensions');
    end
    [imQuant, resError] = quantizeImage(imOrig, 6, 500);
    imshow(imOrig);
    figure;
    imshow(imQuant);
    input('Press any key to continue');
catch
    display('- Failed');
    passed=0;
    return;
end
display('- Passed.');
close all;
display(' ');


display(' ');
display('- Pre-submission script done.');
display(' ');

display('Please go over the output and verify that there are no failures/warnings.');
display('Remember that this script tested only some basic technical aspects of your implementation');
display('It is your responsibility to make sure your results are actually correct and not only')
display('technically valid.');
passed=1;