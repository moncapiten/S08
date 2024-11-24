clear all;

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

%thr1 = [1 25];
%thr2 = [45 length(vi)];



%errorbar(tt, vi, s_vi, 'o', Color = '#0027BD');

dVo = diff(vo);
dtt = diff(tt);
dV = dVo ./ dtt;

a = [];
thr = 0.1;

while length(a) < 2
    is = [];
    a = [];
    for i = 1:length(dV)
        if dV(i) < -1+thr && dV(i) > -1-thr
            is = [is, i];
            a = [a, dV(i)];
            
        end
    end
    thr = thr + 0.1;
    if thr > 5
        break
    end
end



%"#cc0001" "#fb940b" "#ffff01" "#01cc00" "#03c0c6" "#0000fe" "#762ca7" "#fe98bf"

errorbar(tt, vo, s_vo, 'o', Color = '#cc0001');
hold on
%%errorbar(tt, vi, s_vi, 'o', Color = '#0027BD');
plot(tt(1:end-1), dV, '--', Color = 'black');
plot(tt(is), vo(is), 'x', Color = '#ffff01');
plot(tt, repelem(vo(is(1)), length(tt)), '--', Color = '#01cc00',LineWidth = 1.5);
plot(tt, repelem(vo(is(2)), length(tt)), '--', Color = '#fe98bf', LineWidth = 1.5);
plot(repelem(tt(is(1)), 100), linspace(min(vo), max(vo), 100), '--', Color = '#0000fe', LineWidth = 1.5);
plot(repelem(tt(is(2)), 100), linspace(min(vo), max(vo), 100), '--', Color = '#762ca7', LineWidth = 1.5);




grid on
grid minor
title('Amplitude of Supply Voltage and Output Voltage as function of Gate Voltage');
legend('$ V_{DS} $', '$ \delta V_{DS} / \delta V_{GS} $', "Pivot Points", "$ V_{OH} $", "$ V_{OL} $", "$ V_{IL} $", "$ V_{IH} $", Location= 'ne', Interpreter = 'latex')
ylabel('Voltage [V]')
xlabel('$ V_{GS} [\mathrm{V}] $', Interpreter = 'latex')
ylim([-2 5.1])

set(gca, 'FontSize', 14)

hold off



