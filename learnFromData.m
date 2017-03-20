function [voiced_model, unvoiced_model] = learnFromData(data, audios, w_L, shift)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

n_files = length(data);

w_prior = [];
z_array = [];

for f=1:n_files
    
    w_prior = [w_prior; textread(strcat('data/fda_ue/',data(f).name))];
    
    [x, f_s] = audioread(strcat('data/fda_ue/',audios(f).name));
    
    x = expandVector(x,shift,f_s); % Fill the signal x with 0 15ms in the begining and 15ms in the end 
    
    sampl_numb = length(x);
    audio_t = (sampl_numb/f_s)*1e3; %in ms
    %w_L = 32; % 32ms window
    
    %max_array = []
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
        
        z_array = [z_array; zeroes_n];
        
    end
    
    if length(w_prior) - length(z_array) == 1
        w_prior = w_prior(1:end-1);
    elseif length(w_prior) - length(z_array) == -1
        z_array = z_array(1:end-1);
    end
    
end

voiced = w_prior;
voiced(voiced>0) = 1;
    
labelsVoiced = find(voiced>0);
voicedSamples = z_array(labelsVoiced);
labelsUnvoiced = find(voiced<1);
unvoicedSamples = z_array(labelsUnvoiced);

x=1:600;
likelihood_voiced = 1/(sqrt(2*pi*var(voicedSamples)))*exp(-1/(2*var(voicedSamples))*(x-mean(voicedSamples)).^2);
likelihood_unvoiced = 1/(sqrt(2*pi*var(unvoicedSamples)))*exp(-1/(2*var(unvoicedSamples))*(x-mean(unvoicedSamples)).^2);

prior_voiced = length(labelsVoiced)/length(x);
prior_unvoiced = length(labelsUnvoiced)/length(x);

voiced_model = prior_voiced*likelihood_voiced;
unvoiced_model = prior_unvoiced*likelihood_unvoiced;
    
end

