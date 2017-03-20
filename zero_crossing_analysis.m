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
    
    x = expandVector(x,15,f_s); % Fill the signal x with 0 15ms in the begining and 15ms in the end 
    
    sampl_numb = length(x);
    audio_t = (sampl_numb/f_s)*1e3; %in ms
    w_L = 32; % 32ms window
    
    z_array = [];
    %max_array = []
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
        
        z_array = [z_array, zeroes_n];
        %max_array = [max_array, max(x_w)];
        


    end
    
%     voiced = find(z_array<mean(z_array));
    
%     figure
%     subplot(3,1,1)
%     plot(z_array)
%     hold on
%     %plot(var(z_array)*ones(length(z_array),1), 'y')
%     plot(mean(z_array)*ones(length(z_array),1), 'g')
%     plot(mode(z_array)*ones(length(z_array),1), 'r')
%     plot(voiced,max(z_array),'*')
%     hold off
%     xlim([0, length(z_array)]);
%     grid on
%     subplot(3,1,2)
%     plot(x)
% %     hold on
% %     plot(voiced,max(z_array),'*')
% %     hold off
%     xlim([0, length(x)]);
%     grid on
%     subplot(3,1,3)
%     hist(z_array,50)
    
    %fit = NaiveBayes.fit(z_array, x);
    
%     Mdl = fitcnb(double(features),labels)
% 
% estimates = Mdl.DistributionParameters;
% estimates{1}
% estimates{2}

% sampled = datasample(features,100);
% scatter(sampled,ones(1,100));
    
    
    % fit = fitNaiveBayes(z_array, tabulate(x_w));
    figure
    plot(fit)   
end