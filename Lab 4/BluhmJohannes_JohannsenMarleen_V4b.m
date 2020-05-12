%Johannes Bluhm und Marleen Johannsen, 07.05.2020, Laboraufgabe 4, Version 1
%2. Kantenfilter

clc; %Kommandofenster bereinigen
clear; %Variablen bereinigen
close all; %alles schließen

imgO = imread('circuit.tif'); %Bild einlesen und speichern

figure(1); %Ein neues Fenster öffnen
imshow(imgO); %Anzeigen des eingelesenen Bildes
title('Originalbild'); %Titel des Fensters

h = fspecial('sobel'); %Sobel-Kernel (horizontal) erstellen
disp('Horizontaler Kernel');
disp(h); %Kernel ausgeben

imgH = imfilter(imgO, h); %Bild mit horizontalem Kernel filtern

figure(2); %Ein neues Fenster öffnen
imshow(imgH); %Anzeigen des gefilterten Bildes
title('Horizontal gefiltert'); %Titel des Fensters

h = h'; %Kernel nach links drehen
disp('Vertikaler Kernel');
disp(h); %Kernel ausgeben

imgV = imfilter(imgO, h); %Bild mit vertikalem Kernel filtern

figure(3); %Ein neues Fenster öffnen
imshow(imgV); %Anzeigen des vertikal-gefilterten Bildes
title('Vertikal gefiltert'); %Titel des Fensters

thresholdH = graythresh(imgO);%Treshold automatisch bestimmen
disp('Tresholdschwelle horizontal');
disp(thresholdH*255); %Tresholdschwelle als uint8 auf CW
img = imbinarize(imgH, thresholdH); %Mit TH in BW umwandeln

figure(4); %Ein neues Fenster öffnen
imshow(img); %Anzeigen des eingelesenen Bildes
title('Originalbild horizontal gefiltert'); %Titel des Fensters

thresholdV = graythresh(imgV); %Treshold automatisch bestimmen
disp('Tresholdschwelle vertikal');
disp(thresholdV*255); %Tresholdschwelle als uint8 auf CW
img = imbinarize(imgV, thresholdV); %Mit TH in BW umwandeln

figure(5); %Ein neues Fenster öffnen
imshow(img); %Anzeigen des eingelesenen Bildes
title('Originalbild vertikal gefiltert'); %Titel des Fensters