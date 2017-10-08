function passed= ex3presub
display(' ');
display('Started ex3 pre-submission script.');
display(' ');
display('Disclaimer');
display('----------');
display('The purpose of this script is to make sure that your code is compliant');
display('with the exercise API and some of the requirements');
display('The script does not test the quality of your results.');
display('Don''t assume that passing this script will guarantee that you will get');
display('a high grade in the exercise');
display('- Closing all open figures (hope you don''t mind)...');
close all;

display(' ');
img = im2double(imread('monkey.jpg'));

display('Section 3.1');
display('-----------');
try 
  display('- Trying to create gaussian pyramid...')
  % Build a gaussian pyramid
  [gpyr,filter] = GaussianPyramid(img,3,3);
catch 
  display('- Failed (caught an exception, looks like runtime error).');
  passed=0;
  return;
end
  display('- Passed.');
try
  display('- Checking gaussian pyramid type and structure...');    
  w = whos('gpyr');    
  % Make sure its a cell array
  if ~strcmp('cell',w.class)
    display('- Failed. gpyr type is wrong. Expecting cell array.');
    passed=0;
    return
  end
  % Test cell array size
  if ~(all([3 1]==w.size))
    display('- Failed. pyramid cell size is wrong. Expecting size 3x1.');
     passed=0;
    return;
  end
  % Test gaussian blur filter size
  if ~(all([1 3] == size(filter)))
    display('- Failed. Wrong blur filter size. Expecting size 3x1.');
      passed=0;
    return;
  end 
catch  
  display('- Failed (caught an exception, looks like runtime error).');
    passed=0;
  return;
end
display('- Passed.');

try 
  display('- Trying to create laplacian pyramid...')
  % Build a laplacian pyramid
  [lpyr,filter] = LaplacianPyramid(img,3,3);
catch 
  display('- Failed (caught an exception, looks like runtime error).');
    passed=0;
  return;
end
  display('- Passed.');
try
  display('- Checking laplacian pyramid type and structure...');    
  w = whos('lpyr');    
  % Make sure its a cell array
  if ~strcmp('cell',w.class)
    display('- Failed. lpyr type is wrong. Expecting cell array.');
      passed=0;
    return
  end
  % Test cell array size
  if ~(all([3 1]==w.size))
    display('- Failed. pyramid cell size is wrong. Expecting size 3x1.');
     passed=0;
    return;
  end
  % Test laplacian blur filter size
  if ~(all([1 3] == size(filter)))
    display('- Failed. Wrong blur filter size. Expecting size 3x1.');
      passed=0;
    return;
  end 
catch  
  display('- Failed (caught an exception, looks like runtime error).');
  passed=0;return;
end
display('- Passed.');
display(' ');


display('Section 3.2');
display('-----------');
try 
  display('- Trying to reconstruct gaussian pyramid from laplacian pyramid... (quality not checked)')
  % Reconstruct the gaussian pyramid from the laplacian pyramid
  im = LaplacianToImage(lpyr, filter, ones(1,size(lpyr,1)));
catch 
  display('- Failed (caught an exception, looks like runtime error).');
   passed=0;
  return;
end
display('- Passed.');   
try
  display('- Checking reconstructed pyramid type and structure...');    
  w = whos('im');
  % Make sure its a cell array
  if ~strcmp('double',w.class)
    display('- Failed. image type is wrong. Expecting double.');
      passed=0;
    return
  end
  if ~(all(size(im) == size(img)))
    display('*** Warning: Reconstructed image size is different that original image size!');
  end
catch
  display('- Failed (caught an exception, looks like runtime error).');
    passed=0;
  return;
end
display('- Passed.');

display('Section 3.3');
display('-----------');
try
  display('- Trying to run im = renderPyramid(gpyr)...')
  im = renderPyramid(gpyr,2);
catch 
  display('- Failed (caught an exception, looks like runtime error).');
  passed=0;
  return;
end  
  display('- Checking im  structure...')
  if ~(all([400 600]==size(im)))
    display('*** Warning: im size is wrong. Expecting size 400x600.');
  end    
try    
  display('- Checking displayPyramid ...')
  displayPyramid(gpyr,2); 
catch
  display('- Failed (caught an exception, looks like runtime error).');
  passed=0;
  return;
end
display('- Passed.');
close all;
display(' ');


display('Section 4');
display('---------');
try    
  display('- Checking pyramidBlending...')
    
  % dummy run
  resBlend = pyramidBlending(img,img,zeros(400,400),3,3,5);

catch
  display('- Failed (caught an exception, looks like runtime error).');
  passed=0;return;
end
display('- Passed.'); 
    
try    
  display('- Checking blended image result  size...')
  if ~(all(size(resBlend) == size(img)))
    display('*** Warning: Blended image size differs from original image1/image2/mask size!');
  end    
catch
  display('- Failed (caught an exception, looks like runtime error).');
  passed=0;return;
end
display('- Passed.'); 

close all;
display(' ');

try    
  display('- Checking blendingExample1...')
  blendingExample1(); 
catch
  display('- Failed (caught an exception, looks like runtime error).');
  passed=0;return;
end
display('- Passed.');
close all;

try    
  display('- Checking blendingExample2...')
  blendingExample2();  
catch
  display('- Failed (caught an exception, looks like runtime error).');
  passed=0;return;
end
display('- Passed.');
close all;

close all;
display(' ');
display('- Pre-submission script done.');
display(' ');

display('Please go over the output and verify that there are no failures/warnings.');
display('Remember that this script tested only some basic technical aspects of your implementation');
display('It is your responsibility to make sure your results are actually correct and not only')
display('technically valid.');
passed=1;