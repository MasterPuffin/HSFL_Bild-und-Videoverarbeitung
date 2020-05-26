%Johannes Bluhm und Marleen Johannsen, 25.05.2020, Laboraufgabe 5, Version 2
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
s = regionprops(imgFill, 'all');

count = size(s) %L�nge des Arrays bestimmen 

sm = struct([]); %Neues leeres Structure Array
a = zeros;b = zeros;c = zeros;
counter = 1; %Counter f�r Zeilen

for i=1:count(1) %(forschleife durchlaufen)
    Area = s(i).Area; %Wert an jeweiliger Stelle f�r Fl�che speichern
    if ( Area > 3000 ) % !kleine Objekte nicht betrachten!
        sm(counter).Area = s(i).Area; %Wert f�r Area kopieren
        a(counter) = s(i).Area; %Fl�che f�r plot in einen Vektor schreiben
        
        sm(counter).ConvexArea = s(i).ConvexArea; %Wert f�r ConvexArea kopieren
        b(counter) = s(i).ConvexArea; %Konvexe Fl�che f�r plot in einen Vektor schreiben
        
        sm(counter).Solidity = s(i).Solidity; %Wert f�r Solidit�t kopieren
        c(counter) = s(i).Solidity; %Solidit�t f�r plot in einen Vektor schreiben
        
        sm(counter).Perimeter = s(i).Perimeter; %Wert f�r Umfang kopieren
        sm(counter).Orientation = s(i).Orientation; %Wert f�r Ausrichtung kopieren
        
        counter= counter+1; %Counter erh�hen
    end
end

[val,ind] = max([s.Area]); %Gr��tes Objekt finden

disp(sprintf('Area: %f', s(ind).Area)); %Gr��e des Elements
disp(sprintf('ConvexArea: %f', s(ind).ConvexArea)); %Konvexe Fl�che
disp(sprintf('Solidity: %f', s(ind).Solidity)); %Solidit�t
disp(sprintf('Perimeter: %f', s(ind).Perimeter)); %Umfang
disp(sprintf('Orientation: %f', s(ind).Orientation)); %Orientierung

 
figure(2); plot(a, b, 'ro'); xlabel('Area'); ylabel('ConvexArea'); %2D Graph mit Area und ConvexArea
figure(3); scatter3(a,b,c); xlabel('Area'); ylabel('ConvexArea'); zlabel('Solidity'); %3D Graph mit allen Features

%Gr��tes Objekt
figure(4); imshow(s(ind).Image,'InitialMagnification','fit'); %
xlabel('Pixel'); ylabel('Pixel'); title('Gr��tes Objekt'); %Beschriftungen

%Konvexe H�lle
figure(5);%Fenster 5 �ffnen
imshow(s(ind).ConvexImage, 'InitialMagnification','fit'); %Konvexe H�lle anzeigen
xlabel('Pixel'); ylabel('Pixel'); title('Konvexe H�lle des gr��ten Objektes'); %Beschriftungen