function mymap = ColorMap
% RED = [0.64  .08  .18]; %red
% ORANGE = [.85  .33  .10]; %orange
% YELLOW = [.93  .69  .13]; %yellow
% GREEN = [.47  .67  .19]; %green
% BLUE = [ 0  .45  .74]; %blue
% INDIGO = [.30  .75  .93]; %indigo
% VIOLET =[.49  .18  .56]; %purple
RED = [0.64  .32 .38]; %red
ORANGE = [.85  .55 .42]; %orange
YELLOW = [.93  .79 .47]; %yellow
GREEN = [.53 .67 .33]; %green
BLUE = [ .29 .56 .74]; %blue
INDIGO = [.47  .79  .93]; %indigo
VIOLET =[.51  .28  .56]; %purple
mymap = [];
for color_scale = 1:70
    
    if color_scale < 10
        DIFF = ORANGE - RED;
        mymap = [mymap; RED + (.1*color_scale)*DIFF];
    elseif color_scale < 20
        DIFF = YELLOW - ORANGE;
        mymap = [mymap; ORANGE + (.1*(color_scale-10))*DIFF];
    elseif color_scale < 30
        DIFF = GREEN - YELLOW;
        mymap = [mymap; YELLOW + (.1*(color_scale-20))*DIFF];
    elseif color_scale < 40
        DIFF = BLUE -GREEN;
        mymap = [mymap; GREEN + (.1*(color_scale-30))*DIFF];
    elseif color_scale < 50
        DIFF = INDIGO - BLUE;
        mymap = [mymap; BLUE + (.1*(color_scale-40))*DIFF]; 
    elseif color_scale < 60
        DIFF = VIOLET - INDIGO;
        mymap = [mymap; INDIGO + (.1*(color_scale-50))*DIFF];       
    elseif color_scale < 70
        DIFF = RED-VIOLET;
        mymap = [mymap; VIOLET + (.1*(color_scale-60))*DIFF];
    end
    
end



end
    

