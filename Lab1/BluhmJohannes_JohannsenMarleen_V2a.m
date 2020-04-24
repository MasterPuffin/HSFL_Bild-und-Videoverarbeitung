%Johannes Bluhm und Marleen Johannsen, 24.04.2020, Laboraufgabe 2, Version 1
%1. Erstellen eines HSV Farbstrahls als Subplot aus der VL Folie

clc; %Kommandofenster bereinigen
clear; %Variablen bereinigen
close all; %alles schlie�en

s1 = ones(100,400); %saturation matrix
v1 = ones(100,400); %value matrix
s2 = ones(100,400)*0.5; %saturation matrix mit 0.5 (geringere S�ttigung)
v2 = ones(100,400)*0.5; %value matrix mit 0.5 (geringere Helligkeit)
h = 0:(1/399):1; %hue Werte von 0 bis 1 auf 400 Schritte auf die Spalten aufgeteilt
hlong = repmat(h, 100, 1); %100 Zeilen hinzugef�gt mit  den selben Werten

hsv1(:,:,1) = hlong; %im hue Kanal hlong Matrix eingef�gt
hsv1(:,:,2) = s1; %im saturation Kanal s1 Matrix eingef�gt
hsv1(:,:,3) = v1;  %im value Kanal v1 Matrix eingef�gt

hsv2(:,:,1) = hlong; %im hue Kanal hlong Matrix eingef�gt
hsv2(:,:,2) = s2; %im saturation Kanal s2 Matrix eingef�gt
hsv2(:,:,3) = v1; %im value Kanal v1 Matrix eingef�gt

hsv3(:,:,1) = hlong; %im hue Kanal hlong Matrix eingef�gt
hsv3(:,:,2) = s1;  %im saturation Kanal s1 Matrix eingef�gt
hsv3(:,:,3) = v2; %im value Kanal v2 Matrix eingef�gt

%Wie kann man die  x-Achse manipulieren?? Sodass die Werte von 1 bis 0
%gezeigt werden,  nicht die "Pixel"? Bei  Google nichts gefunden...

%Bild mit hoher Helligkeit und S�ttigung
subplot(3,1,1); %�ffnen eines Subplots mit 3 Zeilen
sgtitle("HSV-Werte im Matlab Modell"); %Titel f�r alle subplots
imshow(hsv2rgb(hsv1)); %Umwandlung von hsv in rgb und Ausgabe
title("Saturation=1, Value=1"); %Titel des ersten  subplots

%Bild mit hoher Helligkeit aber geringerer  S�ttigung
subplot(3,1,2); %Zweiter subplot
imshow(hsv2rgb(hsv2)); %Umwandlung von hsv in rgb und Ausgabe
title("Saturation=0.5, Value=1"); %Titel des zweiten subplots

%Bild mit geringerer Helligkeit undhoher S�ttigung
subplot(3,1,3); %Dritter subplot
imshow(hsv2rgb(hsv3)); %Umwandlung von hsv in rgb und Ausgabe
title("Saturation=1, Value=0.5"); %Titel des dritten subplots
