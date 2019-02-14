%{
MIT License

Copyright (c) 2019 Savyasachi Jha

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
%}

% -------------------------------------------------------------------------
% ZOH: upsamples input signal and applies zero order hold
% -------------------------------------------------------------------------

function signal_out = zoh(signal_in, upsampling_factor)
    % upsamples by factor L
    upsampled_signal = upsample(signal_in, upsampling_factor);
    % applies ZOH to upsampled signal
    for i = 1:length(upsampled_signal)
        if i == 1 || rem(i,upsampling_factor)-1 == 0
            signal_out(i+1:i+upsampling_factor) = upsampled_signal(i);
        end
    end
end
