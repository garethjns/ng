# ng
Make figures look nicer in MATLAB in as few keystrokes as possible. Applies regularly used improvements to figures, eg. enlarge, thicker lines, bold text, grid etc.) and more specific changes can be stored in templates. Requires MATLAB 2014b or newer. 

## Usage
 - Add top folder to MATLAB path.
 - If using an older setup (2014/2015 versions), make sure openGL is on before plotting any figures:
	````MATLAB
	ng.og
	````  
 - Plot figure:
	````MATLAB
	plot(1:10, 1:10)
	````
 - Convert to ng object, tempate (string) and figure handle are optional:
	````MATLAB
	g = ng(figHandle, template)
	````
 - Make other modifications to figure, handles are in
	````MATLAB
	g.h
	````
 - Save figure. If now file extension, saves .png .svg and .fig
	````MATLAB
	g.save('Figure.svg')
	````

### Templates
Additional templates can be defined in ng.templates.

### Other functions 

**ng.og** - checks openGL is set to harware, if available.  
**ng.hgx** - uses hgexport and savas to save .png, svg and/or .fig.  
**ng.getCols** - get MATLAB's 'DefaultAxesColorOrder'.  


## Example 1
````MATLAB
% Generate data
x = 1:100;
y1 = cumsum(randn(1,100)).*sin(1:100);
y2 = cumsum(randn(1,100));
y3 = cumsum(randn(1,100));
close all

% Plot figure
figure
plot(x, y1)
hold on
plot(x, y2)
plot(x, y3)
xlabel('Time')
ylabel('Value')
title('Figure')

% Modify
ng
````

![Original figure](https://github.com/garethjns/ng/blob/master/Images/Ex1_1.png)  
![Modified figure](https://github.com/garethjns/ng/blob/master/Images/Ex1_2.png)

## Example 2
````

noise = randn(1000,1000)/3;
y = ones(1000,1000)+noise.*0.1;
y2 = repmat(sin(linspace(1,32,1000)).*cos(logspace(1,2,1000)), 1000, 1);
y3 = repmat(sin(logspace(1,1.6,1000))'.*tanh(linspace(1,96,1000))', 1, 1000);

% Plot figure
close all
figure
imagesc(y.*y2.*y3)
colorbar
title('Pirates')
ylabel('Waves')
xlabel('More waves')

% Modify and apply template
g = ng('Small');

% Save .png, .fig and .svg
g.hgx('Figure')

% SHow the original figure
g.showOriginal
````

![Original figure](https://github.com/garethjns/ng/blob/master/Images/Ex2_1.png)  
![Modified figure](https://github.com/garethjns/ng/blob/master/Images/Ex2_2.png)

## Example 3
````
% Generate data
nG = 6;
nP = 56;
radius = linspace(1, 9, nP)';
offset = ((pi*0:(nG)));
thet = zeros(nP, nG);
for t = 1:nG
    thet(:,t) = linspace(offset(t), (offset(t)+pi/2)', nP)';
end
x1 = radius.*cos(thet) + randn(size(thet))/10;
x2 = radius.*sin(thet) + randn(size(thet))/10;

% Plot figure
figure
hold  on
for t = 1:nG
    scatter(x1(:,t), x2(:,t))
end
xlabel('x1')
ylabel('x2')
title('Spiral')
legend(num2str((1:nG)'))

% Modify figure 
g = ng;

% Compare to original
g.showOriginal;
````

![Original figure text](https://github.com/garethjns/ng/blob/master/Images/ex3_1.png)  
![Modified figure text](https://github.com/garethjns/ng/blob/master/Images/ex3_2.png)


