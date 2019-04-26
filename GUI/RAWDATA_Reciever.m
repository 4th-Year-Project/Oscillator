instrreset
clear

recieved_array = 0;
data_array = 0;
recieved = ' ';

S = serial('COM4','baud',115200) %device
fopen(S);
instrr
fprintf('waiting for "RAWDATA" keyword')
count =0;
f = waitbar(0,'Please press sample button');
while(1)
    count = count + 1;
    if(isvalid(S) && S.BytesAvailable) %Recieve only if available data
        recieved = (fgetl(S));
    end
    if contains(recieved,'RAWDATA')
        recieved = fgetl(S);
        break
    end
    if (count == 10)
        fprintf('.')
        count = 0;
    end
    pause(0.1)
end

%Read the data
fprintf('\nReading in data [')
waitbar(0,f,'Reading in data')
%data_array = zeros(8000,1);
ch = zeros(4,8000);
for i = 1:(8000 -2)
    recieved = fgetl(S);
    data_array = [data_array, recieved];
    ch(4, i) = [hex2dec(recieved(2:3))];
    ch(3, i) = [hex2dec(recieved(4:5))];
    ch(2, i) = [hex2dec(recieved(6:7))];
    ch(1, i) = [hex2dec(recieved(8:9))];
    if (mod(i,800) == 0)
        fprintf('-')
        waitbar(i/8000,f)
        pause(0.01)
    end
end
close(f)
pause(0.01)
fprintf(']\nComplete')

Ax = gobjects(2*2,1);        % preallocate for the axes handles
for i=1:4
  hAx(i)= subplot(2,2,i);
  plot(ch(i, 1:7998))
end
ylim(hAx,[0 255])
yticks(hAx,[ 0 64 128 192 255])

hold off
figure
plot(1:8000,log10(abs(fft(ch(1,:)))))




