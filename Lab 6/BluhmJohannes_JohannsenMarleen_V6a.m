%Johannes Bluhm und Marleen Johannsen, 03.06.2020, Laboraufgabe 6, Version 1
%Objekterkennung Vorverarbeitung

clc; %Kommandofenster bereinigen
clear; %Variablen bereinigen
close all; %alles schließen

img = double(imread('Parkplatz.jpg'))/255; %Bild einlesen und speichern als double

figure(1);
imshow(img); %Anzeigen des eingelesenen Bildes
disp("Bildgröße:"); disp(size(img)); %Größe ausgeben

imgGr = rgb2gray(img); %In Graustufen umwandeln
% thresh = graythresh(img); %Automatisches Thresholding
thresh = 0.555; %Auto TH erzeugt nicht lesbare Nummernschilder
imgBW = imbinarize(imgGr, thresh); %Threshold

figure(2);
imshow(imgBW);

imgInv = ~imgBW; %Bild invertieren

figure(3);
imshow(imgInv);

imLabel = bwlabel(imgInv,8);
imshow(imLabel, []);

imLabel = bwlabel(imgInv,8);
imRgb = label2rgb(imLabel);
figure; imshow(imRgb, 'InitialMagnification','fit');

%blobMeasurements = regionprops(imLabel, imgBW, 'all');
%numberOfBlobs = size(blobMeasurements, 1);
