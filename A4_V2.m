clc;
clear;

% Equation explanation : http://www.rocketmime.com/rockets/rckt_eqn.html#Theory
% http://www.rocketmime.com/rockets/qref.html

mr = 738; % empty (no motor) mass of your rocket
mp = 3710 + 4900; % mass of propellant 
me = 12000; % loaded mass of your motor

boost_mass = mr + me - mp/2;
coast_mass = mr + me - mp;

g = 9.81; % acceleration of gravity = 9.81 m/s2
A = pi*1/4*(1.65)*(1.65); % rocket cross-sectional area in m2
Cd = 0.75; % drag coefficient = 0.75 for average rocket
r = 4.07E-03; %(1.17E+00 + 9.49E-02 + 4.07E-03 + 3.31E-04 + 1.68E-05 + 5.08E-07)/6  % air density = 1.22 kg/m3
t = 68; % motor burn time in seconds (NOTE: little t)
T = 264900; % motor thrust in Newtons (NOTE: big T) max : 1710
I = 239*264900; % motor impulse in Newton-seconds
v = 0; % burnout velocity in m/s
y1 = 0; % altitude at burnout
yc = 0; % coasting distance
% Note that the peak altitude is y1 + yc
ta = 0; % coasting time => delay time for motor

time_step = 0.01;

for n = 1:time_step:t
    k = 1/2*r*Cd*A;
    q = sqrt((T - boost_mass*g)/k);
    x = 2*k*q/boost_mass;
    dv = time_step*(T - boost_mass*g - k*v^2)/boost_mass; % calculating change in velocity
    v = v + dv; % Updated velocity
    y1 = y1 + v*time_step; %Distance traveled obtained by adding distance traveled in each time step to distance traveled till now
end

yc = (coast_mass/(2*k))*log((coast_mass*g + k*v*v)/(coast_mass*g));
peak_altitude = (y1 + yc)/1000;
sprintf('max altitude = %f kms', peak_altitude)