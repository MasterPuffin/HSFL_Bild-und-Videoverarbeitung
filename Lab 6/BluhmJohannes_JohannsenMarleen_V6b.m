%Johannes Bluhm und Marleen Johannsen, 03.06.2020, Laboraufgabe 6, Version 1
%Objekterkennung Nummernschilder

clc; %Kommandofenster bereinigen
clear; %Variablen bereinigen
close all; %alles schließen


%% Bild einlesen

img = double(imread('fl.jpg'))/255; %Bild einlesen und speichern als double
figure(1);
imshow(img, 'InitialMagnification','fit'); %Anzeigen des eingelesenen Bildes
title("Eingelesenes Bild FL");
disp("Bildgröße:"); disp(size(img)); %Größe ausgeben

%% Thresholding
imgGr = rgb2gray(img); %In Graustufen umwandeln
thresh = graythresh(img); %Automatisches Thresholding
imgBW = imbinarize(imgGr, thresh); %Threshold

figure(2);
imshow(imgBW, 'InitialMagnification','fit');
title("Schwarz-weiß Bild");

%% F Ausschneiden
imgInv = ~imgBW; %Invertieren
imLabel = bwlabel(imgInv, 8);
imgF = zeros(size(imgInv));
imgF = or (imgF, (imLabel==2));
imgF = imfill(imgF, 'holes');
figure(3);
imshow(imgF, 'InitialMagnification','fit');
title("Ausgeschnittenes F");


%% Referenz Fourier Diskrriptoren berechnen
N_abtast = 32;
N_FD = 80; %Anzahl FD

Poly=funcGenPolyPic(imgF, N_abtast);
refPoly=FuncInvarianteFourierDeskriptoren(1, 1, Poly, N_FD);

figure(4);
plot(real(Poly),imag(Poly), 'b*-');
title("Polygonzug F");

figure(5);
bar(abs(refPoly));
title("Spektrum F");
%% Vorverarbeites Bild laden
imgP =imbinarize(imread('Parkplatz_vorverarbeitet.jpg')); %Bild einlesen und speichern als double
figure(6);
imshow(imgP, 'InitialMagnification','fit'); hold on;

%% F erkennen

s = regionprops(imgP, 'image', 'centroid');
count = size(s);

imgPrgb = bwlabel(imgP, 8);
imgRGB = label2rgb(imgPrgb);
figure; imshow(imgRGB);

for i=1:count(1)
im = s(i).Image;
centroid = s(i).Centroid; % zum markieren
polygon = funcGenPolyPic(im, N_abtast);

FDVec = FuncInvarianteFourierDeskriptoren(1, 1, polygon, N_FD);
% Abstandsmass des aktuellen Objektes zum Muster berechnen
abstand(i) = sum( abs(refPoly - FDVec) );
% erkannte Objekte ins Originalbild eintragen
if ( abstand(i) < 0.5 )
figure(6); plot(centroid(1), centroid(2), 'r*');
end
end

% Er erkennt die F's niocht gut, weil das F nicht als einzelne Region
% eerkannt wird, sondern zusammen mit dem "L". Muss bei der Vorverarbeitung
% besser geearbeitet werden...?
