%% Pitch estimation and voicing detection
%
clc
clear all
close all
%% Learning from the data
%

files = [dir('data/fda_ue/rl001.wav'); dir('data/fda_ue/rl002.wav'); dir('data/fda_ue/sb050.wav')];

n_files_matrix = size(files);
n_files = n_files_matrix(1);

% Let us check the audio

for f=1:n_files
 
    [x, f_s] = audioread(strcat('data/fda_ue/',files(f).name));
    
    sampl_numb = length(x);
    audio_t = (sampl_numb/f_s)*1e3; %in ms
    w_L = 32; % 32ms window

    mean_evolution1 = 0;
    max_evolution1 = 0;
    mean_evolution2 = 0;
    max_evolution2 = 0;

    for counter = 0:15:(audio_t-32)

        start = f_s*counter/1e3+1;
        finish = f_s*(counter+w_L)/1e3+1;

        x_w = x(start:finish);
        
        mean_evolution1 = [mean_evolution1, mean(abs(x_w))];
        max_evolution1 = [max_evolution1, max(abs(x_w))];
%         X_w = fft(x_w);
% 
%         rx_wx_w = ifft(X_w.*X_w);
%         
        rx_wx_w = xcorr(x_w);

        mean_evolution2 = [mean_evolution2, mean(abs(rx_wx_w))];
        max_evolution2 = [mean_evolution2, max(abs(rx_wx_w))];
        
%         if (mean(abs(rx_wx_w))>mean(abs(x)))
%                 figure
%                 plot(rx_wx_w)
%                 pause
%         end
%         
%         figure()
%         subplot(2,1,1)
%         plot(x_w)
%         subplot(2,1,2)
%         plot(rx_wx_w)
%         pause()

    end

    % After analyzing the data, we can set a threshold of $10^{-3}$ for high
    % correlated windows. Or what is the same, windows with a voice content and
    % easy in order to calculte the pith estimation

    correlation_windows1 = find(abs(mean_evolution1(2:end))>mean(abs(x)));
    correlation_windows2 = find(abs(mean_evolution2(2:end))>mean(abs(x)));

    figure()
    subplot(3,1,1)
    plot(abs(mean_evolution1(2:end)))
    hold on
    plot(correlation_windows1,max(abs(mean_evolution1(2:end))),'*')
    hold off
    grid on
    title('Mean Evolution along the audio of the signal')
    subplot(3,1,2)
    plot(abs(mean_evolution2(2:end)))
    hold on
    plot(correlation_windows2,max(abs(mean_evolution2(2:end))),'*')
    hold off
    grid on
    title('Mean Evolution along the audio of the autocorrelation of the signal')
%     subplot(3,2,2)
%     plot(max_evolution1)
%     grid on
%     title('Max Evolution along the audio of the signal')
%     subplot(3,2,4)
%     plot(max_evolution2)
%     grid on
%     title('Max Evolution along the audio of the autocorrelation of the signal')
    subplot(3,1,3)
    plot(x)
    title('Audio Signal')

    % test = abs(mean_evolution2(2:end))+abs(mean_evolution1(2:end));
    % subplot(4,1,4)
    % plot(test)
    % title('The sum of both mean evolutions (in order to avoid that little values disappear)')

    load gong.mat;
    sound = audioplayer(x, f_s);
    play(sound);

    correlation_windows1 = find(abs(mean_evolution1(2:end))>1e-3);
    correlation_windows2 = find(abs(mean_evolution2(2:end))>1e-3);
    correlation_windows3 = find(abs(mean_evolution1(2:end))>var(x));
    correlation_windows4 = find(abs(mean_evolution2(2:end))>var(x));
    
%     var(x)
%     length(correlation_windows1)
%     length(correlation_windows2)
%     length(correlation_windows3)
%     length(correlation_windows4)
    
    % correlation_windows_test = find(test>1e-3)

    % sections = zeros(1, audio_t+1);
    % sq = ones (1,15);
    % sections(correlation_windows2*300) = 1;
    % 
    % figure()
    % plot(square(correlation_windows2),x)

end