function [vector] = expandVector(vector, exp_ms, frequency_sampl)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    % Vector Expansion
    sampl_numb = length(vector);
    
    vector_expand = zeros(sampl_numb+2*exp_ms*frequency_sampl*1e-3,1); % 2 exp_ms ms windows expansion. 1 window in the beginning and other in the end.
    vector_expand(1+exp_ms*frequency_sampl*1e-3:end-exp_ms*frequency_sampl*1e-3) = vector;

    vector = vector_expand;

end

