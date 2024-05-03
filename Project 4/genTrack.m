% Track & Car Variables
% X = simout.X.signals.values;
% Y = simout.Y.signals.values;
% t = simout.X.time;

% Define Track Parameters
radius = 200; % Radius of Curved Sections
straight_length = 900; % Length of Straights
track_width = 15; % Width of Track

% Define Parameters for raceStat
path.l_st = 900;
path.radius = 200;
path.width = 15;

%%%%% Generate Curved Sections %%%%%

% Curved Section 1
theta1 = linspace(3*pi/2, pi/2, 1000);
x1 = radius * cos(theta1);
y1 = radius * sin(theta1);

% Curved Section 2
theta2 = linspace(-pi/2, -3*pi/2, 1000);
x2 = -radius * cos(theta2) + straight_length;
y2 = -radius * sin(theta2);

%%%%% Generate Straights %%%%%

% Straight 1
x3 = linspace(0,straight_length, 1000);
y3 = -200*ones(size(x3));

% Straight 2
x4 = linspace(straight_length,0, 1000);
y4 = 200*ones(size(x4));

%%%%% Track Combined %%%%%
x = [x3,fliplr(x2), (x4), fliplr(x1)];
y = [y3,fliplr(y2), (y4), fliplr(y1)];
x = x - x(1);
y = y - y(1);

%%%%% Plotting %%%%%

% Plot Track
figure;
hold on
set(gca, 'Color', [0, .5, .5]);
plot(x, y, 'LineWidth', 8,'Color',[ 0 0 0]);
xlim([-300, 1200]); 
ylim([-75, 500]);
hold off
title('Race Track');
xlabel('X-axis (meters)');
ylabel('Y-axis (meters)');
axis equal;  

% Plot Car
car_length = 50;  
car_width = 15;  
Xcar_vehicle = [0, car_length, car_length, 0, 0];
Ycar_vehicle = [-car_width/2, -car_width/2, car_width/2, car_width/2, -car_width/2];
i_orientation = 0; % Initial Car Orientation
vehicle = patch('XData', Xcar_vehicle, 'YData', Ycar_vehicle, 'FaceColor', 'r', 'EdgeColor', 'k');

% Car Orientation
for i = 2:length(X)
    set(vehicle, 'XData', Xcar_vehicle + X(i), 'YData', Ycar_vehicle + Y(i));
    if i > 2
        orientation = atan2(Y(i) - Y(i-1), X(i) - X(i-1));
    else
        orientation = atan2(Y(2) - Y(1), X(2) - X(1));
    end
    rotate(vehicle, [0, 0, 1], rad2deg(orientation - i_orientation), [X(i), Y(i), 0]);
    pause(0.001); 
end