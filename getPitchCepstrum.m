function [ output_args ] = getPitchCepstrum(audios, w_L, shift)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    n_files = length(audios);

    for f=1:n_files

        [x, f_s] = audioread(strcat('data/fda_ue/',audios(f).name));

        x = expandVector(x,shift,f_s); % Fill the signal x with 0 15ms in the begining and 15ms in the end 

        sampl_numb = length(x);
        audio_t = (sampl_numb/f_s)*1e3; %in ms

        pitch_array = [];
        zeroes_array = [];

        for counter = 0:shift:(audio_t-w_L)

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
                x_cepstrum = rceps(x_w);
    
                % HUMAN VOICE RANGE:
                % - Male: 85 to 180 Hz
                % - Female: 165 to 255 Hz
                human_max_range = 300;
                human_min_range = 80;
                min_cep_distance = ceil(f_s/human_max_range);
                max_cep_distance = ceil(f_s/human_min_range);

                cepstrum_fltrd = smooth(x_cepstrum, 'rloess');

                [peaks, places] = findpeaks(cepstrum_fltrd(end-max_cep_distance:end));
                [max_peak, max_peak_place] = max(peaks);
                [max_peak2, max_peak2_place] = max(peaks(1:max_peak_place-1)); % Finding the second peak
                max_peak_place = places(max_peak_place); % First max place
                max_peak2_place = places(max_peak2_place); % Second max place

                pitch = f_s/(length(x_cepstrum(end-max_cep_distance:end))-max_peak2_place);
                pitch2 = f_s/(max_peak_place-max_peak2_place);


                if (pitch > 270) || (pitch < 80) 
                    pitch = 0;
                end

            else
                pitch = 0;
            end
            pitch_array = [pitch_array; pitch];
        end
        fprintf(fileID, '%g\n', m_pitch);
        fclose(fileID);
    end
end

