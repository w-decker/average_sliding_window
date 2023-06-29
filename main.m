Hz = .02;
w = 2 * pi * Hz;
k = 0:(2^14);
TR = 2.0;
theta = .1 * pi; % phase difference

% The sqrt(2) normalizes the variances of `x` and `y` to 1 *in the limit*.
% For short sequences, this normalization gets you close to one.
x = sqrt(2) * cos(w * k * TR);
y = sqrt(2) * cos(w * k * TR  + theta);
disp([var(x), var(y)])


% When variance = 1, covariance == correlation (i.e., the data are already
% standardized, and correlation is a standardized covariance)

delta = 12;
h = 2 * delta * TR;
Cxy = zeros(1, length(x));
for n = delta:(length(x) - delta)
    a = n - delta + 1;
    b = n + delta;
    Cxy(n) = (TR/h) * sum((x(a:b) .* y(a:b)) - mean(x(a:b))*mean(y(a:b)));
end

n = 1:length(x);
CxyClosed = cos(theta) + (1/(h*w)) * cos(2*w*n*TR+theta) * sin(2*w*delta*TR) - (8 / (h^2 * w^2)) * cos(w*n*TR+theta) * sin(w*delta*TR)^2;

% This formula is encapsulated in the function `swc()`.
CxyClosed2 = swc(delta, 1, length=length(x), theta=theta, TR=TR, Hz=Hz);
isequal(CxyClosed, CxyClosed2);

% Solution from the loop and the "closed form" are very similar over the
% valid range
disp(corr(Cxy(delta:(length(x)-delta))', CxyClosed(delta:(length(x)-delta))'))


%% Replicate Figure 1
tiledlayout(2, 2)

% Panel A
Hz = 0.025;
nt = 120;
w = 2 * pi * Hz;
k = (1:nt) - 1;
TR = 1.0;
theta = acos(.2); % phase difference

x = cos(w * k * TR);
x = x / std(x);
y = cos(w * k * TR  + theta);
y = y / std(y);

nexttile
plot(k', [x',y'])
legend(["x","y"])
xlabel("Time [sec]")
ylabel("cosine amplitude")



% Panel B
r = zeros(60, nt);
h = zeros(60, 1);
for delta = 1:60
    % [r(delta, :), h(delta)] = swc(delta, length=nt, theta=theta, TR=TR, Hz=Hz);
    [r(delta, :), h(delta)] = swc_loop(x(:), y(:), delta, TR);
end
h = repmat(h, 1, nt);
z = r ~= 0;

nexttile
scatter(h(z), r(z))
yline(.2)
xlabel("h (window size)")
ylabel("covariance")


% Panel C
r1 = r(24, :);
z = r1 ~= 0;
G = cell(1,nnz(z));
for g = 1:nnz(z)
    G{g} = conv(r1(z), ones(1, g)/g, 'valid');
end
nc = cellfun(@numel, G);
g = repelem(1:nnz(z), nc);

nexttile
scatter(g, cell2mat(G)')
xlim([0, 120]);
ylim([-.4, .6])
yline(.2)
xlabel("g (averaging length)")
ylabel("covariance")


% Panel D
X = cell(1, 60);
g = 20;
for i = 1:60
    z = r(i, :) ~= 0;
    X{i} = conv(r(i, z), ones(1, g)/g, 'valid');
end

h = (1:60) * 2;
z = ~cellfun('isempty', X);
h = h(z);
X = X(z);
nc = cellfun(@numel, X);
h = repelem(h, nc);

nexttile
scatter(h, cell2mat(X)')
xlim([0, 120]);
ylim([-.4, .6])
yline(.2)
xlabel("h (window size)")
ylabel("covariance")
