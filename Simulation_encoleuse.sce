// Ruby la p'tit Geek 06/11/2019
// Variable avec uniquement des lettres majuscules : Vecteur
// Boite de dialogue
txt = ['Déplacement e en mm';'vitesse Vx en mm/mn'; 'hauteur h en mm';'diamètre aiguille 2r'];
param = x_mdialog('Entrer les paramètres d''encollage',txt,['0.4';'200';'0.2';'0.58']);

ee = evstr(param(1)); //Deplacement de la seringue
Vx  = evstr(param(2)); //Vitesse de l'aiguille
hh = evstr(param(3)); //Hauteur de l'aiguille
rr  = evstr(param(4)); //Diamètre de l'aiguille
rrArray = [1.60, 1.19, 0.84, 0.58]
// Le symbole logique ou est |
if ~((rr==1.60)|(rr==1.19)|(rr==0.84)|(rr==0.58)) then disp('Erreur : Diamètre de l''aiguille non valide');return end;
// Paramètre e, Vx, X et h bloqués à des valeurs intermédiares)
if (ee<0.4) | (ee>0.8) then disp('Erreur : Déplacement seringue non valide'); return; end;  
if (Vx<200) | (Vx>600) then disp('Erreur : Vitesse non valide'); return; end; 
if (hh<0.2) | (hh>0.8) then disp('Erreur : hauteur aiguille non valide'); return; end;
xx = 70; //Deplacement de l'aiguille
Vxs=Vx/60; // La vitesse en mm/mn est convertie en mm/s
X1=[0.1:0.1:xx]; // Génération des abscisses sur un demi axe
X=[X1,X1+xx]; // Génération de l'axe des abscisses complet
Ve=ee*Vxs/xx; // Calcul de Ve comme dans la CR20
Qe=Ve*180; // Débit = vitesse de piston * surface piston
i = 1
Y = list()
for rLocal = rrArray
    Vxx=(Vx-400)/200; 
    eee=((ee/xx)-0.00857)/(0.00571); 
    hhh=(hh-0.5)/0.3; 
    ddd=(rLocal-1.09)/0.51;
    
    // Valeur de TauVx issu des essais du fournisseur pour prendre en compte le diamètre de l'aiguille; Constante de temps fin de cordon
    TauVx = 25.2196875-2.2940625*eee-0.0634375*hhh-0.0384375*Vxx-0.132898284313726*ddd+2.15624999999999E-02*eee*hhh+0.0778125*eee*Vxx-0.00278799019607845*eee*ddd-0.00781249999999997*hhh*Vxx-0.0407781862745098*hhh*ddd+4.46752450980392E-02*Vxx*ddd+9.3749999999998E-04*eee*hhh*Vxx-0.0258026960784314*eee*Vxx*ddd+3.44975490196081E-03*eee*hhh*ddd+1.71629901960784E-02*hhh*Vxx*ddd+4.38112745098038E-03*eee*hhh*Vxx*ddd;
    
    tau = TauVx/Vxs;
    QS1=Qe*(1-exp(-X1/(tau*Vxs))); // Débit forcé sur le premier demi axe
    S1=QS1/Vxs; // Surface de cordon pour Qs1
    
    QS2=QS1(xx*10)*[exp(-(X1/(tau*Vxs)))];
    // ./ : Division terme à terme des vecteurs x1 et tauv
    // Débit libre sur le deuxième demi axe
    S2=QS2/Vxs; // Surface de cordon pour Qs2 avec raccordement non anguleux
    
    // Valeur de a0 après les résultats de notre plan d'expérience
    a0 = 3.0534375+0.4509375*eee-0.0634375*hhh-0.0384375*Vxx-0.132898284313726*ddd+2.15624999999999E-02*eee*hhh+0.0778125*eee*Vxx-0.00278799019607845*eee*ddd-0.00781249999999997*hhh*Vxx-0.0407781862745098*hhh*ddd+4.46752450980392E-02*Vxx*ddd+9.3749999999998E-04*eee*hhh*Vxx-0.0258026960784314*eee*Vxx*ddd+3.44975490196081E-03*eee*hhh*ddd+1.71629901960784E-02*hhh*Vxx*ddd+4.38112745098038E-03*eee*hhh*Vxx*ddd;
    
    ainfini=a0/(sqrt(1-exp(-70/TauVx)));
    Ss=180; //Surface du piston seringue
    ba=4*Ss*ee/(3.1416*xx*ainfini^2) ; // rapport hauteur/largeur du cordon de colle
    A1=sqrt(S1*4/(%pi*ba))/2; // largeur de cordon premier demi-axe
    A2=sqrt(S2*4/(%pi*ba))/2; // largeur de cordon deuxième demi-axe pour s2
    Y(i)=[A1,A2]; // Valeurs des abscisses avec raccordement non anguleux
    ysup=5; // Echelle max des Y
    i = i +1
    
end
disp(Y)
clf; // Effacer le graphique précédent
plot(0,ysup,0,-ysup) // Echelle max des Y
colorArray = ['r', 'b', 'g', 'm']
colorArrayFull = ['red', 'blue', 'green', 'magenta']
for j = 1:4
    plot(X,Y(j),colorArray(j),X,-Y(j),colorArray(j));
end
p=gca();
p.background=color(240,255,240);
p.grid=[1 1];
p.thickness = 1;
format(6);
titre1 = 'Entrées : e= '+string(ee)+'mm,  '+'X= '+string(xx)+'mm,  '+'Vx= '+string(Vx)+'mm/mn,  '+'h= '+string(hh)+'mm,  ';

titre2 = 'Diamètres d''aiguille : 2r= 1.60, couleur : rouge';
titre3 = 'Diamètres d''aiguille : 2r=  1.19, couleur : bleu';
titre4 = 'Diamètres d''aiguille : 2r=  0.84, couleur : green';
titre5 = 'Diamètres d''aiguille : 2r=  0.58, couleur : magenta';

xtitle([titre1;titre2;titre3;titre4;titre5;]);
p.isoview="off";

