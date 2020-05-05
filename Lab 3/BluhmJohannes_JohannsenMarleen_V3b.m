%Johannes Bluhm und Marleen Johannsen, 05.05.2020, Laboraufgabe 3, Version 1
%2. Automatisches Thresholding

clc; %Kommandofenster bereinigen
clear; %Variablen bereinigen
close all; %alles schlie�en

img = imread('rice.png'); %Bild einlesen und speichern

figure(1); %Ein neues Fenster �ffnen
subplot(1,3,1);
imshow(img); %Anzeigen des eingelesenen Bildes
axis on; %Achsen sichtbar machen
title('Originalbild'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung

subplot(1,3,2);
% Histogramm und Threshold-Selektion (automatisch)
threshold = graythresh(img); % Tresholdingschwelle festlegen automatisch zwischen [0 1]
imBW = imbinarize(img, threshold); % in SW umwandeln mit Threshold von oben
imshow(imBW); %Thresholding Maske zeigen
axis on; %Achsen sichtbar machen
title('Automatisches Thresholding'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung

%Per Hand Treshhold Werte anpassen
subplot(1,3,3); %Subplot 3
imTh = adaptthresh(img, 0.45);%Tresholdschwelle anpassen
imBWh = imbinarize(img, imTh); %in sw umwandeln mit neuer Treshholdschwelle
imshow(imBWh); %Ausgeben
axis on; %Achsen sichtbar machen
title('Angepasst'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung

figure(2); %Fenster �ffnen
subplot(3,1,1); %subplot
imhist(img, 128); %Histogramm  ausgeben
title("Histogramm Originalbild"); %Titel

subplot(3,1,2); %Subplot
imgO = img(1:100,:); %obere 100 Zeilen
imhist(imgO, 128); %Histogramm  ausgeben
title("Obere 100 Zeilen"); %Titel

subplot(3,1,3); %Subplot
imgU = img(end-99:end,:); %untere 100 Zeilen
imhist(imgU, 128); %Histogramm  ausgeben
title("Untere 100 Zeilen"); %Titel
