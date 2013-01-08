function [ norm ] = normalize( in )
% Normalize a vect to its maximum
maxi = max(max(in));
norm =  in./maxi;
end

