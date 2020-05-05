%Johannes Bluhm und Marleen Johannsen, 05.05.2020, Laboraufgabe 3, Version 1
%1. Tresholding im HSV Raum

clear; close all
im = imread('OakBluffs.jpg');

figure(1); %Ein neues Fenster öffnen
imshow(im); %Anzeigen des eingelesenen Bildes
title('OakBluffs.jpg Originalbild'); %Titel des Fensters

imHSV = rgb2hsv(im); %Bild in HSV konvertieren
imMask = and((imHSV(:,:,1) > 0.8),(imHSV(:,:,1) < 0.97)); %Farbwert eingrenzen
imMask = and(and(imMask, imHSV(:,:,2) > 0.1),(and(imMask, imHSV(:,:,2) < 0.3))); %Sättigungswert zwischen 0.1 und 0.3
imMask = and(and(imMask, imHSV(:,:,3) > 0.35),(and(imMask, imHSV(:,:,3) < 0.75))); % Helligkeit zwischen 0.35 und 0.75

figure(2); %Ein neues Fenster öffnen
imshow(imMask); %Anzeigen des eingelesenen Bildes
title('OakBluffs.jpg gefiltert'); %Titel des Fensters