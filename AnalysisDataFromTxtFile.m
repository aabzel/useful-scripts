% Analys RSSI log
clc 
clear all
close all




srtPlot1yTilte = 'RSSI diff, [dBm]';
srtPlot2yTilte = 'RSSI diff filtered, [dBm]';
srtPlot3yTilte = 'Out of direction flip flop, ';



srtPlot1xTilte = 'Time, [s]';
srtPlot2xTilte = 'Time, [s]';
srtPlot3xTilte = 'Time, [s]';


fileData =[];


filename   ="RSSIdiffLog21:55:18.135520.txt";
fid = fopen (filename, "r");


i=0;
while ~feof(fid)
   rowC = textscan(fid, "%d %d %d" ,1);
   row = cell2mat(rowC);
   fileData =[fileData ; row];
end


fclose (fid);

figure(1)

hold on;

subplot(3,1,1)
  plot(fileData(:,1),'Color','k','LineWidth',2);
  ylabel(srtPlot1yTilte);
  xlabel(srtPlot1xTilte);
  grid on
subplot(3,1,2)  
  plot(fileData(:,2),'Color','b','LineWidth',2);
  ylabel(srtPlot2yTilte);
  xlabel(srtPlot2xTilte);
  grid on
subplot(3,1,3)
  plot(fileData(:,3),'Color','b','LineWidth',2);
  ylabel(srtPlot3yTilte);
  xlabel(srtPlot3xTilte);
  grid on
hold off;



