% Equation explanation : http://www.rocketmime.com/rockets/qref.html

m = 1.849% rocket mass in kg
g = 9.81 % acceleration of gravity = 9.81 m/s2
A = pi*1/2*(0.0678434)*(0.0678434) % rocket cross-sectional area in m2
Cd = 0.75 % drag coefficient = 0.75 for average rocket
r = 1.22 % air density = 1.22 kg/m3
t = 0.326 % motor burn time in seconds (NOTE: little t)
T = 982 % motor thrust in Newtons (NOTE: big T) max : 1710
I = 320 % motor impulse in Newton-seconds
v = 0% burnout velocity in m/s
y1 = 0% altitude at burnout
yc = 0% coasting distance
% Note that the peak altitude is y1 + yc
ta = 0% coasting time => delay time for motor
    
k = 1/2*r*Cd*A
q = sqrt((T - m*g)/k)
x = 2*k*q/m
t = I/T
v = q*(1 - exp(-x*t))/(1 + exp(-x*t))
y1 = (-m/(2*k))*log((T - m*g - k*v*v)/(T - m*g))
yc = (m/(2*k))*log((m*g + k*v*v)/(m*g))
peak_altitude = (y1 + yc)*3.28084
sprintf('max altitude = %f feet', peak_altitude)

% Result : 'max altitude = 1722.104332 feet'