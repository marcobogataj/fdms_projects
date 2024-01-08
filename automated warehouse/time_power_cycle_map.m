clc; close all;
set(0, 'defaultAxesTickLabelInterpreter','latex'); 
set(0, 'defaultlegendInterpreter','latex')

%Stacker crane
%limits
limits.vx_max = 0.65;
limits.ax_max = 0.4;

limits.vy_max = 1;
limits.ay_max = 0.4;

figure; hold on;

%Choose: 0 - Time, 1 - Power
eval_what = 1; 


for Px = 0:1:44
    for Py = 0:1.5:13.5
        
        slot.Px = Px;
        slot.Py = Py;
        
        [mlc_x,mlc_y,t,mark] = EvalMovement(slot,limits);
        [Wm_x] = EvalPower(mlc_x);
        [Wm_y] = EvalPower(mlc_y);
        [E_tot,ED1,ES1] = power_consumption(Wm,t,'no title',0);

        if eval_what == 0
            var = 2*t+10;
        else
            var = E_tot;
        end

        %plot(x,y,'LineWidth',2)
        text(slot.Px+0.5,slot.Py+0.85,num2str(round(var,1)),...
            'VerticalAlignment','top','HorizontalAlignment','center','FontSize', 9,'Color',mark)
    end
end

%plot setup
title("Stacker crane movement")
xlabel('L [m]')
ylabel('H [m]')
grid on;
xlim([0,45])
ylim([0,15])
set(gca,'xtick',0:1:45)
set(gca,'ytick',0:1.5:15)
