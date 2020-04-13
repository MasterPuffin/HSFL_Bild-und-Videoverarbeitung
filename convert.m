%Johannes Bluhm und Marleen Johannsen, 13.04.2020, Laboraufgabe 1, Version 1
%2. Matrizenverarbeitung: Bild konvertieren cameraman.tif
%Hier das selbe Problem mit den figure titles...

clc; %Kommandofenster bereinigen
clear; %Variablen bereinigen
close all; %alles schlie�en

img = imread('cameraman.tif'); %Bild einlesen und speichern

figure(1); %Ein neues Fenster �ffnen
imshow(img); %Anzeigen des eingelesenen Bildes
axis on; %Achsen einblenden
title('cameraman.tif Originalbild'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung

size(img) %Gr��e in Pixel im Commandwindow

%Konvertierung in ein sw-Bild
imgbw = img > 125; %Alle Intensit�ten gr��er 125 werden 1 und kleiner werden 0, also nur schwarz oder wei�

figure(2); %Ein neues Fenster �ffnen
imshow(imgbw); %Anzeigen des eingelesenen Bildes
axis on; %Achsen einblenden
title('cameraman.tif SW'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung

img(end-9:end, 1:10) % 10 Werte untere linke Ecke ins Command Window
imgbw(end-9:end, 1:10) %10 Werte untere linke Ecke ins Command Window sw Bild

figure(3); %Drittes Fenster �ffnen
imshow(imgbw(end-9:end, 1:10)); %Ausgabe der unteren linken Ecke
axis on; %Achsen einblenden
title('Untere linke Ecke cameraman.tif in SW'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung


