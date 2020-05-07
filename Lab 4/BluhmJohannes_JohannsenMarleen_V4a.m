%Johannes Bluhm und Marleen Johannsen, 07.05.2020, Laboraufgabe 4, Version 1
%1. Image Enhancement: Rauschunterdrückung

clc; %Kommandofenster bereinigen
clear; %Variablen bereinigen
close all; %alles schlieï¿½en

img = imread('eight.tif'); %Bild einlesen und speichern

figure(1); %Ein neues Fenster ï¿½ffnen
imshow(img); %Anzeigen des eingelesenen Bildes
axis on; %Achsen sichtbar machen
title('Originalbild'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung

imNoise = imnoise(img, 'salt & pepper', 0.03); %rauschen einfügen

figure(2); %Ein neues Fenster ï¿½ffnen
imshow(imNoise); %Anzeigen des verrauschten Bildes
axis on; %Achsen sichtbar machen
title('Bild mit Rauschen'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung

ksize = 3; %Größe des Kernels
mkernel = 1/(ksize*ksize)*ones(ksize, ksize) %Mittelwertfilter per Hand füllen, auf Commandwindow

imFilt = imfilter(imNoise, mkernel); %mit MWF filtern

figure(3); %Ein neues Fenster ï¿½ffnen
imshow(imFilt); %Anzeigen des gefilterten Bildes
axis on; %Achsen sichtbar machen
title('Gefiltertes Bild'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung

k = fspecial('gaussian', [5 5], 1) %Ein Gaußfilter definieren, auf Commandwindow
imFiltG = imfilter(imFilt, k); %Bild filtern

figure(4); %Ein neues Fenster ï¿½ffnen
imshow(imFiltG); %Anzeigen des gefilterten Bildes
axis on; %Achsen sichtbar machen
title('Gefiltertes Bild mit Gauss'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung

h = fspecial('unsharp'); %Schärfungsfilter definieren
imFiltGS = imfilter(imFiltG, h); %Bild schärfen

figure(5); %Ein neues Fenster ï¿½ffnen
imshow(imFiltGS); %Anzeigen des geeschärften Bildes
axis on; %Achsen sichtbar machen
title('Geschärftes Bild'); %Titel des Fensters
xlabel('Pixel'); %Horizontale Achse Beschriftung
ylabel('Pixel'); %Vertikale Achse Beschriftung
