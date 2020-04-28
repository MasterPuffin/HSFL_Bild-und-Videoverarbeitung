%Johannes Bluhm und Marleen Johannsen, 24.04.2020, Laboraufgabe 2, Version 1
%3. RGB Video

clc; %Kommandofenster bereinigen
clear; %Variablen bereinigen
close all; %alles schließen

img = imread('WhiteHouse.jpg'); %Bild einlesen und speichern

figure(1); %Ein neues Fenster öffnen
imshow(img); %Anzeigen des eingelesenen Bildes
axis on; %Achsen sichtbar machen
title('WhiteHouse.jpg Originalbild'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung

img = imresize(img, [150,200]); %Bildgröße ändern

figure(2); %Ein neues Fenster öffnen
imshow(img); %Anzeigen des eingelesenen Bildes
axis on; %Achsen sichtbar machen
title('WhiteHouse.jpg verkleinert'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung

writerObj = VideoWriter('whitehouse.avi'); %Ausgabedatei festlegen
writerObj.FrameRate = 1; %Framerate festlegen

frames = 10; %Anzahl der Frames festlegen
pixelCount = 0; %Initialisiere Pixelzähler

open(writerObj); %Video writer öffnen
%Durch alle Frames loopen
for u=1:frames     
    RGB = insertShape(img,'FilledRectangle',[u*10 u*10 10 10], 'color','red'); %Rechteck in Frame einfügen
    pixelCount = numel(RGB) + pixelCount; %Pixelzähler um aktuelles Bild erhöhen
     
    frame = im2frame(RGB); 
    writeVideo(writerObj, frame); %Frame ins Video schreiben
end
close(writerObj); %Video writer schließen
implay('whitehouse.avi'); %Video abspielen
disp("Pixel in Video: "+pixelCount); %Pixelcount ausgeben
