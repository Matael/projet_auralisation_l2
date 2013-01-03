clear all;
close all;

conv_filename = 'conv_chanson_51k2.wav';
ref_filename = 'ref_chanson_51k2.wav';

conv = wavread(conv_filename);
ref = wavread(ref_filename);


start_conv = 177125;
start_ref = 69490;
offset = 000;
forward = 500;

Fe = 51200;
temps = (0:forward)*(1/Fe);

plot(
	temps,
	normalize(
		conv(
			start_conv+offset:start_conv+offset+forward,
			1
		)
	)
);
hold on;
plot(
	temps,
	normalize(
		ref(
			start_ref+offset:start_ref+offset+forward,
			1
		)
	),
	'r'
);

xlim([0 max(temps)]);
xlabel('Temps (s)');
grid on;

print('comp_mon_bin1.png', '-dpng');
