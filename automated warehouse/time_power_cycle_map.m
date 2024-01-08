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
eval_what = 0; 


for Px = 0:1:44
    for Py = 0:1.5:13.5
        
        slot.Px = Px;
        slot.Py = Py;
        
        [mlc_x,mlc_y,t,mark] = EvalMovement(slot,limits);
        [Wm_x,Cm_x] = EvalPowerHorizontal(mlc_x,t);
        [Wm_y,Cm_y] = EvalPowerVertical(mlc_y,t);

        Wm=Wm_x+Wm_y;

        [E_J,ED1,ES1] = power_consumption(Wm,t,'no title',0); %E_tot in J
        E_Wh = E_J*1/3600;
        
        if isnan(E_Wh)
            E_Wh = 0;
        end

        if eval_what == 0
            var = 2*t+10;
        else
            var = E_Wh;
            mark = [E_Wh/16, 15/(15+E_Wh*5), 0];
        end

        %plot(x,y,'LineWidth',2)
        text(slot.Px+0.5,slot.Py+0.85,num2str(round(var,2)),...
            'VerticalAlignment','top','HorizontalAlignment','center','FontSize', 8,'Color',mark)
    end
end

%plot setup
if eval_what == 1
    title("Wasted energy [Wh]")
else
    title("Time cycle map [seconds]")
end

xlabel('L [m]')
ylabel('H [m]')
grid on;
xlim([0,45])
ylim([0,15])
set(gca,'xtick',0:1:45)
set(gca,'ytick',0:1.5:15)
hold off;

%% debugging
tx = mlc_x.moto.time;
ty = mlc_y.moto.time;

figure
plot(tx,Cm_x);
title('Coppia motore - Horizontal')
xlabel('t [s]')
ylabel('Cm [Nm]')
legend;

figure
plot(ty,Cm_y);
title('Coppia motore - Vertical')
xlabel('t [s]')
ylabel('Cm [Nm]')
legend;
