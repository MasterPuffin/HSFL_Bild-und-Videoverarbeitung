%Johannes Bluhm und Marleen Johannsen, 24.04.2020, Laboraufgabe 2, Version 1
%2. JPEG Fehler

clc; %Kommandofenster bereinigen
clear; %Variablen bereinigen
close all; %alles schließen

img = imread('cameraman.tif'); %Bild einlesen und speichern

figure(1); %Ein neues Fenster öffnen
imshow(img); %Anzeigen des eingelesenen Bildes
axis on; %Achsen sichtbar machen
title('cameraman.tif Originalbild'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung

imwrite(img, 'imgS.jpg', 'Quality', 10, 'BitDepth', 8); %Abspeichern mit geringer Qualität

imgS = imread('imgS.jpg'); %Bild einlesen und speichern

figure(2); %Ein neues Fenster öffnen
imshow(imgS); %Anzeigen des eingelesenen Bildes
colorbar;  %Anzeigen der colorbar
axis on; %Achsen sichtbar machen
title('cameraman.tif mit JPEG Fehler'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung

imgdif = imabsdiff(imgS, img);  %Absolut Differenzbetrag bilden
figure(3); %Ein neues Fenster öffnen
imshow(imgdif); %Anzeigen des eingelesenen Bildes
colorbar;  %Anzeigen der colorbar
axis on; %Achsen sichtbar machen
title('cameraman.tif Differenzbild'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung

disp("MaximalwertDifferenzbild")
max(max(imgdif))

figure(4); %Ein neues Fenster öffnen
imhist(imgdif, 128); %Histogramm um Werte für Kontraststretching zu finden

figure(5);  %Neues Fenster öffnen
imKontrast = imadjust(imgdif, [0 65/255], [0 1]); %Kontrastwerte stretchen

disp("MaximalwertStretchedDifferenzbild")
max(max(imKontrast)) %Neuen Maximalwert  auf die  Konsole

imshow(imKontrast); %Anzeigen des eingelesenen Bildes
colorbar; %Anzeigen der colorbar
axis on; %Achsen sichtbar machen
title('Kontraststretching auf Differenzbild'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung
