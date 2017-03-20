function [signals, fs_array, pitch_array, mean_pitch] = getPitch(wav_files, database_dir, w_L, shift)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

n_files = length(wav_files);

signals = {};
mean_pitch = {};
pitch_array = {};

h = waitbar(0,'Calculating the pitch');

%figure

    for f=1:n_files
        
        m_pitch = []; %Auxiliary variable
        m_pitch_test = [];
        
        audio_name = strsplit(wav_files(f).name, '.');
        fileID = fopen(strcat(database_dir,audio_name{1},'.f0'),'w');
        
        [x, f_s] = audioread(strcat(database_dir,wav_files(f).name));
        signals{f} = x;
        fs_array{f} = f_s;
        
        x = expandVector(x,shift,f_s); % Fill the signal x with 0 15ms in the begining and 15ms in the end 
        
        sampl_numb = length(x);
        audio_t = (sampl_numb/f_s)*1e3; %in ms
        %w_L = 32; % 32ms window
        
        pitch = 0;
        
        % 15*n+w_L
        %n=ceil((audio_t-w_L)/15)

        for counter = 0:shift:(audio_t-w_L) % The 32ms window moves every 15ms
            start = f_s*counter/1e3+1;
            finish = f_s*(counter+w_L)/1e3+1;

            x_w = x(start:finish);
            
            % X_w = fft(x_w);

            % rx_wx_w = ifft(X_w.*X_w);
            
            rx_wx_w = xcorr(x_w);
            
%             if (mean(abs(rx_wx_w))>mean(abs(x))) % If this sample is voice, then
           if (mean(abs(rx_wx_w))>0.02) % If this sample is voice, then
                
                [peaks, places] = findpeaks(rx_wx_w);
                [max_peak, max_peak_place] = max(peaks);
                max_peak_place = places(max_peak_place); % First max place
                [max_peak2, max_peak2_place] = max(peaks(ceil(length(peaks)/2)+1:end)); % Finding the secon peak
                places = places(ceil(length(peaks)/2)+1:end);
                max_peak2_place = places(max_peak2_place); % Second max place
                
                pitch = [pitch; f_s/(max_peak2_place-max_peak_place)];
                m_pitch = [m_pitch; pitch(end)];
                
                % HUMAN VOICE RANGE:
                % - Male: 85 to 180 Hz
                % - Female: 165 to 255 Hz
                human_max_range = 350;
                human_min_range = 85;
                
                if (f_s/(max_peak2_place-max_peak_place) > human_max_range) || (f_s/(max_peak2_place-max_peak_place) < human_min_range) % Filter to detect errors not filtered before
%                     subplot(2,1,1)
%                     plot(pitch(2:end))
%                     grid on
%                     subplot(2,1,2)
%                     plot(x(1:finish))
%                     grid on
%                     pause
                    
                    pitch(end) = mode(pitch);
                end
                
                m_pitch_test = [m_pitch_test; pitch(end)];
                
            else
                
                m_pitch = [m_pitch; 0]; % In the case that the sample is unvoiced, the 0 value will not be changed
                m_pitch_test = [m_pitch_test; 0];
                
            end

        end
        
        %pitch = pitch(2:end);
        
        %pitch = medfilt1(pitch);
        
%         length(m_pitch)
%         mean_pitch
%         pause

        mean_pitch{f} = m_pitch;
        pitch_array{f} = pitch;
        
%         subplot(2, 1, 1);
%         plot(m_pitch, 'r')
%         hold on
%         plot(m_pitch_test)
%         hold off
%         grid on
%         title('Pitch evolution')
%         subplot(2, 1, 2);
%         plot(x)
%         grid on
%         title('Audio signal')
% 
%     pause

    fprintf(fileID, '%g\n', m_pitch);
    fclose(fileID);
    
    waitbar(f/n_files)
    end
    
    close(h) 
    %mean_pitch = mean_pitch(2:end);
    %pitch_array = pitch_array(2:end);
end

