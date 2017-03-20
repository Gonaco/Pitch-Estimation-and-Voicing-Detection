function [mean_evolution1, mean_evolution2, max_evolution1, max_evolution2] = dataAnalysis(data, wav_files, w_L, shift)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

n_files = length(wav_files);

w_prior = [];

mean_evolution1 = [];
max_evolution1 = [];
mean_evolution2 = [];
max_evolution2 = [];

peak = [];
pitch = [];


h = waitbar(0,'Analyzing Data');

%figure

    for f=1:n_files
        
        w_prior = [w_prior; textread(strcat('data/fda_ue/',data(f).name))];
        
        m_pitch = []; %Auxiliar variable
        
        audio_name = strsplit(wav_files(f).name, '.');
        fileID = fopen(strcat('data/fda_ue/',audio_name{1},'.f0'),'w');
        
        [x, f_s] = audioread(strcat('data/fda_ue/',wav_files(f).name));
        
        x = expandVector(x,shift,f_s); % Fill the signal x with 0 15ms in the begining and 15ms in the end  

        sampl_numb = length(x);
        audio_t = (sampl_numb/f_s)*1e3; %in ms

        for counter = 0:shift:(audio_t-w_L)

            start = f_s*counter/1e3+1;
            finish = f_s*(counter+w_L)/1e3+1;

            x_w = x(start:finish);

            mean_evolution1 = [mean_evolution1; mean(abs(x_w))];
            max_evolution1 = [max_evolution1; max(abs(x_w))];

            rx_wx_w = xcorr(x_w);
%             rww = xcorr(1/length(x_w)*ones(length(x_w),1));

            mean_evolution2 = [mean_evolution2; mean(abs(rx_wx_w))];
            max_evolution2 = [mean_evolution2; max(abs(rx_wx_w))];

    %         if (mean(abs(rx_wx_w))>mean(abs(x)))
    %                 figure
    %                 plot(rx_wx_w)
    %                 pause
    %         end

%             figure()
%             subplot(2,1,1)
%             plot(x_w)
%             subplot(2,1,2)
%             plot(rx_wx_w)
%             hold on
%             plot(rww,'k')
%             hold off
%             pause()

            [peaks, places] = findpeaks(rx_wx_w);
            [max_peak, max_peak_place] = max(peaks);
            max_peak_place = places(max_peak_place); % First max place
            [max_peak2, max_peak2_place] = max(peaks(ceil(length(peaks)/2)+1:end)); % Finding the secon peak
            places = places(ceil(length(peaks)/2)+1:end);
            max_peak2_place = places(max_peak2_place); % Second max place
            
            peak = [peak; max_peak2];

            pitch = [pitch; f_s/(max_peak2_place-max_peak_place)];

        end

            % After analyzing the data, we can set a threshold of $10^{-3}$ for high
        % correlated windows. Or what is the same, windows with a voice content and
        % easy in order to calculte the pith estimation

%         correlation_windows1 = find(abs(mean_evolution1(2:end))>mean(abs(x)));
%         correlation_windows2 = find(abs(mean_evolution2(2:end))>mean(abs(x)));
%         
%         subplot(3,1,1)
%         plot(abs(mean_evolution1(2:end)))
%         hold
%         plot(correlation_windows1,max(abs(mean_evolution1(2:end))),'*')
%         grid on
%         title('Mean Evolution along the audio of the signal')
%         subplot(3,1,2)
%         plot(abs(mean_evolution2(2:end)))
%         hold
%         plot(correlation_windows2,max(abs(mean_evolution2(2:end))),'*')
%         grid on
%         title('Mean Evolution along the audio of the autocorrelation of the signal')
%     %     subplot(3,2,2)
%     %     plot(max_evolution1)
%     %     grid on
%     %     title('Max Evolution along the audio of the signal')
%     %     subplot(3,2,4)
%     %     plot(max_evolution2)
%     %     grid on
%     %     title('Max Evolution along the audio of the autocorrelation of the signal')
%         subplot(3,1,3)
%         plot(x)
%         title('Audio Signal')
% 
%         % test = abs(mean_evolution2(2:end))+abs(mean_evolution1(2:end));
%         % subplot(4,1,4)
%         % plot(test)
%         % title('The sum of both mean evolutions (in order to avoid that little values disappear)')
% 
%         load gong.mat;
%         sound = audioplayer(x, f_s);
%         play(sound);
%         pause

            if length(w_prior) - length(mean_evolution1) == 1
                w_prior = w_prior(1:end-1);
            elseif length(w_prior) - length(mean_evolution1) == -1
                mean_evolution1 = mean_evolution1(1:end-1);
            end
            
            if length(w_prior) - length(mean_evolution2) == 1
                w_prior = w_prior(1:end-1);
            elseif length(w_prior) - length(mean_evolution2) == -1
                mean_evolution2 = mean_evolution2(1:end-1);
            end
            
            if length(w_prior) - length(max_evolution1) == 1
                w_prior = w_prior(1:end-1);
            elseif length(w_prior) - length(max_evolution1) == -1
                max_evolution1 = max_evolution1(1:end-1);
            end
            
            if length(w_prior) - length(max_evolution2) == 1
                w_prior = w_prior(1:end-1);
            elseif length(w_prior) - length(max_evolution2) == -1
                max_evolution2 = max_evolution2(1:end-1);
            end
            
            if length(w_prior) - length(max_evolution2) == 1
                w_prior = w_prior(1:end-1);
            elseif length(w_prior) - length(max_evolution2) == -1
                max_evolution2 = max_evolution2(1:end-1);
            end

        waitbar(f/n_files)
    end
    
    close(h) 
    
    voiced = w_prior;
    voiced(voiced>0) = 1;

    labelsVoiced = find(voiced>0);
    voicedSamples_mean = mean_evolution1(labelsVoiced);
    voicedSamples_mean2 = mean_evolution2(labelsVoiced);
    voicedSamples_max = max_evolution1(labelsVoiced);
    voicedSamples_max2 = max_evolution2(labelsVoiced);
    voicedSamples_peak = peak(labelsVoiced);
    voicedSamples_pitch = pitch(labelsVoiced);
    labelsUnvoiced = find(voiced<1);
    unvoicedSamples_mean = mean_evolution1(labelsUnvoiced);
    unvoicedSamples_max = max_evolution1(labelsUnvoiced);
    unvoicedSamples_mean2 = mean_evolution2(labelsUnvoiced);
    unvoicedSamples_max2 = max_evolution2(labelsUnvoiced);
    unvoicedSamples_peak = peak(labelsUnvoiced);
    unvoicedSamples_pitch = pitch(labelsUnvoiced);

    figure

    subplot(2,2,1)
    hist(voicedSamples_mean)
    hold on
    [a b] = hist(unvoicedSamples_mean);
    ab=bar(b,a);
    set(ab,'FaceColor','none','EdgeColor','r');
    hold off
    title('Histogram. Mean of x_w')

    subplot(2,2,2)
    hist(voicedSamples_mean2)
    hold on
    [a b] = hist(unvoicedSamples_mean2);
    ab=bar(b,a);
    set(ab,'FaceColor','none','EdgeColor','r');
    hold off
    title('Histogram. Mean of the x_w autocorrelation')

    subplot(2,2,3)
    hist(voicedSamples_max)
    hold on
    [a b] = hist(unvoicedSamples_max);
    ab=bar(b,a);
    set(ab,'FaceColor','none','EdgeColor','r');
    hold off
    title('Histogram. Max of x_w')

    subplot(2,2,4)
    hist(voicedSamples_max2)
    hold on
    [a b] = hist(unvoicedSamples_max2);
    ab=bar(b,a);
    set(ab,'FaceColor','none','EdgeColor','r');
    hold off
    title('Histogram. Max of x_w autocorrelation')
    
    figure 
    subplot(2,1,1)
    hist(voicedSamples_mean2, length(w_prior)/1000)
    title('Histogram. Mean of the x_w autocorrelation. Voiced Class')
    subplot(2,1,2)
    [a b] = hist(unvoicedSamples_mean2, length(w_prior)/1000);
    ab=bar(b,a);
    set(ab,'FaceColor','none','EdgeColor','r');
    title('Histogram. Mean of the x_w autocorrelation. Unvoiced Class')
    
    figure 
    subplot(2,1,1)
    hist(voicedSamples_peak, length(w_prior))
    hold on
    [a b] = hist(unvoicedSamples_peak, length(w_prior));
    ab=bar(b,a);
    set(ab,'FaceColor','none','EdgeColor','r');
    hold off
    title('Histogram. Second peak value of the x_w autocorrelation')

    subplot(2,1,2)
    hist(voicedSamples_pitch, length(w_prior))
    hold on
    [a b] = hist(unvoicedSamples_pitch, length(w_prior));
    ab=bar(b,a);
    set(ab,'FaceColor','none','EdgeColor','r');
    hold off
    title('Histogram. Pitch value from the x_w autocorrelation')
    
    figure
    hist(voicedSamples_pitch, length(w_prior))
    hold on
    [a b] = hist(unvoicedSamples_pitch, length(w_prior));
    ab=bar(b,a);
    set(ab,'FaceColor','none','EdgeColor','r');
    hold off
    title('Histogram. Pitch value from the x_w autocorrelation')

end

