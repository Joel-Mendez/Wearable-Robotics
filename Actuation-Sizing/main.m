clear vars
clear all
close all
clc

%% 1 - Motor Electromechanical Parameters

%------------------------------------------------------------------------%
%      Maxon Motors EC 4-pole 22 24V data (120W) - 175g                  %
%------------------------------------------------------------------------%
vel_no_load = rpm2rads(16700);    % RPM
T_stall  = 3.22;        % Nm
Jm = 3.3300e-06;        % [kgm^2]
km = 13.6 *10^-3;       % [Nm/A]
kn = rpm2rads(700);               % [RPM/V]
DNDM = rpm2rads(5.21);            % [RPM/mNm]
U = 24;                 % [V] rated voltage
Rm = .102;              % [Ohm]
Rth_w = 7.4;            % [K/W]
Rth_h = 0.21;           % [K/W]
Tw = 2.11;              % [s]
Th = 1180;              % [s]
i_nom = 7.58;           % [A]
L_motor = .0163*1e-3;   % [H]
i_no_load = 0.728;      % [A]
TempA = 293;            % [K}
TempWMax = 150 +273;    % [K]

%% 2 - Extract aknkle joint torque/speed requirements from human biomechanics 

% load data
load ankle_walk.mat

% Parameters
KP_VALUES = [0:50:500];
KS_VALUES = [100:50:1200];
N_VALUES = [100:100:1000];
EQPT_VALUES = deg2rad([0:1:10]);
nValues = length(KP_VALUES)*length(KS_VALUES)*length(N_VALUES)*length(EQPT_VALUES);
COT = zeros(length(KP_VALUES),length(KS_VALUES),length(EQPT_VALUES),length(N_VALUES));

% Define body mass
BW = 70; % [kg]

% Define sride time
stride_duration = 1.2; %[s]

% Define time vector 
time = linspace(0,1.2,1001);

% Find ankle torque in Nm
torque_ankle = torque;

% Find ankle velocity rad/s
vel_ankle = dfdx(time,pos); 

% Find ankle acceleration ras/s^2
acc_ankle = dfdx(time,vel_ankle);

% figure, 
% subplot(311),plot(time, vel_ankle), xlabel('time [s]'), ylabel('velocity [deg/s]')
% subplot(312),plot(time, acc_ankle), xlabel('time [s]'), ylabel('acceleration [deg/s^2]')
% subplot(313),plot(time, torque_ankle), xlabel('time [s]'), ylabel('torque [Nm]')

%% 3 - Looop
count = 1;
for nKP = [1:length(KP_VALUES)] % parallel spring
    kp = KP_VALUES(nKP);
    for nEQ = [1:length(EQPT_VALUES)]
        eqP = EQPT_VALUES(nEQ);
        dP = pos-eqP;
        if dP<0
            dP = 0;
        end
        torqueP = -kp*(dP); %torque component from parallel spring
        for nKS = [1:length(KS_VALUES)] % series spring
            ks = KS_VALUES(nKS);
            torqueS = torque - torqueP; %torque component from series spring
            dS = -torqueS/ks;
            posG = pos + dS; %angular displacement at g earbox output %CHECK - DOES IT HAVE TO BE + TORQUES/KS???
            for nN = [1:length(N_VALUES)] %transmission ratio (where N = N2/N1)
                N = N_VALUES(nN);
                posM = N*posG;
                velM = dfdx(time,posM);
                accM = dfdx(time,velM);
                Tout = torqueS/N;
                Jt = Jm*1;
                Tm = (Tout + (Jm+Jt)*accM)/.9 ; 
                % dIdt = -(Rm/L_motor)*i_no_load;
                dIdt = dfdx(time,Tm)/km;
                P = Tm.*velM + Rm.*(Tm/km).^2 + L_motor.*(Tm/km).*(dIdt);
                Pmax = vel_no_load - (vel_no_load/T_stall)*Tm;
                Irms = rms(Tm/km);
                TempW = (Irms^2)*Rm*(Rth_w + Rth_h)+TempA;
                PLimit = max(P)>Pmax;

                E = trapz(stride_duration,P);
                cot = E/(.5*BW*1.4);
                COT(nKP,nKS,nEQ,nN)=cot;
                VEL(nKP,nKS,nEQ,nN)=max(velM);
                TRQ(nKP,nKS,nEQ,nN)=max(Tm);
                PWR(nKP,nKS,nEQ,nN)=sum(PLimit);
                TEMP(nKP,nKS,nEQ,nN)=TempW;
            end
        end
    end
end

%% Optimal Configuration
COT2 = COT;
OptimalFound = 0;
while OptimalFound == 0
    optimalCOT = min(min(min(min(COT2))));
    minIDX = find(COT2==optimalCOT,1);
    if (VEL(minIDX)>vel_no_load)||TRQ(minIDX)>T_stall||PWR(minIDX)||(TEMP(minIDX)>TempWMax) %Speed, Torque and Power Check
        COT2(minIDX) = 9999999;
    else
        OptimalFound = 1;
    end
    
end

[kpIDX,ksIDX,eqIDX,nIDX] = ind2sub(size(COT),minIDX);
optimalKP = KP_VALUES(kpIDX);
optimalKS = KS_VALUES(ksIDX);
optimalEQ = EQPT_VALUES(eqIDX);
optimalN = N_VALUES(nIDX);

%% Plotter
%KS vs N
figure, 
subplot(131)
contourf(log(squeeze(COT(3,:,1,:)))) %KP = 100 N/m
axis square
ylabel('KS (N/m)')
xlabel('N')
xticks([1 5 10])
xticklabels({'100','500','1000'})
yticks([3 7 11 15 19 23])
yticklabels({'200','400','600','800','1000','1200'})
caxis([2 9])
colormap(ColorMap)

subplot(132)
contourf(log(squeeze(COT(6,:,1,:)))) %KP = 250 N/m
axis square
ylabel('KS (N/m)')
xlabel('N')
xticks([1 5 10])
xticklabels({'100','500','1000'})
yticks([3 7 11 15 19 23])
yticklabels({'200','400','600','800','1000','1200'})
caxis([2 9])
colormap(ColorMap)

subplot(133)
contourf(log(squeeze(COT(11,:,1,:))))%KP = 500 N/m
axis square
ylabel('KS (N/m)')
xlabel('N')
xticks([1 5 10])
xticklabels({'100','500','1000'})
yticks([3 7 11 15 19 23])
yticklabels({'200','400','600','800','1000','1200'})
caxis([2 9])
colormap(ColorMap)

%% KSvsN (Varying Equilibrium Point)
%KP vs N
figure, 
subplot(131)
contourf(log(squeeze(COT(:,4,1,:)))) %EqPoint = 0 deg
axis square
ylabel('KP (N/m)')
xlabel('N')
xticks([1 5 10])
xticklabels({'100','500','1000'})
yticks([3 7 11 15 19 23])
yticklabels({'200','400','600','800','1000','1200'})
caxis([2 9])
colormap(ColorMap)

subplot(132)
contourf(log(squeeze(COT(:,9,1,:)))) %EqPoint = 5 deg
axis square
ylabel('KP (N/m)')
xlabel('N')
xticks([1 5 10])
xticklabels({'100','500','1000'})
yticks([3 7 11 15 19 23])
yticklabels({'200','400','600','800','1000','1200'})
caxis([2 9])
colormap(ColorMap)

subplot(133)
contourf(log(squeeze(COT(:,19,1,:))))%EqPoint = 10 deg
axis square
ylabel('KP (N/m)')
xlabel('N')
xticks([1 5 10])
xticklabels({'100','500','1000'})
yticks([3 7 11 15 19 23])
yticklabels({'200','400','600','800','1000','1200'})
caxis([2 9])
colormap(ColorMap)

