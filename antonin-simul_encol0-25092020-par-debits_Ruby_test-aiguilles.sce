// Ruby la p'tit Geek 06/11/2019
// Variable avec uniquement des lettres majuscules : Vecteur
// Boite de dialogue
txt = ['Déplacement e en mm  (Impossible à modifier dans la version de Ruby)';'Déplacement x en mm (20-200)(Impossible à modifier dans la version de Ruby)';'vitesse Vx en mm/mn (Impossible à modifier dans la version de Ruby)'; 'hauteur h en mm (Impossible à modifier dans la version de Ruby)';'diamètre aiguille 2r (Là tu peux modifier :) signé Ruby)'];
param = x_mdialog('Entrer les paramètres d''encollage',txt,['0.5';'70';'500';'0.5';'0.58']);

ee = evstr(param(1)); // déplacement e en mm
xx = evstr(param(2)); // déplacement x en mm
Vx  = evstr(param(3)); // vitesse Vx en mm/min
hh = evstr(param(4)); // hauteur h en mm
rr  = evstr(param(5)); // diamètre aiguille 2r
// Le symbole logique ou est |
if ~((rr==1.60)|(rr==1.19)|(rr==0.84)|(rr==0.58)) then disp('Erreur : Diamètre de l''aiguille non valide');return end;
// Paramètre e, Vx, X et h bloqués à des valeurs intermédiares; changer les bornes pour entrer d'autres valeurs)
//if (ee<0.5) | (ee>0.5) then disp('Erreur : Déplacement seringue non valide'); return; end;   //  Déverrouiller les valeurs après le PE
//if (xx<70) | (xx>70) then disp('Erreur : Déplacement non valide'); return; end; //  Déverrouiller les valeurs après le PE
//if (Vx<500) | (Vx>500) then disp('Erreur : Vitesse non valide'); return; end; //  Déverrouiller les valeurs après le PE
//if (hh<0.5) | (hh>0.5) then disp('Erreur : hauteur aiguille non valide'); return; end; //  Déverrouiller les valeurs après le PE
Vxs=Vx/60; // La vitesse en mm/mn est convertie en mm/s
X1=[0.1:0.1:xx]; // Génération des abscisses sur un demi axe , array1x700 from 0.1 to 70 step 0.1
X=[X1,X1+xx]; // Génération de l'axe des abscisses complet, same but to 1400
Ve=ee*Vxs/xx; // Calcul de Ve comme dans la CR20 (déplacement e en mm * vitesse en mm/s / déplacement x en mm)
Qe=Ve*180; // Débit = vitesse de piston * surface piston

// Valeurs issues du PE régime libre lettres triplées -Variables centrées réduites - PE réalisé pour X=70 - Généralisé pour toutes valeurs de X avec l'entrée e/X
// Cadeau de Ruby
Vxx=(Vx-400)/200; eee=((ee/xx)-0.00857)/(0.00571); hhh=(hh-0.5)/0.3; ddd=(rr-1.09)/0.51;

// Valeur de TauVx issu des essais du fournisseur et du bidouillage de Ruby pour prendre en compte le diamètre de l'aiguille; Constante de temps fin de cordon
TauVx = 25.2196875-2.2940625*eee-0.0634375*hhh-0.0384375*Vxx-0.132898284313726*ddd+2.15624999999999E-02*eee*hhh+0.0778125*eee*Vxx-0.00278799019607845*eee*ddd-0.00781249999999997*hhh*Vxx-0.0407781862745098*hhh*ddd+4.46752450980392E-02*Vxx*ddd+9.3749999999998E-04*eee*hhh*Vxx-0.0258026960784314*eee*Vxx*ddd+3.44975490196081E-03*eee*hhh*ddd+1.71629901960784E-02*hhh*Vxx*ddd+4.38112745098038E-03*eee*hhh*Vxx*ddd;
// 30.735 - 6.215*ddd ; //(A remplacer par la fonction objective issu du PE physique)

tau = TauVx/Vxs; // tauVx / vitesse en mm/s
QS1=Qe*(1-exp(-X1/(tau*Vxs))); // Débit forcé sur le premier demi axe
S1=QS1/Vxs; // Surface de cordon pour Qs1

QS2=QS1(xx*10)*[exp(-(X1/(tau*Vxs)))];
// ./ : Division terme à terme des vecteurs x1 et tauv
// Débit libre sur le deuxième demi axe
S2=QS2/Vxs; // Surface de cordon pour Qs2 avec raccordement non anguleux

// Valeur de a0 du régime libre issu des essais du fournisseur et du bidouillage de Ruby pour prendre en compte le diamètre de l'aiguille; largueur du cordon
//a0 = 2.03125-0.30625*eee - 2.77555756156289E-17*hhh - 2.77555756156289E-17*Vxx - 0.0897058823529417*ddd + 0.1125*eee*hhh + 0.0375*eee*Vxx - 0.0383578431372548*eee*ddd - 0.05625*hhh*Vxx - 0.0158088235294118*hhh*ddd + 6.49509803921568E-02*Vxx*ddd + 0.05625*eee*hhh*Vxx - 0.0253676470588235*eee*Vxx*ddd - 0.0169117647058824*eee*hhh*ddd + 3.17401960784314E-02*hhh*Vxx*ddd - 0.0223039215686275*eee*hhh*Vxx*ddd
a0 = 3.0534375+0.4509375*eee-0.0634375*hhh-0.0384375*Vxx-0.132898284313726*ddd+2.15624999999999E-02*eee*hhh+0.0778125*eee*Vxx-0.00278799019607845*eee*ddd-0.00781249999999997*hhh*Vxx-0.0407781862745098*hhh*ddd+4.46752450980392E-02*Vxx*ddd+9.3749999999998E-04*eee*hhh*Vxx-0.0258026960784314*eee*Vxx*ddd+3.44975490196081E-03*eee*hhh*ddd+1.71629901960784E-02*hhh*Vxx*ddd+4.38112745098038E-03*eee*hhh*Vxx*ddd;

// 2.91751 + 0.2025*ddd; //(A remplacer par la fonction objective issu du PE physique)

ainfini=a0/(sqrt(1-exp(-70/TauVx)));
Ss=180; //Surface du piston seringue
ba=4*Ss*ee/(3.1416*xx*ainfini^2) ; // rapport hauteur/largeur du cordon de colle
A1=sqrt(S1*4/(%pi*ba))/2; // largeur de cordon premier demi-axe
A2=sqrt(S2*4/(%pi*ba))/2; // largeur de cordon deuxième demi-axe pour s2
Y=[A1,A2]; // Valeurs des abscisses avec raccordement non anguleux
ysup=5; // Echelle max des Y
clf; // Effacer le graphique précédent
plot(0,ysup,0,-ysup) // Echelle max des Y
plot(X,Y,X,-Y,); // Affichage du cordon retouché sans point anguleux avec symétrie
p=gca();
p.background=color(240,255,240);
p.grid=[1 1];
p.thickness = 1;
format(6);
titre1 = 'Entrées : e= '+string(ee)+'mm,  '+'X= '+string(xx)+'mm,  '+'Vx= '+string(Vx)+'mm/mn,  '+'h= '+string(hh)+'mm,  '+'2r= '+string(rr)+'mm, ';
titre2 = 'Relevés courbe  a('+string(xx)+')= '+string(A1(xx*10)*2)+'mm,  '+'tau*Vx= '+string(TauVx)+'mm ,';
titre3 = 'Calculés : s max= '+string(S1(xx*10))+' mm²,  '+'s infini= '+string(Ve*Ss/Vx)+'mm²,  '+'a infini = '+string(sqrt(ee*Ss*4/(%pi*ba*xx)))+'mm,  '+'tau= '+string(tau)+'s, ';
xtitle([titre1;titre2;titre3]);
p.isoview="off";

