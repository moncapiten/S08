dataPosition = '../../Data/';
filefolder = 'caratteristiche';
filename = 'data14-';



for j = 12:12
%    tt = [];
%    ch1 = [];
%    s_ch1 = [];
%    ch2 = [];
%    s_ch2 = [];

    swap1 = readmatrix(strcat(dataPosition, filefolder, '/', filename, '1.txt'));
    swap2 = readmatrix(strcat(dataPosition, filefolder, '/', filename, '2.txt'));
    swap3 = readmatrix(strcat(dataPosition, filefolder, '/', filename, '3.txt'));

%    tt = [ tt, swap1(i, 1) ];

    swap_ch1 = [ swap1(:, 2), swap2(:, 2), swap3(:, 2) ];
    swap_ch2 = [ swap1(:, 3), swap2(:, 3), swap3(:, 3) ];

    ch1 = mean(swap_ch1, 2);
    s_ch1 = std(swap_ch1, 0, 2);
    ch2 = mean(swap_ch2, 2);
    s_ch2 = std(swap_ch2, 0, 2);



    Rl  = 994.6;
    s_R1 = 3.9;





    Id = (ch1-ch2) / Rl;

    s_Id = sqrt( (s_ch1/Rl).^2 + (s_ch2/Rl).^2 + ( (ch1-ch2)*s_R1/(Rl^2) ).^2 );

    errorbar(ch2, Id, 0.5*s_Id, 0.5*s_Id, 0.5*s_ch2, 0.5*s_ch2, 'o', Color = '#0027BD');
    if j == 12
        hold on
    end

end




grid on
grid minor
title('MOSFET Output Characteristic');
%legend('photodiode', 'LED', 'Amplitude in - 45k divider', 'Ottset in - 45k divider', Location= 'ne')
ylabel(' I [A]')
xlabel('Vds [V]')

hold off
