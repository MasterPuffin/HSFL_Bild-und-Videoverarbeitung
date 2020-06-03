%Johannes Bluhm und Marleen Johannsen, 03.06.2020, Laboraufgabe 6, Version2
%Objekterkennung Nummernschilder

clc; %Kommandofenster bereinigen
clear; %Variablen bereinigen
close all; %alles schließen


%% Bild einlesen

img = double(imread('fl.jpg'))/255; %Bild einlesen und speichern als double
figure(1); %Fenster öffnen
imshow(img, 'InitialMagnification','fit'); %Anzeigen des eingelesenen Bildes
title("Eingelesenes Bild FL"); %Titel
disp("Bildgröße:"); disp(size(img)); %Größe ausgeben

%% Thresholding
imgGr = rgb2gray(img); %In Graustufen umwandeln
thresh = graythresh(img); %Automatisches Thresholding
imgBW = imbinarize(imgGr, thresh); %Threshold
figure(2); %Neues Fenster
imshow(imgBW, 'InitialMagnification','fit'); %Anzeigen SW Bild
title("Schwarz-weiß Bild"); %Titel

%% F Ausschneiden
imgInv = ~imgBW; %Invertieren
imgInv = imfill(imgInv, 'holes');
imgF = imgInv(3:end, 1:floor(end/2));% nur linke Seite (F) verwenden
figure(3); %neues fenster
imshow(imgF, 'InitialMagnification','fit'); %Anzeigen des F
title("Ausgeschnittenes F");%titel


%% Referenz Fourier Diskrriptoren berechnen
N_abtast = 32;
N_FD = 80; %Anzahl FD

Poly=funcGenPolyPic(imgF, N_abtast);%Polygonzug berechnen
refPoly=FuncInvarianteFourierDeskriptoren(1, 1, Poly, N_FD); %Referenzpolygon FD berechnen

figure(4);%Fenster öffnen
plot(real(Poly),imag(Poly), 'b*-');%Referenzpolygonzug zeigen
title("Polygonzug F"); %Titel

figure(5); %Fenster öffnen
bar(refPoly);%Spektrum anzeigen
title("Spektrum F");%titel

%% Vorverarbeites Bild laden
imgPre =imbinarize(imread('Parkplatz_vorverarbeitet.jpg')); %Bild einlesen und speichern und in SW umwandeln
imgOrg =imread('Parkplatz.jpg'); %Bild einlesen und speichern und in SW umwandeln
figure(6); imshow(imgOrg, 'InitialMagnification','fit'); hold on; %Bild anzeigen für später und Fenster offen halten
title("Erkannte F's im Originalbild");
%% F erkennen

s = regionprops(imgPre, 'image', 'centroid'); %regionprops bestimmen
count = size(s); %Größe für for-Schleife

for i=1:count(1) %in forSchleife jedes Bild und Schwerpunkt speichern
    im = s(i).Image; %Bild speichern
    centroid = s(i).Centroid; % zum markieren
    polygon = funcGenPolyPic(im, N_abtast); %von jedem Bild den Polygonzug bestimmen

    FDVec = FuncInvarianteFourierDeskriptoren(1, 1, polygon, N_FD); %...und die Fourierdiskriptoren berechnen
    abstand(i) = sum(abs(refPoly - FDVec) ); %abstand zueinander berechnen
    % erkannte Objekte ins Originalbild eintragen
    if ( abstand(i) < 0.3) %wenn Abstand kleiner 0.3 dann...
        figure(6); plot(centroid(1), centroid(2), 'r*'); %F erkannt und Schwerpunkt einzeichnen
        disp("KoordinateX"); sprintf('%f',centroid(1)) %X-Koordinate
        disp("KoordinateY"); sprintf('%f',centroid(2)) %Y-Koordinate
    end
end

  figure(7); %neues Fenster
  bar(abstand); %Abstand zeigen
  title("Abstand der Fourier-Diskriptoren der entsprechenden Objekte");%Titel
