dataPosition = '../../Data/';
filefolder = 'caratteristiche';
filename = 'data14-2';

flagSave = false;

%dataPosition = '../../Data/';
%filename = 'data009';

Rl  = 1e3;



% data import and creation of variance array
rawData = readmatrix(strcat(dataPosition, filefolder, '/', filename, '.txt'));

tt = rawData(:, 1);
ch1 = rawData(:, 2);
ch2 = rawData(:, 3);


%io = vo/R;
Id = (ch1-ch2) / Rl;
vds = ch2;

plot(ch2, Id, 'o', Color = '#0027BD');
%plot(tt, vi, 'o', Color = '#0027BD');
%hold on
%plot(tt, vo, 'o', Color = '#FF7F00');


grid on
grid minor
%title('Amlitude and Ottset of input signal');
%legend('photodiode', 'LED', 'Amplitude in - 45k divider', 'Ottset in - 45k divider', Location= 'ne')
ylabel(' I [A]')
xlabel('Vds [V]')

hold off

%Il = mean( Vl) / Rl
Ip = mean( Vp) / Rph
%s_Il = std( Vl)
s_Vp = std( Vp ) / mean(Vp) * Ip




if flagSave
    fig = gcf;
    orient(fig, 'landscape')
    print(fig, strcat(mediaposition, medianame, '.pdf'), '-dpdf')
end
