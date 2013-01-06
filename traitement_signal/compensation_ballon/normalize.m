function [ norm ] = normalize( in )
% Normalize a vect to its maximum
maxi = max(in);
norm =  in./maxi;
end

