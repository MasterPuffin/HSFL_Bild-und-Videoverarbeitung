%
% funcGenPolyPic.m
%
% Tastet den Rand der einzigen im Image uebergebenen Region ab. 
% Gibt einen offenen Polygonzug zurueck.
%
%   tas 03.06.2013
%   usc 08.06.2017 - Erg?nzung der Erkl?rungen
%

function polygon = funcGenPolyPic(bwImage, N_Abtast)

boundaries = bwboundaries(bwImage);

% wir wissen, dass nur ein Objekt vorhanden ist, sonst s. DemoMustererkennung
b = boundaries{1};   % Achtung geschweifte Klammern; gibt die Koordinaten 
% eines jeden Bildpunktes des umgebenden Kurvenverlauf eines Objektes an,
% d. h. jeder Bidlpunkt wird durch ein Koodinatenpaar beschrieben
% figure;
% plot(b(:,2),-1*b(:,1),'g','LineWidth',1); % Plot vom umgebenden Rand des
% Objekts, der abgetastet werden soll

% Abtastintervall (L?nge) bestimmen
T = round(length(b)/N_Abtast)+1;  % round to the nearest integer

IndexVec = 1:T:length(b); %enth?lt die Indizes , die beschreiben, jeder 
% wievielte Wert aus der boundary-Zahlenkolonne genommen werden soll
% hier jetzt die Abtastung
polygon = b(IndexVec,1) + 1i*b(IndexVec,2); %Abtastwerte als komplexe Zahlen
% ploygon enth?lt die verwendeten Koordinatenpunkte des Randes des Objektes

% offenen Polygon erzeugen (Polygonzug muss offen sein, weil ...????)
% length(polygon) ist die Anzahl der Abtastwerte
% polygon(1) ist der erste Abtastwert als komplexe Zahl
if (polygon(length(polygon)) == polygon(1) ) % wenn der letzte Wert von 
    % ploygon dem ersten Wert von polygon entspricht, dann ist man sozu-
    % sagen 1x rum und das abgetastete Gebilde ist geschlossen. Das soll 
    % nicht sein. Deshalb wird aus der geschlossenen Abtastung eine offene
    % Abtastung gemacht.
   polygon = polygon(1:length(polygon)-1);
end

% figure; plot(real(polygon),imag(polygon),'b*-');