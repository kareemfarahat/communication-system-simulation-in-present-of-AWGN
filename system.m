m = 2;
n = 1 ;
x = 50000;
T = [0: 0.001 : x*0.001-0.001];
SNR = 2;
OrignalSignal = randi([0 1], n,x);
PAMSignal = pammod(OrignalSignal,m);
Signal_Noise = awgn(PAMSignal,SNR);
FilterWave = phased.LinearFMWaveform('PulseWidth',1e-4,'PRF',5e3);
wave = getMatchedFilter(FilterWave);
Filter = phased.MatchedFilter('Coefficients',wave);
FilteredSignal = Filter(Signal_Noise);
DeModulatedSignl = pamdemod (FilteredSignal ,m );
[NumErrors,BER] = biterr(OrignalSignal,DeModulatedSignl);
figure(1)
subplot(3,2,1), plot(T,OrignalSignal); title ('Orignal Signal'); xlabel('Time(S)'); ylabel('Signal');
ylim([-1 2]);xlim([0 0.5])
subplot(3,2,2), plot(T,PAMSignal); title ('M-PAM Modlated Signal');xlabel('Time(S)'); ylabel('Signal')
ylim([-16 -12]);xlim([0 0.5])
subplot(3,2,3), plot(T,Signal_Noise); title ('Signal added WGN');xlabel('Time(S)'); ylabel('Signal')
xlim([0 50])
subplot(3,2,4), plot(T,FilteredSignal); title ('Filtered Signal');xlabel('Time(S)'); ylabel('Signal')
xlim([0 50])
subplot(3,2,5), plot(T,DeModulatedSignl); title ('M-PAM De Modulated Signal');xlabel('Time(S)');
ylabel('Signal')

ylim([-1 4]);xlim([0 0.5])