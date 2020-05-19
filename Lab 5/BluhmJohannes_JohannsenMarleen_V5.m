%Johannes Bluhm und Marleen Johannsen, 18.05.2020, Laboraufgabe 5, Version 1
%Innere Features

clc; %Kommandofenster bereinigen
clear; %Variablen bereinigen
close all; %alles schlie�en

img = double(imread('coins_and_keys.jpg'))/255; %Bild einlesen und speichern als double
imgGr = rgb2gray(img); %In Graustufen umwandeln
thresh = graythresh(imgGr); %Automatisches TH
imgBW = imbinarize(imgGr, thresh); %Threshold
imgInv = ~imgBW; %Bild invertieren
imgFill = imfill(imgInv, 'holes'); %L�cken f�llen

%Ausgaben
figure(1); subplot(2,2,1); %Fenster mit 2x2 subplot
imshow(img); %Anzeigen des eingelesenen Bildes
axis on; title('Originalbild'); %Titel und Achsen
xlabel('Pixel'); ylabel('Pixel'); %Achsen Beschriftung
subplot(2,2,2);
imshow(imgBW); %Anzeigen des eingelesenen Bildes
axis on; title('Schwarzwei�bild'); %Titel und Achsen
xlabel('Pixel'); ylabel('Pixel'); %Achsen Beschriftung 
subplot(2,2,3);
imshow(imgInv); %Anzeigen des eingelesenen Bildes
axis on; title('Invertiertes Bild'); %Titel und Achsen
xlabel('Pixel'); ylabel('Pixel'); %Achsen Beschriftung
subplot(2,2,4);
imshow(imgFill); %Anzeigen des eingelesenen Bildes
axis on; title('Vorbereitetes Bild'); %Titel und Achsen
xlabel('Pixel'); ylabel('Pixel'); %Achsen Beschriftung

%Regionprobs bestimmen
rp = regionprops(imgFill, 'area', 'eccentricity', 'solidity', 'Perimeter', 'orientation');

count = size(rp) %L�nge des Arrays bestimmen 
for i=1:count(1) %(forschleife durchlaufen)
    Area = rp(i).Area; %Wert an jeweiliger Stelle f�r Fl�che speichern
    if ( Area < 1000 ) % !kleine Objekte nicht betrachten!
        a(i) = 0; %Area l�schen
        e(i) = 0; %Exzentrizit�t l�schen
        s(i) = 0; %Solidit�t l�schen
        ex(i)= 0; %Umfang l�schen
        o(i) = 0; %Rotation l�schen
    else
        a(i) = rp(i).Area; %Fl�che speichern
        e(i) = rp(i).Eccentricity; %Exzentrizit�t speichern
        s(i) = rp(i).Solidity; %Solidit�t speichern
        ex(i)= rp(i).Perimeter; %Umfang speichern
        o(i) = rp(i).Orientation; %Rotation speichern
    end
end
max = max(a) %Gr��tes Objekt finden
maxInd = find(a == max) %Index im Array ermitteln
disp(sprintf('Area: %f', rp(maxInd).Area)); %Gr��e des Elements
disp(sprintf('Eccentricity: %f', rp(maxInd).Eccentricity)); %Exzentrizit�t des Elements
disp(sprintf('Solidity: %f', rp(maxInd).Solidity)); %Solidit�t
disp(sprintf('Perimeter: %f', rp(maxInd).Perimeter)); %Umfang
disp(sprintf('Orientation: %f', rp(maxInd).Orientation)); %Orientierung

figure; plot(a, e, 'ro'); xlabel('Area'); ylabel('Eccentricity'); %2D Graph mit Area und Eccentricity
figure; scatter3(a,e,s); xlabel('Area'); ylabel('Eccentricity'); zlabel('Solidity'); %3D Graph mit allen Features
