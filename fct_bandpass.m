function y = fct_bandpass(x, fs, fr, wt, ws, varargin)
% last update : 2014.10.10
% bandpass filter based on convolution with sinc function kernel or 'fir1', 'firls'(matlab implanted)
%
% x : time series data, m by n matrix.
% m : the number of channels
% n : data time length
%
% fs : sample rate (hz)
% fr : cutoff frequency (hz)
% wt : window type. 'hamming', 'blackman', 'fir1', 'firls'.
% wt : in case of 'fir1' and 'firls', filter type.
% ws : window size. half width (# of samples), i.e. [-ws, ws].
% ws : if wt = 'fir1' or 'firls', filter order.
%
% frc : frequency response curve
% 'frc' option output filter property instead of filtering result.
% 'hide' : output 'frc', but not show.
%
% e.g.) y = fct_bandpass(x, 1000, [10,11], 'hamming', 100)
% e.g.) y = fct_bandpass(x, 2000, [30,32], 'blackman', 200)
% e.g.) y = fct_bandpass(x, 3000, [50,53], 'fir1', 50)
% e.g.) y = fct_bandpass(x, 4000, [55,58], 'firls', 40)
% e.g.) y = fct_bandpass(x, 1000, [10,11], 'hamming', 100, 'frc')
% e.g.) y = fct_bandpass(x, 2000, [30,32], 'blackman', 200, 'frc')
% e.g.) y = fct_bandpass(x, 3000, [50,53], 'fir1', 50, 'frc')
% e.g.) y = fct_bandpass(x, 4000, [55,58], 'firls', 40, 'frc')

[m, n] = size(x);% (number of channel) x (time length)
type_frc = find(strcmpi(varargin, 'frc') == 1);
type_frc_hide = find(strcmpi(varargin, 'hide') == 1);

if strcmpi(wt,'hamming') || strcmpi(wt,'blackman')
    if isempty(type_frc)
        z = fct_lowpass(x, fs, fr(2), wt, ws);
        y = z - fct_lowpass(z, fs, fr(1), wt, ws);
    elseif ~isempty(type_frc)
        y1 = fct_lowpass(x, fs, fr(2), wt, ws, 'frc', 'hide');
        y2 = fct_lowpass(x, fs, fr(1), wt, ws, 'frc', 'hide');
        y = y1 - y2;
        if isempty(type_frc_hide)
            figure;
            subplot(2,1,1); plot(abs(y)); ylabel('magnitude')
            subplot(2,1,2); plot(angle(y)); ylabel('phase'); xlabel('frequency'); ylim([-pi,pi])
        end
    end
    
elseif strcmpi(wt,'fir1')
    filtcoef = fir1(ws, fr*2 / fs);
    if isempty(type_frc)
        for k = 1:m
            if ~isnan( x(k,1) )
                y(k,:) = filtfilt(filtcoef, 1, x(k,:));
            else
                y(k,:) = nan( 1, length( x(k,:) ) );
            end
        end; clear k
    elseif ~isempty(type_frc)
        freqz(filtcoef)
    end
    
elseif strcmpi(wt,'firls')
    filtcoef = firls(ws,...
        [0 (1-0.05)*fr(1)*2/fs fr(1)*2/fs fr(2)*2/fs (1+0.05)*fr(2)*2/fs 1],...
        [0 0 1 1 0 0]);
    if isempty(type_frc)
        for k = 1:m
            y = filtfilt(filtcoef, 1, x(k,:));
        end; clear k
    elseif ~isempty(type_frc)
        freqz(filtcoef)
    end
    
end