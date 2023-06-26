function COLOR = color_magic(color_scale)
%COLOR_MAGIC Summary of this function goes here
%   Detailed explanation goes here

RED = [0.64  .32 .38]; %red
ORANGE = [.85  .55 .42]; %orange
YELLOW = [.93  .79 .47]; %yellow
GREEN = [.53 .67 .33]; %green
BLUE = [ .29 .56 .74]; %blue
INDIGO = [.47  .79  .93]; %indigo
VIOLET =[.51  .28  .56]; %purple
   
if color_scale < 1/7
    DIFF = ORANGE - RED;
    COLOR = RED + 7*color_scale*DIFF;
elseif color_scale < 2/7
    DIFF = YELLOW - ORANGE;
    COLOR = ORANGE + 7*(color_scale-1/7)*DIFF;
elseif color_scale < 3/7
    DIFF = GREEN - YELLOW;
    COLOR = YELLOW + 7*(color_scale-2/7)*DIFF;
elseif color_scale < 4/7
    DIFF = BLUE - GREEN;
    COLOR = GREEN + 7*(color_scale-3/7)*DIFF;
elseif color_scale < 5/7
    DIFF = INDIGO - BLUE;
    COLOR = BLUE + 7*(color_scale-4/7)*DIFF; 
elseif color_scale < 6/7
    DIFF = VIOLET - INDIGO;
    COLOR = INDIGO + 7*(color_scale-5/7)*DIFF;       
elseif color_scale <= 7/7
    DIFF = RED-VIOLET;
    COLOR = VIOLET + 7*(color_scale-6/7)*DIFF;
end
end

