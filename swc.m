function [r, h] = swc(delta, step, cfg)
% THIS IS NOT WORKING PROPERLY!!!
    arguments
        delta (1,1) double {mustBePositive, mustBeFinite, mustBeInteger}
        step (1,1) double {mustBePositive, mustBeFinite, mustBeInteger}
        cfg.length (1,1) double {mustBePositive, mustBeFinite, mustBeInteger}
        cfg.theta (1,1) double {mustBePositive, mustBeFinite, mustBeReal}
        cfg.TR (1,1) double {mustBePositive, mustBeFinite, mustBeReal}
        cfg.Hz (1,1) double {mustBePositive, mustBeFinite, mustBeReal}
    end
    n = cfg.length;
    theta = cfg.theta;
    TR = cfg.TR;
    Hz = cfg.Hz;

    N = 1:step:n;
    h = 2 * delta * TR;
    w = 2 * pi * Hz;
    r = cos(theta) + (1/(h*w)) * cos(2*w*N*TR+theta) * sin(2*w*delta*TR) - (8 / (h^2 * w^2)) * cos(w*N*TR+theta) * sin(w*delta*TR)^2;
end