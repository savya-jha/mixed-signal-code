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
% Quantizer: quantizes signal 'signal_in' using 'QUANT_BITS' bits
% -------------------------------------------------------------------------

function signal_out = quantize(signal_in, QUANT_BITS)
    % definitions
    SIGNAL_RANGE = range(signal_in);
    QUANT_LEVELS = 2^QUANT_BITS;
    QUANT_RES = SIGNAL_RANGE/QUANT_LEVELS;
    % partitions scalar value range into quantization bins
    partition = zeros(1, QUANT_LEVELS) - abs(min(signal_in));
    for i = 2:length(partition)
        partition(i) = partition(i-1) + QUANT_RES;
    end
    % assigns quantization value to quantizations bins
    quant_val = zeros(1, QUANT_LEVELS);
    for i = 1:QUANT_LEVELS
        quant_val(i) = partition(i) + QUANT_RES/2;
    end
    % quantizes signal (rounding to nearest quantization value)
    for i = 1:length(signal_in)
        for j = 1:QUANT_LEVELS
            if signal_in(i) >= partition(j)
                signal_out(i) = quant_val(j);
            end
        end
    end
end
