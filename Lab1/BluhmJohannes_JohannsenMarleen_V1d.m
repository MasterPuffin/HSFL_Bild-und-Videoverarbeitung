%Johannes Bluhm und Marleen Johannsen, 13.04.2020, Laboraufgabe 1, Version 1
%1. Matrizenverarbeitung: Erstellen und speichern eines Bildes

clc; %Kommandofenster bereinigen
clear; %Variablen bereinigen
close all; %alles schließen

A = zeros(256,256); %Leere Matrix erstellen
h = 20; %Rechteck H�he
w = 100; %Rechteck Breite
A(256/2-h/2:256/2+h/2,256/2-w/2:256/2+w/2,:) = 0.5; %Rechteck in Matrix platzieren

figure(1); %Ein neues Fenster öffnen
imshow(A); %Bild ausgeben
axis on; %Achsen sichtbar machen
title('BW-Intensity Bild'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung
imwrite(A, 'export.png'); %Bild in Datei speichern
