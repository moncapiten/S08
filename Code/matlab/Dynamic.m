clear all;
y_limits = [-1.5 5.1];

% data import and creation of variance array
dataPosition = '../../Data/';
filename = 'data001';

rawData = readmatrix(strcat(dataPosition, filename, '.txt'));

tt = rawData(:, 1);
vi = rawData(:, 2);
s_vi = repelem(0.02, length(vi));
vo = rawData(:, 3);
s_vo = repelem(0.02, length(vo));

% derivative calculation 
dVo = diff(vo);
dtt = diff(tt);
dV = dVo ./ dtt;

% obtaining points with derivative close to -1 through interative increase of threshold
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


% combination plots
errorbar(tt, vo, s_vo, 'o', Color = '#E11845');
hold on
%%errorbar(tt, vi, s_vi, 'o', Color = '#0027BD');
plot(tt(1:end-1), dV, '--', Color = 'black');
plot(tt(is), vo(is), 'v', Color = '#87E911', MarkerSize = 15);
plot(tt, repelem(vo(is(1)), length(tt)), '--', Color = '#0057E9',LineWidth = 1.5);
plot(tt, repelem(vo(is(2)), length(tt)), '--', Color = '#FF00BD', LineWidth = 1.5);
plot(repelem(tt(is(1)), 100), linspace(y_limits(1), y_limits(2), 100), '--', Color = '#F2CA19', LineWidth = 1.5);
plot(repelem(tt(is(2)), 100), linspace(y_limits(1), y_limits(2), 100), '--', Color = '#8931EF', LineWidth = 1.5);
hold off



grid on
grid minor
title('Amplitude of Supply Voltage and Output Voltage as function of Gate Voltage');
legend('$ V_{DS} $', '$ \delta V_{DS} / \delta V_{GS} $', "Pivot Points", "$ V_{OH} $", "$ V_{OL} $", "$ V_{IL} $", "$ V_{IH} $", Location= 'ne', Interpreter = 'latex');
ylabel('$ V_{DS} [\mathrm{V}] $', Interpreter = 'latex');
xlabel('$ V_{GS} [\mathrm{V}] $', Interpreter = 'latex');
ylim(y_limits);
set(gca, 'FontSize', 14);

% Vo annotations
dim = [.15 .59 .3 .3];
str = ['$ V_{OH} $ = ' sprintf('%.2f', vo(is(1))) '$ \, \mathrm{V} $' ];
annotation('textbox', dim, 'interpreter','latex','String',str,'FitBoxToText','on', 'BackgroundColor', 'white');

dim = [.55 .05 .3 .3];
str = ['$ V_{OL} $ = ' sprintf('%.2f', vo(is(2))) '$ \, \mathrm{V} $' ];
annotation('textbox', dim, 'interpreter','latex','String',str,'FitBoxToText','on', 'BackgroundColor', 'white');

% Vgs(Vi) annotations
dim = [.415 .30 .3 .3];
str = ['$ V_{IH} $ = ' sprintf('%.2f', tt(is(2))) '$ \, \mathrm{V} $' ];
annotation('textbox', dim, 'interpreter','latex','String',str,'FitBoxToText','on', 'BackgroundColor', 'white');

dim = [.285 .30 .3 .3];
str = ['$ V_{IL} $ = ' sprintf('%.2f', tt(is(1))) '$ \, \mathrm{V} $' ];
annotation('textbox', dim, 'interpreter','latex','String',str,'FitBoxToText','on', 'BackgroundColor', 'white');

% derivative annotations
dim = [.26 .59 .3 .3];
str = ['$ \delta V_{DS} / \delta V_{GS} $ = ' sprintf('%.2f', a(1)) '$ \, \mathrm{V} $' ];
annotation('textbox', dim, 'interpreter','latex','String',str,'FitBoxToText','on', 'BackgroundColor', 'white');

dim = [.415 .05 .3 .3];
str = ['$ \delta V_{DS} / \delta V_{GS} $ = ' sprintf('%.2f', a(2)) '$ \, \mathrm{V} $' ];
annotation('textbox', dim, 'interpreter','latex','String',str,'FitBoxToText','on', 'BackgroundColor', 'white');






