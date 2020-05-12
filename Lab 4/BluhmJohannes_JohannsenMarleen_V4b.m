%Johannes Bluhm und Marleen Johannsen, 07.05.2020, Laboraufgabe 4, Version 1
%2. Kantenfilter

clc; %Kommandofenster bereinigen
clear; %Variablen bereinigen
close all; %alles schlieöen

imgO = imread('circuit.tif'); %Bild einlesen und speichern

figure(1); %Ein neues Fenster öffnen
imshow(imgO); %Anzeigen des eingelesenen Bildes
title('Originalbild'); %Titel des Fensters

h = fspecial('sobel'); %Sobel-Kernel (horizontal) erstellen
disp(h); %Kernel ausgeben

imgH = imfilter(imgO, h); %Bild mit horizontalem Kernel filtern

figure(2); %Ein neues Fenster öffnen
imshow(imgH); %Anzeigen des gefilterten Bildes
title('Horizontal gefiltert'); %Titel des Fensters

h = h'; %Kernel nach links drehen
disp(h); %Kernel ausgeben

imgV = imfilter(imgO, h); %Bild mit vertikalem Kernel filtern

figure(3); %Ein neues Fenster öffnen
imshow(imgV); %Anzeigen des eingelesenen Bildes
title('Vertikal gefiltert'); %Titel des Fensters

img = imbinarize(imgO, imgH); %Horizontalen Filter auf Originalbild anwenden

figure(4); %Ein neues Fenster öffnen
imshow(img); %Anzeigen des eingelesenen Bildes
title('Originalbild horizontal gefiltert'); %Titel des Fensters

img = imbinarize(imgO, imgV); %Vertikalen Filter auf Originalbild anwenden

figure(5); %Ein neues Fenster öffnen
imshow(img); %Anzeigen des eingelesenen Bildes
title('Originalbild vertikal gefiltert'); %Titel des Fensters

disp(uint8(imgH)); %Horizontalen Threshold ausgeben
disp(uint8(imgV)); %Vertikalen Threshold ausgeben