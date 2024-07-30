%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Redondo Optics Inc.
%   FBGT-200-1063 Interrogator
%   Data reading and Processing (FBGT Mofis)
%   Lab|Sensores
%   30/07/24
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; close all; clear;

%% Define parameters
file_name = 'Proc_2024jul29_16_51_31.bin';  % Path of binary file
fs = 97.41;                                 % Sampling rate

%% Calculate constants
ts = 1/fs;                                  % Sampling period

%% Import data
% Define dir and file size
file_info = dir(file_name);
file_size = file_info.bytes;

% Read data as column vector single-precision big-endian
fid = fopen(file_name,'r','b');                         % Open file
data = fread(fid,[6 file_size/6],'single=>double')';    % Read file    
fclose(fid);                                            % Close file

%% Process data 
% Remove columns with [Inf,-Inf] values
data=data(:,~all(isinf(data)));

%% Create time axis
t = 0:ts:ts*(size(data,1)-1);

%% Plot data
figure;
plot(t,data,'-','Linewidth',1.3);
ylabel('Voltage (V)');
xlabel('Time (s)');
legend('Ch1','Ch2')
box on;
grid on;
