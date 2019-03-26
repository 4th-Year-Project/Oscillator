instrreset
SerialReciever = serial("COM4")
fopen(SerialReciever)
recieved_array = 0;
data_array = 0;

% wait for "DATA" keyword
while(isvalid(SerialReciever)) 
    recieved = (fgetl(SerialReciever))
    if recieved == "DATA"
        break
    end
end

% Read number of values
recieved = str2num(fgetl(SerialReciever))
assert(floor(recieved) == recieved, "number of samples not integer")
number_of_samples = recieved
recieved = str2num(fgetl(SerialReciever)) %dump sample inbetween

%Read in samples
for I = 1:(number_of_samples -1)
    recieved = str2num(fgetl(SerialReciever))
    data_array = [data_array, recieved]
end

