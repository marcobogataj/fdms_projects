function [Wm] = EvalPowerVertical(mlc)
%EVALPOWER
    
    y = mlc.moto.data{1}.v;
    yp = mlc.moto.data{2}.v;
    ypp = mlc.moto.data{3}.v;
    ty = mlc.moto.time;

    Wm = 0;

end

