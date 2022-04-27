%% Open
clear
nidaq_config_sz_debug;
nicfg.arduino_serial = serial(sprintf('COM%i', nicfg.ArduinoCOM), 'BaudRate', nicfg.baumrate);
fopen(nicfg.arduino_serial);
disp('Opened.')

%% Parse
nidaq_config_sz_debug;
omniboxparse(nicfg)

%% Bytes
nicfg.arduino_serial.BytesAvailable

%% Type cast
typecast(int32(val),'uint8')

%% run
fwrite(nicfg.arduino_serial, uint8([1 0]));
disp('Running')

%% read
fwrite(nicfg.arduino_serial, uint8([5 0]));
val = fread(nicfg.arduino_serial, 1, 'int32');
disp(val);

%% Scheduler
fwrite(nicfg.arduino_serial, uint8([255 0]));
val = fread(nicfg.arduino_serial, 1, 'int32');
typecast(int32(val), 'uint8')

%% RNG
fwrite(nicfg.arduino_serial, uint8([255 38]));
val = fread(nicfg.arduino_serial, 1, 'int32');
typecast(int32(val), 'uint8')

%% RNG pass chance
fwrite(nicfg.arduino_serial, uint8([255 39]));
val = fread(nicfg.arduino_serial, 1, 'int32');
typecast(int32(val), 'uint8')

%% stop
fwrite(nicfg.arduino_serial, uint8([0 0]));
val = fread(nicfg.arduino_serial, 1, 'int32');
disp(val);

%% Close
fclose(nicfg.arduino_serial);
disp('Closed.')

%% Reset
fwrite(nicfg.arduino_serial, uint8([253 104]));
fclose(nicfg.arduino_serial);
disp('Reset and closed.')

%% test
write(nicfg.arduino_serial, [255 0]); 