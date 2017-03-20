clc
close all
clear all

files = dir('data/fda_ue/*.f0ref');
audios = dir('data/fda_ue/*.wav');

n_files = length(files);

w_prior = [];
z_array = [];

figure

for f=1:n_files
    
    w_prior = [w_prior; textread(strcat('data/fda_ue/',files(f).name))];
    
    [x, f_s] = audioread(strcat('data/fda_ue/',audios(f).name));
    
    x = expandVector(x,15,f_s); % Fill the signal x with 0 15ms in the begining and 15ms in the end 
    
    sampl_numb = length(x);
    audio_t = (sampl_numb/f_s)*1e3; %in ms
    w_L = 32; % 32ms window
    
    %max_array = []
    for counter = 0:15:(audio_t-w_L)

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

subplot(3,1,1)
hist(voicedSamples, 500)
hold on
[a b] = hist(unvoicedSamples, 500);
ab=bar(b,a);
set(ab,'FaceColor','none','EdgeColor','r');
hold off
title('Histogram. Number of zeroes')

x=1:600;
likelihood_voiced = 1/(sqrt(2*pi*var(voicedSamples)))*exp(-1/(2*var(voicedSamples))*(x-mean(voicedSamples)).^2);
likelihood_unvoiced = 1/(sqrt(2*pi*var(unvoicedSamples)))*exp(-1/(2*var(unvoicedSamples))*(x-mean(unvoicedSamples)).^2);

[mu, sigma] = normfit(voicedSamples);
likelihood_voiced = 1/(sigma*sqrt(2*pi))*exp(-1/2*((x-mu)/sigma).^2);
likelihood_voiced = normpdf(x,mu,sigma/2);

[mu, sigma] = normfit(unvoicedSamples);
likelihood_unvoiced = normpdf(x,mu,sigma/2);

prior_voiced = length(labelsVoiced)/(length(labelsVoiced)+length(labelsUnvoiced));
prior_unvoiced = length(labelsUnvoiced)/(length(labelsVoiced)+length(labelsUnvoiced));

evidence = 1/length(x);

subplot(3,2,3)
histfit(voicedSamples, 500)
title('Voiced histogram approximation')

subplot(3,2,4)
histfit(unvoicedSamples, 500)
title('Unvoiced histogram approximation')

subplot(3,2,5)
plot(likelihood_voiced)
hold on
plot(likelihood_unvoiced, 'r')
hold off
title('p(x|w_i)')

voiced_gauss = likelihood_voiced.*prior_voiced;
unvoiced_gauss = likelihood_unvoiced.*prior_unvoiced;
subplot(3,2,6)
plot(voiced_gauss)
hold on
plot(unvoiced_gauss, 'r')
hold off
title('p(w_i|x)')

P_e = sum(unvoiced_gauss(1:99)) + sum(voiced_gauss(99:end))

