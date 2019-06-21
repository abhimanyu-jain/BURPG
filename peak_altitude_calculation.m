clear;
clc;

% Equation explanation : http://www.rocketmime.com/rockets/qref.html

mr = 227 % empty (no motor) mass of your rocket
me = 593 % loaded mass of your motor
mp = % mass of the propellant
g = 9.81 % acceleration of gravity = 9.81 m/s2
A = pi*1/4*(0.56)*(0.56) % rocket cross-sectional area in m2
Cd = 0.75 % drag coefficient = 0.75 for average rocket
r = 1.22 % air density = 1.22 kg/m3
t = 0 % motor burn time in seconds (NOTE: little t)
T = 217000 + 72000 % motor thrust in Newtons (NOTE: big T) max : 1710
I = 756000 + 3850000 % motor impulse in Newton-seconds
v = 0% burnout velocity in m/s
y1 = 0% altitude at burnout
yc = 0% coasting distance
% Note that the peak altitude is y1 + yc
ta = 0% coasting time => delay time for motor

[y1, yc, v] = altitdue_1st_stage(me, mr, mp, A, r, T, I, Cd, g)

mr = 227 % empty (no motor) mass of your rocket
me = 3019 % loaded mass of your motor
mp = 1970 % mass of the propellant
g = 9.81 % acceleration of gravity = 9.81 m/s2
A = pi*1/4*(0.56)*(0.56) % rocket cross-sectional area in m2
Cd = 0.75 % drag coefficient = 0.75 for average rocket
r = 1.22 % air density = 1.22 kg/m3
T = 72000 % motor thrust in Newtons (NOTE: big T) max : 1710
I = 3850000 % motor impulse in Newton-seconds

[y2, yd] = altitude_upper_stage(me, mr, mp, A, r, T, I, Cd, g, v)

peak_altitude = (y1 + y2 + yd)
sprintf('max altitude = %f km', peak_altitude/1000)
sprintf('max altitude = %f feet', peak_altitude*3.28084)
% Result : 'max altitude = 1722.104332 feet'

function [y1, yc, v] = altitdue_1st_stage(me, mr, mp, A, r, T, I, Cd, g)
    m_avg = mr +me -mp/2
    m_coast = mr + me - mp
    k = 1/2*r*Cd*A
    q = sqrt((T - m_avg*g)/k)
    x = 2*k*q/m_avg
    t = I/T
    v = q*(1 - exp(-x*t))/(1 + exp(-x*t))
    y1 = (-m_avg/(2*k))*log((T - m_avg*g - k*v*v)/(T - m_avg*g))
    yc = (m_coast/(2*k))*log((m_coast*g + k*v*v)/(m_coast*g))
end

function [y1, yc] = altitude_upper_stage(me, mr, mp, A, r, T, I, Cd, g, v0)
    m_avg = mr +me -mp/2
    m_coast = mr + me - mp
    k = 1/2*r*Cd*A
    q = sqrt((T - m_avg*g)/k)
    x = 2*k*q/m_avg
    t = I/T
    s = (q + v0)/(q - v0)
    v = q*(s - exp(-x*t))/(s + exp(-x*t))
    y1 = (-m_avg/(2*k))*log((T - m_avg*g - k*v*v)/(T - m_avg*g - k*v0*v0))
    yc = (m_coast/(2*k))*log((m_coast*g + k*v*v)/(m_coast*g))
end
