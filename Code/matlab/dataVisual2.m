clear all;

dataPosition = '../../Data/';
filefolder = 'caratteristiche';
filename = 'data';

% a color array containing 8 colors
colors = ["#cc0001" "#fb940b" "#ffff01" "#01cc00" "#03c0c6" "#0000fe" "#762ca7" "#fe98bf"];
names = [];

Rl  = 994.6;
s_R1 = 3.9;




for i = 12:19
    swapString = int2str(i);
    names = [names, strcat( "$ V_{GS} = ", swapString(1), ".", swapString(2), "\; \mathrm{V} $") ];

    swap1 = readmatrix(strcat(dataPosition, filefolder, '/', filename, swapString, '-1.txt'));
    swap2 = readmatrix(strcat(dataPosition, filefolder, '/', filename, swapString, '-2.txt'));
    swap3 = readmatrix(strcat(dataPosition, filefolder, '/', filename, swapString, '-3.txt'));


    swap_ch1 = [ swap1(:, 2), swap2(:, 2), swap3(:, 2) ];
    swap_ch2 = [ swap1(:, 3), swap2(:, 3), swap3(:, 3) ];

    ch1 = mean(swap_ch1, 2);
    s_ch1 = std(swap_ch1, 0, 2);
    ch2 = mean(swap_ch2, 2);
    s_ch2 = std(swap_ch2, 0, 2);

    Id = (ch1-ch2) / Rl * 1e3;
    s_Id = sqrt( (s_ch1/Rl).^2 + (s_ch2/Rl).^2 + ( (ch1-ch2)*s_R1/(Rl^2) ).^2 ) * 1e3;

    errorbar(ch2, Id, 0.5*s_Id, 0.5*s_Id, 0.5*s_ch2, 0.5*s_ch2, '.', Color = colors(i-11), MarkerSize = 10);
    if i == 12
        hold on
    end

end

%Ilod = repelen( 4.983 / Rl, length(Id) );
Vlod = linspace(0, 4.983, 100);
plot(Vlod, (4.983-Vlod)/Rl*1e3, '--', Color= 'black', LineWidth= 1.5);
names = [names, "Load Line"];



hold off


grid on
grid minor
title('MOSFET Output Characteristic');
legend(names, Location= 'ne', Interpreter = 'latex')
%legend([ "1.2", "1.3", "1,4", "1.5", "1.6" "1.7", "1.8", "1.9"], Location= 'ne')
ylabel(' I [mA]')
xlabel('Vds [V]')

xlim([-0.1 5.1])
ylim([-0.1 5.1])

set(gca, 'FontSize', 14)
