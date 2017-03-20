function [pitch_array] = getPitchCepstrum(audios, audios_database_dir, voiced_model, unvoiced_model, w_L, shift)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

   n_files = length(audios);

    h = waitbar(0,'Calculating the pitch');

    for f=1:n_files
        
        audio_name = strsplit(audios(f).name, '.');
        fileID = fopen(strcat(audios_database_dir,audio_name{1},'.f0'),'w');

        [x, f_s] = audioread(strcat(audios_database_dir, audios(f).name));

        x = expandVector(x,shift,f_s); % Fill the signal x with 0 15ms in the begining and 15ms in the end 

        sampl_numb = length(x);
        audio_t = (sampl_numb/f_s)*1e3; %in ms

        pitch_array = [];
        zeroes_array = [];
        peak_r = [];

        for counter = 0:shift:(audio_t-w_L)

            start = f_s*counter/1e3+1;
            finish = f_s*(counter+w_L)/1e3+1;

            if finish > sampl_numb
                x_w = x(start:end);
            else
                x_w = x(start:finish);
            end

            zeroes_n = 1;

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

                % HUMAN VOICE RANGE:
                % - Male: 85 to 180 Hz
                % - Female: 165 to 255 Hz
                human_max_range = 300;
                human_min_range = 80;
                min_cep_distance = ceil(f_s/human_max_range);
                max_cep_distance = ceil(f_s/human_min_range);

                cepstrum_fltrd = x_cepstrum; %smooth(x_cepstrum, 'rloess');

                [peaks, places] = findpeaks(cepstrum_fltrd(1:ceil(length(cepstrum_fltrd)/2)));
                [max_peak, max_peak_place] = max(peaks);
                [max_peak2, max_peak2_place] = max(peaks(max_peak_place+1:end)); % Finding the second peak
                max_peak_place = places(max_peak_place); % First max place
                %places = places(ceil(length(peaks)/2)+1:end);
                max_peak2_place = places(max_peak2_place); % Second max place

                %pitch = f_s/(90*max_peak_place)
                pitch = max_peak_place*1e3/w_L;

    %             mode(pitch_array) 
    %             if pitch2 < mode(pitch_array)
    %                 pitch = pitch2;
    %             end

                peak_r = [peak_r; abs(cepstrum_fltrd(1)/max_peak2)];

                if (pitch > 270) | (pitch < 80) 
                    pitch = 0;
%                 elseif abs(cepstrum_fltrd(1)/max_peak2) < 10
%                     pitch = 0;
                end


            else
                pitch = 0;
            end
            
            pitch_array = [pitch_array; pitch];
        end

        waitbar(f/n_files)
        fprintf(fileID, '%g\n', pitch_array);
        fclose(fileID);
    end
close(h) 
end

