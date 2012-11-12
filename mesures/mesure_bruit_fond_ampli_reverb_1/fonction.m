clear all;
close all;

file = wavread('

while i<=length(file)
    if file(i)>0.5
        disp(num2str(i));
    endif
    i = i+1;
endwhile