function [img] = LaplacianToImage(lpyr ,filter, coeffMultVec)
img = [];    
coeffSize = size(coeffMultVec);
pyrSize = size(lpyr);    
pyrSize = pyrSize(1);
img = lpyr{pyrSize} * coeffMultVec(pyrSize);
for i = (pyrSize - 1):-1:1
   img = Expand(img, filter) + lpyr{i} * coeffMultVec(i);
end
end






