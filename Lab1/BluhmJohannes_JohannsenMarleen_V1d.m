%Johannes Bluhm und Marleen Johannsen, 13.04.2020, Laboraufgabe 1, Version 1
%1. Matrizenverarbeitung: Verkleinern des Bildes cameraman.tif

clc; %Kommandofenster bereinigen
clear; %Variablen bereinigen
close all; %alles schließen

A = zeros(256,256); %Leere Matrix erstellen
w = 20; %Rechteck Breite
h = 100; %Rechteck Höhe
A(256/2-h/2:256/2+h/2,256/2-w/2:256/2+w/2,:) = 0.5; %Rechteck in Matrix platzieren

figure(1); %Ein neues Fenster öffnen
imshow(A); %Bild ausgeben
axis on; %Achsen sichtbar machen
title('BW-Intensity Bild'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung
imwrite(A, 'export.jpeg'); %Bild in Datei speichern
