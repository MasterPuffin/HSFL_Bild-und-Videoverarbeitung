%Johannes Bluhm und Marleen Johannsen, 25.05.2020, Laboraufgabe 5, Version 2
%Innere Features

clc; %Kommandofenster bereinigen
clear; %Variablen bereinigen
close all; %alles schlieï¿½en

img = double(imread('coins_and_keys.jpg'))/255; %Bild einlesen und speichern als double
imgGr = rgb2gray(img); %In Graustufen umwandeln
thresh = graythresh(imgGr); %Automatisches TH
imgBW = imbinarize(imgGr, thresh); %Threshold
imgInv = ~imgBW; %Bild invertieren
imgFill = imfill(imgInv, 'holes'); %Lücken füllen

%Ausgaben
figure(1); subplot(2,2,1); %Fenster mit 2x2 subplot
imshow(img); %Anzeigen des eingelesenen Bildes
axis on; title('Originalbild'); %Titel und Achsen
xlabel('Pixel'); ylabel('Pixel'); %Achsen Beschriftung
subplot(2,2,2);
imshow(imgBW); %Anzeigen des eingelesenen Bildes
axis on; title('Schwarzweißbild'); %Titel und Achsen
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

count = size(s) %Länge des Arrays bestimmen 

sm = struct([]); %Neues leeres Structure Array
a = zeros;b = zeros;c = zeros;
counter = 1; %Counter für Zeilen

for i=1:count(1) %(forschleife durchlaufen)
    Area = s(i).Area; %Wert an jeweiliger Stelle für Fläche speichern
    if ( Area > 3000 ) % !kleine Objekte nicht betrachten!
        sm(counter).Area = s(i).Area; %Wert für Area kopieren
        a(counter) = s(i).Area; %Fläche für plot in einen Vektor schreiben
        
        sm(counter).ConvexArea = s(i).ConvexArea; %Wert für ConvexArea kopieren
        b(counter) = s(i).ConvexArea; %Konvexe Fläche für plot in einen Vektor schreiben
        
        sm(counter).Solidity = s(i).Solidity; %Wert für Solidität kopieren
        c(counter) = s(i).Solidity; %Solidität für plot in einen Vektor schreiben
        
        sm(counter).Perimeter = s(i).Perimeter; %Wert für Umfang kopieren
        sm(counter).Orientation = s(i).Orientation; %Wert für Ausrichtung kopieren
        
        counter= counter+1; %Counter erhöhen
    end
end

[val,ind] = max([s.Area]); %Größtes Objekt finden

disp(sprintf('Area: %f', s(ind).Area)); %Größe des Elements
disp(sprintf('ConvexArea: %f', s(ind).ConvexArea)); %Konvexe Fläche
disp(sprintf('Solidity: %f', s(ind).Solidity)); %Solidität
disp(sprintf('Perimeter: %f', s(ind).Perimeter)); %Umfang
disp(sprintf('Orientation: %f', s(ind).Orientation)); %Orientierung

 
figure(2); plot(a, b, 'ro'); xlabel('Area'); ylabel('ConvexArea'); %2D Graph mit Area und ConvexArea
figure(3); scatter3(a,b,c); xlabel('Area'); ylabel('ConvexArea'); zlabel('Solidity'); %3D Graph mit allen Features

%Größtes Objekt
figure(4); imshow(s(ind).Image,'InitialMagnification','fit'); %
xlabel('Pixel'); ylabel('Pixel'); title('Größtes Objekt'); %Beschriftungen

%Konvexe Hülle
figure(5);%Fenster 5 öffnen
imshow(s(ind).ConvexImage, 'InitialMagnification','fit'); %Konvexe Hülle anzeigen
xlabel('Pixel'); ylabel('Pixel'); title('Konvexe Hülle des größten Objektes'); %Beschriftungen