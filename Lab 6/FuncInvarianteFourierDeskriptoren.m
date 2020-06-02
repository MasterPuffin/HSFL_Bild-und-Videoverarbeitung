%
% FuncInvarianteFourierDeskriptoren.m
%
% berechnet invariante Fourierdeskriptoren von 
%   nicht?quidistanten Polygonz?gen(polygon)
%
% s = Symmetrie des Objekts (=1), q = 1
% res enth?lt den Absolutbetrag der invarianten Fourierdeskriptoren.
%
%   - polygon ist Spaltenvektor komplexer Werte.
%   - polygon ist offen, d.h. der Startpunkt wird am Ende nicht wiederholt
%   - es ist nicht notwendig, dass polygon das Objekt ?quidistant abtastet 
%
%   (n*2)+1 ist die Anzahl der zu berechnenden Koeffizienten(Deskriptoren). 
%
% Alle Formeln f?r die Berechnung der Fourierdeskriptoren wurden aus dem
% Buch "Transformationen zur lageinvarianten Merkmalgewinnung (CT und 
% Fourierdeskriptoren) S.30" von H. Burkhart entnommen. Die Formeln
% werden genauso wie in dem Buch Nummeriert.
%
% Dmitri Hammernik, 16.02.2011
% tas 14.12.2011        kleinere Anpassungen
%

function res = FuncInvarianteFourierDeskriptoren(q, s, polygon, n)


% (3.2.34) 
% Berechnung der Differenz zwischen den Punkten
% Differenzen sind komplex -> Richtung ist enthalten
xd = [polygon(2:length(polygon)); polygon(1)] - polygon(:);

% (3.2.35)
% Berechnung der normierten Differenz 
zd = xd./abs(xd);   % komplex, Norm = 1
% Differenz der normierten L?ngen, Richtungsdiff ?
zdd = zd - [ zd(length(zd)) ; zd(1:(length(zd)-1)) ]; 

% (3.2.37)
tk = cumsum(abs(xd));  % tk ist Vektor der kummulierten Summen

%Periode
T = tk(length(tk));
% (3.2.37) => t0 = 0
tk = [0; tk(1:length(tk)-1)];

N = [-n:-1, 1:n]';

% (3.2.36)
% Berechnung der Fourierdeskriptoren != 0
 B = exp(-1i.*(2*pi./T)*N*tk');

 Fc = B * zdd; 
 Fc = Fc .* (-(T./((2*pi).^2*N.^2))) ;

 % Berechnung des nullten Fourierdeskriptors
 c0 = ([polygon(2:length(polygon)); polygon(1)] + polygon(:))' * abs(xd);
 c0 = 1/(2*T) * c0;

%Der nullte FD wird in den Fc Vektor hinzugef?gt.
 Fk = [Fc(1:n); c0; Fc(n+1:n+n)]; 

 % bis hier Berechnung der FDs
 % -----------------------------------------------------
 % ab jetzt Bestimmung der invarianten FDs

% Entfernen des nullten Koeffizienten
l=length(Fk);
n = floor(l/2);
Fk(n+1) = 0;

% Indexvektor
N = [ -n:n ]';

% (3.2.8a) Betragsnormierung
Fd = abs(Fk) ./ abs(Fk(n));

% (3.2.8a) Phasennormierung
phi1 = atan(imag(Fk(1:n))./real(Fk(1:n)));
phi2 = atan(imag(Fk(n+2:l))./real(Fk(n+2:l)));
%PHIn
phi = [phi1; 0; phi2];

% PHIn + Alpha * PHIr
phi = phi + ((q - N)./s) .* atan( imag(Fk(n+1+q+s))./ real(Fk(n+1+q+s)) );
%((q - N)./s) => (3.2.8b) Gleichung so umgestellt das r nicht mehr vorkommt

%PHIn + Alpha * PHIr - Beta * PHIq
phi = phi - ((q + s - N)./s) .* atan( imag(Fk(n+1+q))./real(Fk(n+1+q)) );
%((q + s - N)./s) => (3.2.8b) Gleichung so umgestellt das r nicht mehr vorkommt

% invariante Fourierdeskriptoren
res = Fd .* exp( 1i.*phi);
res = abs(res);

end
