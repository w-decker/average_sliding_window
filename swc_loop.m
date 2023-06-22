function [r,h] = swc_loop(x, y, delta, TR)
    h = 2 * delta * TR;
    r = zeros(1, length(x));
    for n = delta:(length(x) - delta)
        a = n - delta + 1;
        b = n + delta;
        r(n) = (TR/h) * sum((x(a:b) .* y(a:b)) - mean(x(a:b))*mean(y(a:b)));
    end
end