clc
close all
clear all

files = dir('data/fda_ue/*.f0ref');
train_audios = dir('data/fda_ue/*.wav');

w_L = 32; % 32ms window

[voiced_model, unvoiced_model] = learnFromData(files,train_audios, w_L, 15);

audios = dir('data/fda_ue/*.wav');

n_files = length(audios);

figure

h = waitbar(0,'Calculating the pitch');

for f=1:n_files
    
    [x, f_s] = audioread(strcat('data/fda_ue/',audios(f).name));
    
    x = expandVector(x,15,f_s); % Fill the signal x with 0 15ms in the begining and 15ms in the end 
    
    sampl_numb = length(x);
    audio_t = (sampl_numb/f_s)*1e3; %in ms
    
    pitch_array = [];
    pitch_array2 = [];
%     pitch_array3 = [];
    zeroes_array = [];
    peak_r = [];
    
    for counter = 0:15:(audio_t-32)

        start = f_s*counter/1e3+1;
        finish = f_s*(counter+w_L)/1e3+1;

        x_w = x(start:finish);
        
        zeroes_n = 0;
        
        for k = 2:(w_L*f_s*1e-3)
            if x_w(k) == 0
                zeroes_n = zeroes_n+1;
            elseif (x_w(k) > 0 && x_w(k-1) < 0)
                zeroes_n = zeroes_n+1;
            elseif (x_w(k) < 0 && x_w(k-1) > 0)
                zeroes_n = zeroes_n+1;
            end
        end
                    
        zeroes_array = [zeroes_array; zeroes_n];
        
        if voiced_model(zeroes_n)>unvoiced_model(zeroes_n) % decisor
            
            % CEPSTRUM STUDY
%             %x_cepstrum = rceps(x_w);
            x_cepstrum = real(ifft(log(fft(x_w, length(x_w)*30)))); % more samples in order to have a good Cepstrum resolution
%             subplot(3,1,1)
%             plot(x_w)
%             title('Sample Signal Audio')
%             subplot(3,1,2);
%             plot(x_cepstrum);
%             title('Real Cepstrum of the signal')
%             subplot(3,1,3);
%             plot(x_cepstrum(30:end))
%             hold on
%             plot(smooth(x_cepstrum(30:end), 'sgolay'), 'r')
%             %x_cepstrum = smooth(x_cepstrum, 'sgolay', 3);
%             plot(smooth(x_cepstrum(30:end), 'rloess'), 'g')
%             hold off
%             title('Filtered Cepstrum begining')
            
            % FILTERS TEST 
%             figure
%             
%             plot(x_cepstrum(30:end))
%             hold on
%             plot(smooth(x_cepstrum(30:end), 'sgolay'), 'r')
%             plot(smooth(x_cepstrum(30:end), 'sgolay', 3), 'g')
%             plot(smooth(smooth(x_cepstrum(30:end), 'sgolay', 3), 'sgolay', 3), 'k')
%             plot(smooth(x_cepstrum(30:end), 'rloess'), 'm')
%             plot(smooth(x_cepstrum(30:end), 'loess'), 'c')
%             hold off

            % HUMAN VOICE RANGE:
            % - Male: 85 to 180 Hz
            % - Female: 165 to 255 Hz
            human_max_range = 300;
            human_min_range = 80;
            min_cep_distance = ceil(f_s/human_max_range);
            max_cep_distance = ceil(f_s/human_min_range);
            
            cepstrum_fltrd = smooth(x_cepstrum, 'rloess');
%             
%             [peaks, places] = findpeaks(cepstrum_fltrd(end-max_cep_distance:end));
%             [max_peak, max_peak_place] = max(peaks);
%             [max_peak2, max_peak2_place] = max(peaks(1:max_peak_place-1)); % Finding the second peak
%             max_peak_place = places(max_peak_place); % First max place
%             %places = places(ceil(length(peaks)/2)+1:end);
%             max_peak2_place = places(max_peak2_place); % Second max place
            
            [peaks, places] = findpeaks(cepstrum_fltrd(1:ceil(length(cepstrum_fltrd)/2)));
            [max_peak, max_peak_place] = max(peaks);
            [max_peak2, max_peak2_place] = max(peaks(max_peak_place+1:end)); % Finding the second peak
            max_peak_place = places(max_peak_place); % First max place
            %places = places(ceil(length(peaks)/2)+1:end);
            max_peak2_place = places(max_peak2_place); % Second max place
            
            % MAX_PEAKS BEHAVIOUR
%             figure
%             subplot(2,1,1)
%             plot(x_cepstrum(1:ceil(length(x_cepstrum)/2)))
%             hold on
%             plot(max_peak_place, max_peak, '*')
%             plot(max_peak2_place, max_peak2, '*')
%             hold off
%             grid on
%             subplot(2,1,2)
%             plot(cepstrum_fltrd(1:ceil(length(cepstrum_fltrd)/2)))
%             hold on
%             plot(max_peak_place, max_peak, '*')
%             plot(max_peak2_place, max_peak2, '*')
%             hold off
%             grid on
            
            %pitch = [pitch; f_s/(max_peak2_place-max_peak_place)];
            
            % PEAK STUDY
            
            %pitch = f_s/(length(x_cepstrum(end-max_cep_distance:end))-max_peak2_place)
            pitch = 30*f_s/max_peak_place
            pitch = max_peak_place*1e3/w_L
%             pitch2 = f_s/(max_peak_place-max_peak2_place);
%             pitch3 = f_s/(length(x_cepstrum(end-max_cep_distance:end))-max_peak_place);
            
            %pitch_array = [pitch_array; pitch];
%             pitch_array2 = [pitch_array2; pitch2];
%             pitch_array3 = [pitch_array3; pitch3];
            
%             mode(pitch_array) 
%             if pitch2 < mode(pitch_array)
%                 pitch = pitch2;
%             end

            peak_r = [peak_r; abs(cepstrum_fltrd(1)/max_peak2)];
            
%             if (pitch > 270) | (pitch < 80) 
%                 pitch = 0;
%             elseif abs(cepstrum_fltrd(1)/max_peak2) < 10
%                 pitch = 0;
%             end

            
             %pause
             %close
        else
            pitch = 0;
        end
        pitch_array = [pitch_array; pitch];
    end
    
    plot(pitch_array)
    hold on
    plot(peak_r,'c')
    %plot(pitch_array3,'m')
    plot(mode(pitch_array)*ones(length(pitch_array),1),'g')
    plot(mean(pitch_array)*ones(length(pitch_array),1),'k')
    %plot(zeroes_array,'r')
    hold off
    
    pause
    waitbar(f/n_files)
end
close(h) 
