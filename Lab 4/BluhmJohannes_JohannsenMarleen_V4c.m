%Johannes Bluhm und Marleen Johannsen,07.05.2020, Laboraufgabe 4, Version 1
%3. Automatisches Thresholding Optimierung

clc; %Kommandofenster bereinigen
clear; %Variablen bereinigen
close all; %alles schlie�en

img = imread('rice.png'); %Bild einlesen

figure(1); %Ein neues Fenster �ffnen
imshow(img); %Anzeigen des eingelesenen Bildes
axis on; %Achsen sichtbar machen
title('Originalbild'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung

imFilt = imfilter(img, fspecial('average', [100 100]), 'replicate'); %Bild mit einem sehr gro�en Mittelwert filtern umd nur Helligkeitsverteilung zu erhalten

figure(2); %Ein neues Fenster �ffnen
imshow(imFilt); %Anzeigen der Helligkeitsverteilung
axis on; %Achsen sichtbar machen
title('Originalbild'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung

imgDif = img - (imFilt); %Differenzbilden Originalbild und Helligkeitsbild
imgDif = imgDif - min(min(imgDif)); %In den positiven Bereich verschieben

figure(3); %Ein neues Fenster �ffnen
imshow(imgDif); %Differenzbild
axis on; %Achsen sichtbar machen
title('Differenzbild'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung

imgDifbr = imadjust(imgDif);

figure(4); % Neues Fenster �ffnen
imshow(imgDifbr); %Anzeigen des gefilterten Bildes
axis on; %Achsen sichtbar machen
title('Bild nach Helligkeitsnivellierung'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung

minWert= min(min(imgDifbr)) %Minimaler Wert des Bildes auf CW (ist 0)

thresh = graythresh(imgDif); %automatische Thresholdschwelle bestimmen
imgBW = imbinarize(imgDif, thresh); %mit dem Threshold in schwarzwei� umwandeln

figure(5); %Neues Fenster
imshow(imgBW); %Anzeigen des maskierten Bildes
axis on; %Achsen sichtbar machen
title('Thresholding'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung
