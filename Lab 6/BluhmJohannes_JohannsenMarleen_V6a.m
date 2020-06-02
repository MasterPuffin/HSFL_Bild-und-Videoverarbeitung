%Johannes Bluhm und Marleen Johannsen, 03.06.2020, Laboraufgabe 6, Version 1
%Objekterkennung Vorverarbeitung

clc; %Kommandofenster bereinigen
clear; %Variablen bereinigen
close all; %alles schließen

%% Bild einlesen

img = double(imread('Parkplatz.jpg'))/255; %Bild einlesen und speichern als double
figure(1); %Fenster öffnen
imshow(img, 'InitialMagnification','fit'); %Anzeigen des eingelesenen Bildes
title("Eingelesenes Bild Parkplatz"); %Titel
disp("Bildgröße:"); disp(size(img)); %Größe ausgeben

%% Thresholding
imgGr = rgb2gray(img); %In Graustufen umwandeln
imgGr = imadjust(imgGr); %Graustufenbild verbessern
% thresh = graythresh(img); %Automatisches Thresholding
thresh = 0.5; %Auto TH erzeugt nicht lesbare Nummernschilder
imgBW = imbinarize(imgGr, thresh); %Threshold

figure(2); %Fenster öffnen
imshow(imgBW, 'InitialMagnification','fit'); %SW Bild zeigen
title("Schwarz-weiß Bild mit Thresholding"); %Titel

%% Invertieren
imgInv = ~imgBW; %Bild invertieren
figure(3); %Fenster öffnen
imshow(imgInv, 'InitialMagnification','fit'); %Invertiertes Bild ausgeben
title("Invertiertes Bild"); %Titel

%% Bild labeln
[imLabel, n]= bwlabel(imgInv,8); %Bild labeln
size_imLabel = size(imLabel);
disp("Größe des BWLabels"); disp(size_imLabel);
%Geben sie im Command-Fenster die Größe der Variablen aus der Operation mit bwlabel aus (size).
%Soll hier die Größe von jedem gefunden Objekt ausgebenen werden (34766 mal), oder size(imLabel), was aber identisch mit dem Original wäre? Aber das wäre ja genau

%% Regionprops bestimmen
s = regionprops(imLabel, 'Area'); %Regionprops für Fläche
disp("Anzahl gefundene Regionen"); disp(n); %Ausgabe gefundene Objekte

%% Nur entsprechend große Regionen speichern

count = size(s); %Länge des Arrays bestimmen 
imNeu = zeros(size(imgInv)); %Neues leeres Bild

for i=1:count(1) %(forschleife durchlaufen)
    Area = s(i).Area; %Wert an jeweiliger Stelle für Fläche speichern
    if ( Area > 250 && Area < 950 ) % nur Objekte in bestimmter Größe
        imNeu = or(imNeu,(imLabel==i)); %An dieser Stelle im Bild speichern
    end
end

[labelNew, newRegionNum]  = bwlabel(imNeu); %Anzahl Regionen bestimmen...
disp("Anzahl verbleibende Regionen "+newRegionNum);%...und ausgeben

%% Neues Bild erstellen aus neuen Regionen
%Leider sind noch ein paar Regionen der Bäume und Pflastersteine mit zu
%sehen, die wir nicht herausbekommen haben.

figure(4); %Neues Fenster
imshow(imNeu, 'InitialMagnification','fit'); %Zeigen des neues Bildes
title("Herausgefilterte Nummernschilder anhand der Größe"); %Titel

imwrite(imNeu,'Parkplatz_vorverarbeitet.jpg'); %Bild speichern für V6b

