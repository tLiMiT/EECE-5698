% EECE5698 Foundations of Visualization
% Tim Liming
% Hw 2, problem 3

% Code taken from:
% http://www.easyrgb.com/index.php?X=MATH

% Given RGB color
R = 137;    % R from 0 to 255
G = 56;     % G from 0 to 255
B = 146;    % B from 0 to 255

RGB = [R G B];
display(RGB);

% scale to [0, 1]
var_R = (R/255);    % normalized R
var_G = (G/255);    % normalized G
var_B = (B/255);    % normalized B

normalizedRGB = [var_R var_G var_B];
display(normalizedRGB);

%% RGB --> CIE XYZ

if (var_R > 0.04045) 
    var_R = ((var_R+0.055)/1.055)^2.4;
else
    var_R = var_R/12.92;
end
    
if (var_G > 0.04045) 
    var_G = ((var_G+0.055)/1.055)^2.4;
else
    var_G = var_G/12.92;
end
    
if (var_B > 0.04045) 
    var_B = ((var_B+0.055)/1.055)^2.4;
else
    var_B = var_B/12.92;
end

var_R = var_R*100;
var_G = var_G*100;
var_B = var_B*100;

% Observer. = 2°, Illuminant = D65
X = var_R*0.4124+var_G*0.3576+var_B*0.1805;
Y = var_R*0.2126+var_G*0.7152+var_B*0.0722;
Z = var_R*0.0193+var_G*0.1192+var_B*0.9505;

CIE_XYZ = [X Y Z];
display(CIE_XYZ);

%% XYZ --> CIE Yxy

% X from 0 to 95.047       Observer. = 2°, Illuminant = D65
% Y from 0 to 100.000
% Z from 0 to 108.883

% Y = Y;
x = X/(X+Y+Z);
y = Y/(X+Y+Z);

CIE_xyY = [x y Y];
display(CIE_xyY);

%% RGB --> CMYK

%  RGB --> CMY

% RGB values from 0 to 255
% CMY results from 0 to 1

C = 1-(R/255);
M = 1-(G/255);
Y = 1-(B/255);

% CMY --> CMYK

% CMYK and CMY values from 0 to 1

var_K = 1;

if (C < var_K)   
    var_K = C;
end

if (M < var_K)   
    var_K = M;
end

if (Y < var_K)   
    var_K = Y;
end

if (var_K == 1) % Black
   C = 0;
   M = 0;
   Y = 0;
else
   C = (C-var_K)/(1-var_K);
   M = (M-var_K)/(1-var_K);
   Y = (Y-var_K)/(1-var_K);
end

K = var_K;

CMYK = [C M Y K];
display(CMYK);

%% RGB --> HSV

var_R = (R/255);    % RGB from 0 to 255
var_G = (G/255);
var_B = (B/255);

var_Min = min([var_R var_G var_B]);     % Min. value of RGB
var_Max = max([var_R var_G var_B]);  	% Max. value of RGB
del_Max = var_Max-var_Min;              % Delta RGB value 

V = var_Max;

if (del_Max == 0)       % This is a gray, no chroma...
   H = 0;               % HSV results from 0 to 1
   S = 0;
else                    % Chromatic data...
   S = del_Max/var_Max;

   del_R = (((var_Max-var_R)/6)+(del_Max/2))/del_Max;
   del_G = (((var_Max-var_G)/6)+(del_Max/2))/del_Max;
   del_B = (((var_Max-var_B)/6)+(del_Max/2))/del_Max;

   if (var_R == var_Max) 
       H = del_B-del_G;
   elseif (var_G == var_Max) 
           H = (1/3)+del_R-del_B;
   elseif (var_B == var_Max) 
           H = (2/3)+del_G-del_R;
   end
   
   if (H < 0) 
       H = H+1;
   end
   
   if (H > 1) 
       H = H-1;
   end
end % if-else

HSV = [H S V];
display(HSV);

%%  RGB --> HSL

var_R = (R/255);    % RGB from 0 to 255
var_G = (G/255);
var_B = (B/255);

var_Min = min([var_R var_G var_B]);   % Min. value of RGB
var_Max = max([var_R var_G var_B]);   % Max. value of RGB
del_Max = var_Max-var_Min;          % Delta RGB value

L = (var_Max+var_Min)/2;

if (del_Max == 0)       % This is a gray, no chroma...
    H = 0;              % HSL results from 0 to 1
    S = 0;
else                    % Chromatic data...
    if (L < 0.5) 
        S = del_Max/(var_Max+var_Min);
    else
        S = del_Max/(2-var_Max-var_Min);
    end

    del_R = (((var_Max-var_R)/6)+(del_Max/2))/del_Max;
    del_G = (((var_Max-var_G)/6)+(del_Max/2))/del_Max;
    del_B = (((var_Max-var_B)/6)+(del_Max/2))/del_Max;

    if (var_R == var_Max) 
        H = del_B-del_G;
    elseif ( var_G == var_Max ) 
        H = (1/3)+del_R-del_B;
    elseif (var_B == var_Max) 
        H = (2/3)+del_G-del_R;
    end

   if (H < 0) 
       H = H+1;
   end
   
   if (H > 1) 
       H = H-1;
   end
end % if-else
       
HSL = [H S L];
display(HSL);
