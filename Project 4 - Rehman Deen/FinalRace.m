% Simulate Model for 60 Min
P4init;
simout = sim("P4_EV.slx",'StopTime',"3600");
X = simout.X.signals.values;
Y = simout.Y.signals.values;
t = simout.X.time;
genTrack;

% Race Stats
race = raceStat(X,Y,t,path,simout);
disp(race)