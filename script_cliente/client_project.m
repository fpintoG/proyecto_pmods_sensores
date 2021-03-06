%client side implementation

%sensor buffers
IRDistBuff = nan(1,1000);
USDistBuff = nan(1,1000);
fusionDataBuff = nan(1,1000);

timeBuff = nan(1,1000);

%set up Plot
figure(1)
plotGraph = plot(IRDistBuff,'-r' );  
hold on                            
plotGraph1 = plot(USDistBuff,'-b');
hold on
plotGraph2 = plot(fusionDataBuff,'-g' );
title('Sensor distance data','FontSize',15);
xlabel('Time [-]','FontSize',15);
ylabel('Distance [cm]','FontSize',15);
legend('IR sensor','US sensor','sensor fusion')
grid on;

figure(2)
plotGraph4 = plot(timeBuff,'-g' );
title('Ethernet link meassure','FontSize',15);
xlabel('Time [-]','FontSize',15);
ylabel('Request time [s]','FontSize',15);
grid on

%server connection
t = tcpclient('192.168.1.10', 7);

while(1)
    %ask the server for sensor data
    write(t,1);
    IRSensor = str2double(native2unicode(read(t,8)))
    USSensor = str2double(native2unicode(read(t,8)))
    fusionData = str2double(native2unicode(read(t,8)))
    
    %plot realtime data
    IRDistBuff = [IRDistBuff(2:end) IRSensor];
    USDistBuff = [USDistBuff(2:end) USSensor];
    fusionDataBuff = [fusionDataBuff(2:end) fusionData];
    
    set(plotGraph,'YData',IRDistBuff);
    set(plotGraph1,'YData',USDistBuff);
    set(plotGraph2,'YData',fusionDataBuff);
end


%link time test
% while(1)
%     %ask the server for sensor data
%     write(t,1);
%     tic
%     Sensor = read(t,24);
%     time = toc;
%     
%     %plot ethernet link time
%     timeBuff = [timeBuff(2:end) time];
%     
%     set(plotGraph4,'YData',timeBuff);
% end
