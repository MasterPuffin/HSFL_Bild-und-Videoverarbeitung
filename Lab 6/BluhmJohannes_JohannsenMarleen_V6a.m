%Johannes Bluhm und Marleen Johannsen, 03.06.2020, Laboraufgabe 6, Version 1
%Objekterkennung Vorverarbeitung

clc; %Kommandofenster bereinigen
clear; %Variablen bereinigen
close all; %alles schlie�en

%% Bild einlesen

img = double(imread('Parkplatz.jpg'))/255; %Bild einlesen und speichern als double
figure(1); %Fenster �ffnen
imshow(img, 'InitialMagnification','fit'); %Anzeigen des eingelesenen Bildes
title("Eingelesenes Bild Parkplatz"); %Titel
disp("Bildgr��e:"); disp(size(img)); %Gr��e ausgeben

%% Thresholding
imgGr = rgb2gray(img); %In Graustufen umwandeln
imgGr = imadjust(imgGr); %Graustufenbild verbessern
% thresh = graythresh(img); %Automatisches Thresholding
thresh = 0.5; %Auto TH erzeugt nicht lesbare Nummernschilder
imgBW = imbinarize(imgGr, thresh); %Threshold

figure(2); %Fenster �ffnen
imshow(imgBW, 'InitialMagnification','fit'); %SW Bild zeigen
title("Schwarz-wei� Bild"); %Titel

%% Invertieren
imgInv = ~imgBW; %Bild invertieren
figure(3); %Fenster �ffnen
imshow(imgInv, 'InitialMagnification','fit'); %Invertiertes Bild ausgeben
title("Invertiertes Bild"); %Titel

%% Bild labeln
[imLabel, n]= bwlabel(imgInv,8); %Bild labeln
disp("Anzahl gefundene Regionen"); disp(n); 
size_imLabel = size(imLabel)
%Geben sie im Command-Fenster die Gr��e der Variablen aus der Operation mit bwlabel aus (size).
%H�? Wad will er ausgegeben bekommen? Etwa die Gr��e von jedem gefunden
%Objekt? W�re ja seeehr viel (34766!)... oder size(imLabel)? Aber das w�re ja genau
%wie das Original...?
 
%% Regionprops bestimmen
s = regionprops(imLabel, 'Area'); %Regionprops f�r Fl�che
disp("Anzahl gefundene Regionen"); disp(n); %Ausgabe gefundene Objekte

%% Nur entsprechend gro�e Regionen speichern

count = size(s); %L�nge des Arrays bestimmen 
imNeu = zeros(size(imgInv)); %Neues leeres Bild

for i=1:count(1) %(forschleife durchlaufen)
    Area = s(i).Area; %Wert an jeweiliger Stelle f�r Fl�che speichern
    if ( Area > 250 && Area < 950 ) % nur Objekte in bestimmter Gr��e
        imNeu = or(imNeu,(imLabel==i)); %An dieser Stelle im Bild speichern
    end
end

[labelNew, newRegionNum]  = bwlabel(imNeu); %Anzahl Regionen bestimmen...
disp("Anzahl gefundene Regionen neu "+newRegionNum);%...und ausgeben

%% Neues Bild erstellen aus neuen Regionen
%Leider sind noch ein paar Regionen der B�ume und Pflastersteine mit zu
%sehen, die wir nicht herausbekommen haben.

figure(5); %Neues Fenster
imshow(imNeu, 'InitialMagnification','fit'); %Zeigen des neues Bildes
title("Herausgefilterte Nummernschilder anhand der Gr��e"); %Titel

imwrite(imNeu,'Parkplatz_vorverarbeitet.jpg'); %Bild speichern f�r V6b

