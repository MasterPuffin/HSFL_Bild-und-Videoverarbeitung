%Johannes Bluhm und Marleen Johannsen, 13.04.2020, Laboraufgabe 1, Version 1
%1. Matrizenverarbeitung: Verkleinern des Bildes cameraman.tif

clc; %Kommandofenster bereinigen
clear; %Variablen bereinigen
close all; %alles schließen

img = imread('cameraman.tif'); %Bild einlesen und speichern
figure(1); %Ein neues Fenster öffnen
imshow(img); %Anzeigen des eingelesenen Bildes
axis on; %Achsen sichtbar machen
title('Eingelesenes Bild'); %Titel des Fensters

img = double(img)/255; %Matrix in double konvertieren
imSmall = img(50:50+35, 100:100+32); %Ausschnitt aus Bild wählen
figure(2); %Ein neues Fenster öffnen
imshow(imSmall); %Anzeigen des ausgeschnittenen Bildes
axis on; %Achsen sichtbar machen
title('Ausschnitt'); %Titel des Fensters
imBig = imSmall(floor(1:(1/4):32+(1-(1/4))), floor(1:(1/4):32+(1-(1/4)))); %Ausschnitt vergrößern

figure(3); %Ein neues Fenster öffnen
imshow(imBig); %Anzeigen des vergrößerten Bildes
axis on; %Achsen sichtbar machen
title('Vergrößerter Ausschnitt'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung

%Der Prozess ist im Endeffekt ein Gauß-Filter
%(https://de.wikipedia.org/wiki/Gauß-Filter), der das Bild weichzeichnet
imBig = filter([0.2 0.2 0.2 0.2 0.2], 1, imBig); %Bild filtern
figure(4); %Ein neues Fenster öffnen
imshow(imBig); %Anzeigen des gefilterten Bildes
axis on; %Achsen sichtbar machen
title('Erster Filterungsdurchgang'); %Titel des Fensters
imBig = imrotate(imBig, 90); %Bild drehen
imBig = filter([0.2 0.2 0.2 0.2 0.2], 1, imBig); %Bild filtern
imBig = imrotate(imBig, 270); %Bild zurückdrehen

figure(5); %Ein neues Fenster öffnen
imshow(imBig); %Anzeigen des eingelesenen Bildes
axis on; %Achsen sichtbar machen
title('Gefilterter Ausschnitt'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung

