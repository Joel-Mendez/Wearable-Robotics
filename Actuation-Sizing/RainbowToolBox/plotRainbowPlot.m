function plotRainbowPlot(PLOT,amputation_side,SEG_INDEX,plot_iteration,plot_contralateral,mymap)

%% Leg Plot
LhipX = PLOT.p_LthighX(SEG_INDEX(1):SEG_INDEX(end)); LhipY = PLOT.p_LthighY(SEG_INDEX(1):SEG_INDEX(end)); LhipZ = PLOT.p_LthighZ(SEG_INDEX(1):SEG_INDEX(end)); 
LkneeX = PLOT.p_LshankX(SEG_INDEX(1):SEG_INDEX(end));LkneeY = PLOT.p_LshankY(SEG_INDEX(1):SEG_INDEX(end)); LkneeZ = PLOT.p_LshankZ(SEG_INDEX(1):SEG_INDEX(end)); 
LankleX = PLOT.p_LfootX(SEG_INDEX(1):SEG_INDEX(end)); LankleY = PLOT.p_LfootY(SEG_INDEX(1):SEG_INDEX(end)); LankleZ = PLOT.p_LfootZ(SEG_INDEX(1):SEG_INDEX(end)); 
LheelX = PLOT.p_LheelX(SEG_INDEX(1):SEG_INDEX(end)); LheelY = PLOT.p_LheelY(SEG_INDEX(1):SEG_INDEX(end)); LheelZ = PLOT.p_LheelZ(SEG_INDEX(1):SEG_INDEX(end)); 
LtoeX = PLOT.p_LtoeX(SEG_INDEX(1):SEG_INDEX(end)); LtoeY = PLOT.p_LtoeY(SEG_INDEX(1):SEG_INDEX(end)); LtoeZ = PLOT.p_LtoeZ(SEG_INDEX(1):SEG_INDEX(end)); 

RhipX = PLOT.p_RthighX(SEG_INDEX(1):SEG_INDEX(end)); RhipY = PLOT.p_RthighY(SEG_INDEX(1):SEG_INDEX(end)); RhipZ = PLOT.p_RthighZ(SEG_INDEX(1):SEG_INDEX(end)); 
RkneeX = PLOT.p_RshankX(SEG_INDEX(1):SEG_INDEX(end)); RkneeY = PLOT.p_RshankY(SEG_INDEX(1):SEG_INDEX(end)); RkneeZ = PLOT.p_RshankZ(SEG_INDEX(1):SEG_INDEX(end)); 
RankleX = PLOT.p_RfootX(SEG_INDEX(1):SEG_INDEX(end)); RankleY = PLOT.p_RfootY(SEG_INDEX(1):SEG_INDEX(end)); RankleZ = PLOT.p_RfootZ(SEG_INDEX(1):SEG_INDEX(end)); 
RheelX = PLOT.p_RheelX(SEG_INDEX(1):SEG_INDEX(end)); RheelY = PLOT.p_RheelY(SEG_INDEX(1):SEG_INDEX(end)); RheelZ = PLOT.p_RheelZ(SEG_INDEX(1):SEG_INDEX(end)); 
RtoeX = PLOT.p_RtoeX(SEG_INDEX(1):SEG_INDEX(end)); RtoeY = PLOT.p_RtoeY(SEG_INDEX(1):SEG_INDEX(end)); RtoeZ = PLOT.p_RtoeZ(SEG_INDEX(1):SEG_INDEX(end)); 
   
for i = 1:length(LhipX)
    if mod(i,plot_iteration) == 0 
        color_scale = (i)/(1+SEG_INDEX(end) - SEG_INDEX(1))
        color = color_magic_v2(color_scale);
        
        if amputation_side == "L"
            plot3([LhipX(i);LkneeX(i)],[LhipY(i);LkneeY(i)],[LhipZ(i);LkneeZ(i)],'Linewidth',2,'Color',color) %Thigh
            plot3([LkneeX(i);LankleX(i)],[LkneeY(i);LankleY(i)],[LkneeZ(i);LankleZ(i)],'Linewidth',2,'Color',color) %Shank
            plot3([LankleX(i);LheelX(i)],[LankleY(i);LheelY(i)],[LankleZ(i);LheelZ(i)],'Linewidth',2,'Color',color) %Foot to Heel
            plot3([LankleX(i);LtoeX(i)],[LankleY(i);LtoeY(i)],[LankleZ(i);LtoeZ(i)],'Linewidth',2,'Color',color) %Foot to Toe
            plot3([LheelX(i);LtoeX(i)],[LheelY(i);LtoeY(i)],[LheelZ(i);LtoeZ(i)],'Linewidth',2,'Color',color) %Heel to Toe 
        elseif amputation_side == "R"
            plot3([RhipX(i);RkneeX(i)],[RhipY(i);RkneeY(i)],[RhipZ(i);RkneeZ(i)],'Linewidth',2,'Color',color) %Thigh
            plot3([RkneeX(i);RankleX(i)],[RkneeY(i);RankleY(i)],[RkneeZ(i);RankleZ(i)],'Linewidth',2,'Color',color) %Shank
            plot3([RankleX(i);RheelX(i)],[RankleY(i);RheelY(i)],[RankleZ(i);RheelZ(i)],'Linewidth',2,'Color',color) %Foot to Heel
            plot3([RankleX(i);RtoeX(i)],[RankleY(i);RtoeY(i)],[RankleZ(i);RtoeZ(i)],'Linewidth',2,'Color',color) %Foot to Toe
            plot3([RheelX(i);RtoeX(i)],[RheelY(i);RtoeY(i)],[RheelZ(i);RtoeZ(i)],'Linewidth',2,'Color',color) %Heel to Toe
        end

%         colormap(mymap)
        daspect([1 1 1])
    end
end

if plot_contralateral == 1
    for i = 1:length(LhipX)
        if mod(i,plot_iteration) == 0 
            color_scale = (i)/(SEG_INDEX(end) - SEG_INDEX(1));
            
            
            color = color_magic_v2(color_scale);

            if amputation_side == "R"
                plot3([LhipX(i);LkneeX(i)],[LhipY(i);LkneeY(i)],[LhipZ(i);LkneeZ(i)],'Linewidth',2,'Color',color) %Thigh
                plot3([LkneeX(i);LankleX(i)],[LkneeY(i);LankleY(i)],[LkneeZ(i);LankleZ(i)],'Linewidth',2,'Color',color) %Shank
                plot3([LankleX(i);LheelX(i)],[LankleY(i);LheelY(i)],[LankleZ(i);LheelZ(i)],'Linewidth',2,'Color',color) %Foot to Heel
                plot3([LankleX(i);LtoeX(i)],[LankleY(i);LtoeY(i)],[LankleZ(i);LtoeZ(i)],'Linewidth',2,'Color',color) %Foot to Toe
                plot3([LheelX(i);LtoeX(i)],[LheelY(i);LtoeY(i)],[LheelZ(i);LtoeZ(i)],'Linewidth',2,'Color',color) %Heel to Toe
            elseif amputation_side == "L"
                plot3([RhipX(i);RkneeX(i)],[RhipY(i);RkneeY(i)],[RhipZ(i);RkneeZ(i)],'Linewidth',2,'Color',color) %Thigh
                plot3([RkneeX(i);RankleX(i)],[RkneeY(i);RankleY(i)],[RkneeZ(i);RankleZ(i)],'Linewidth',2,'Color',color) %Shank
                plot3([RankleX(i);RheelX(i)],[RankleY(i);RheelY(i)],[RankleZ(i);RheelZ(i)],'Linewidth',2,'Color',color) %Foot to Heel
                plot3([RankleX(i);RtoeX(i)],[RankleY(i);RtoeY(i)],[RankleZ(i);RtoeZ(i)],'Linewidth',2,'Color',color) %Foot to Toe
                plot3([RheelX(i);RtoeX(i)],[RheelY(i);RtoeY(i)],[RheelZ(i);RtoeZ(i)],'Linewidth',2,'Color',color) %Heel to Toe
            end

%             colormap(mymap)
            daspect([1 1 1])
            view([0,-90,0])
        end
    end
    zlim([0 1.2])
    
end
    












