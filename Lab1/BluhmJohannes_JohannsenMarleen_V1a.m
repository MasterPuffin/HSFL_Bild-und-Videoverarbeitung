%Johannes Bluhm und Marleen Johannsen, 13.04.2020, Laboraufgabe 1, Version 1
%1. Matrizenverarbeitung: Verkleinern des Bildes cameraman.tif

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

%Bild um den Faktor 4 verkleinern
imgsm = img(1:4:end,1:4:end);  %Jedes vierte Pixel übernehmen in Zeilen und Spalten  
%Von Zeile 1 bis zur letzten Zeile in vierer Schritten usw.

figure(2); %Zweites Fenster öffnen
imshow(imgsm); %Anzeigen des verkleinerten Bildes

%____WHY the fuck does that NOT WORK??? Zeigt immer diesen Title beim ersten
%Figure und bei diesem hier gar keinen??____

axis on;
title('cameraman.tif verkleinert um Faktor 4'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung

%Konsolenausgaben
disp("Originalbild") %Stringausgabe auf die Konsole
size(img) % Ausgabe der Abmessung des Originalbildes in Pixel
disp("Verkleinertes Bild") %Stringausgabe auf die Konsole
size(imgsm) % Ausgabe der Abmessung des verkleinerten Bildes in Pixel
