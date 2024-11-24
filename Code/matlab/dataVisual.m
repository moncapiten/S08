dataPosition = '../../Data/';
filename = 'data001';

Rl  = 470;


% data import and creation of variance array
rawData = readmatrix(strcat(dataPosition, filename, '.txt'));

tt = rawData(:, 1);
vi = rawData(:, 2);
s_vi = repelem(0.02, length(vi));
vo = rawData(:, 3);
s_vo = repelem(0.02, length(vo));


%io = vo/R;

errorbar(tt, vi, s_vi, 'o', Color = '#0027BD');
hold on
errorbar(tt, vo, s_vo, 'o', Color = '#FF7F00');



grid on
grid minor
title('Amplitude of Supply Voltage and Output Voltage as function of Gate Voltage');
legend('$ V_{DD} $', '$ V_{DS} $', Location= 'ne', Interpreter = 'latex')
ylabel('Voltage [V]')
xlabel('Gate-Source Voltage [V]')
ylim([-0.1 5.1])

set(gca, 'FontSize', 14)

hold off



