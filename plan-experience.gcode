G28
G1 Z10 F200
G1 X45 Y15 F2000
T0
M92 E4000 (Défini les pas de l’axe E à 4000pas/tour de vis)
G1 Z2.1 F200 (Redescente à Z=0 à 200 mm/mn)
G92 XO Y0 Z2.1 (La position actuelle est origine des axes X,Y et Z)
	(Cordon 0 | Purge = non exploitable)
G1 X0 Y0 F4000	(Déplacement à X=0mm et Y=0mm à 4000 mm/mn)
G1 Z2.1 F300(	Déplacement à Z=0mm à 300 mm/mn)
G1 X5 (Déplacement à X=5mm )
G92 E0 (La position actuelle de E est origine )
G1 E0.5 X70 F200 (Déplacement avec encollage à X=70 Vitesse 200mm/mn)
G1 X140	(Déplacement sans encollage à X=140)
G1 Z5 F300 (Montée à z=5 pour dégager la pièce Vitesse max 300 mm/mn)
	(Cordon 1 - e=0.4, h=0, Vx=200)
G1 X0 Y5 F4000 (Retour à X=0 et avance à Y=5 Vit rapide 4000mm/mn)
G1 Z2.1 (Descente à z=0 La vitesse de 4000mm/mn est conservée)
G4 P1000 (Attente de 1 s)
G1 X3 (Déplacement à X=3 pour essuyer la pointe de l’aiguille )
G1 X0 Y10 Z10 (Déplacement à X=0 et avance à Y=10 en position travail)
G1 Z2.1 F300	(Montée à Z=0 Vitesse 300mm/mn)
G92 E0	(Initialisation de l’axe E à 0 Pour mouv. relatif de l’axe E)
G1 E0.4 X70 F200 (Déplacement avec encollage à X=70 (Vitesse 200mm/mn)
G1 X140	(Déplacement sans encollage à X=140)
G1 Z10 F300 (Montée à z=5 pour dégager la pièce Vitesse max 300 mm/mn)
	(Cordon 2 - e=0.4, h=0, Vx=600)
G1 X0 Y15 F4000 (Retour à X=0 et avance à Y=5 Vit rapide 4000mm/mn)
G1 Z2.1 (Descente à z=0 La vitesse de 4000mm/mn est conservée)
G4 P1000 (Attente de 1 s)
G1 X3 (Déplacement à X=3 pour essuyer la pointe de l’aiguille )
G1 X0 Y20 Z10 (Déplacement à X=0 et avance à Y=10 en position travail)
G1 Z2.1 F300	(Montée à Z=0 Vitesse 300mm/mn)
G92 E0	(Initialisation de l’axe E à 0 Pour mouv. relatif de l’axe E)
G1 E0.4 X70 F600 (Déplacement avec encollage à X=70 (Vitesse 200mm/mn)
G1 X140	(Déplacement sans encollage à X=140)
G1 Z10 F300 (Montée à z=5 pour dégager la pièce Vitesse max 300 mm/mn)
	(Cordon 3 - e=0.4, h=0.6, Vx=200)
G1 X0 Y25 F4000 (Retour à X=0 et avance à Y=5 Vit rapide 4000mm/mn)
G1 Z2.1 (Descente à z=0 La vitesse de 4000mm/mn est conservée)
G4 P1000 (Attente de 1 s)
G1 X3 (Déplacement à X=3 pour essuyer la pointe de l’aiguille )
G1 X0 Y30 Z10 (Déplacement à X=0 et avance à Y=10 en position travail)
G1 Z2.7 F300	(Montée à Z=0 Vitesse 300mm/mn)
G92 E0	(Initialisation de l’axe E à 0 Pour mouv. relatif de l’axe E)
G1 E0.4 X70 F200 (Déplacement avec encollage à X=70 (Vitesse 200mm/mn)
G1 X140	(Déplacement sans encollage à X=140)
G1 Z10 F300 (Montée à z=5 pour dégager la pièce Vitesse max 300 mm/mn)
	(Cordon 4 - e=0.4, h=0.6, Vx=600)
G1 X0 Y35 F4000 (Retour à X=0 et avance à Y=5 Vit rapide 4000mm/mn)
G1 Z2.1 (Descente à z=0 La vitesse de 4000mm/mn est conservée)
G4 P1000 (Attente de 1 s)
G1 X3 (Déplacement à X=3 pour essuyer la pointe de l’aiguille )
G1 X0 Y40 Z10 (Déplacement à X=0 et avance à Y=10 en position travail)
G1 Z2.7 F300	(Montée à Z=0 Vitesse 300mm/mn)
G92 E0	(Initialisation de l’axe E à 0 Pour mouv. relatif de l’axe E)
G1 E0.4 X70 F600 (Déplacement avec encollage à X=70 (Vitesse 200mm/mn)
G1 X140	(Déplacement sans encollage à X=140)
G1 Z10 F300 (Montée à z=5 pour dégager la pièce Vitesse max 300 mm/mn)
	(Cordon 5 - e=0.8, h=0, Vx=200)
G1 X0 Y45 F4000 (Retour à X=0 et avance à Y=5 Vit rapide 4000mm/mn)
G1 Z2.1 (Descente à z=0 La vitesse de 4000mm/mn est conservée)
G4 P1000 (Attente de 1 s)
G1 X3 (Déplacement à X=3 pour essuyer la pointe de l’aiguille )
G1 X0 Y50 Z10 (Déplacement à X=0 et avance à Y=10 en position travail)
G1 Z2.1 F300	(Montée à Z=0 Vitesse 300mm/mn)
G92 E0	(Initialisation de l’axe E à 0 Pour mouv. relatif de l’axe E)
G1 E0.8 X70 F200 (Déplacement avec encollage à X=70 (Vitesse 200mm/mn)
G1 X140	(Déplacement sans encollage à X=140)
G1 Z10 F300 (Montée à z=5 pour dégager la pièce Vitesse max 300 mm/mn)
	(Cordon 6 - e=0.8, h=0, Vx=600)
G1 X0 Y55 F4000 (Retour à X=0 et avance à Y=5 Vit rapide 4000mm/mn)
G1 Z2.1 (Descente à z=0 La vitesse de 4000mm/mn est conservée)
G4 P1000 (Attente de 1 s)
G1 X3 (Déplacement à X=3 pour essuyer la pointe de l’aiguille )
G1 X0 Y60 Z10 (Déplacement à X=0 et avance à Y=10 en position travail)
G1 Z2.1 F300	(Montée à Z=0 Vitesse 300mm/mn)
G92 E0	(Initialisation de l’axe E à 0 Pour mouv. relatif de l’axe E)
G1 E0.8 X70 F600 (Déplacement avec encollage à X=70 (Vitesse 200mm/mn)
G1 X140	(Déplacement sans encollage à X=140)
G1 Z10 F300 (Montée à z=5 pour dégager la pièce Vitesse max 300 mm/mn)
	(Cordon 7 - e=0.8, h=0.6, Vx=200)
G1 X0 Y65 F4000 (Retour à X=0 et avance à Y=5 Vit rapide 4000mm/mn)
G1 Z2.1 (Descente à z=0 La vitesse de 4000mm/mn est conservée)
G4 P1000 (Attente de 1 s)
G1 X3 (Déplacement à X=3 pour essuyer la pointe de l’aiguille )
G1 X0 Y70 Z10 (Déplacement à X=0 et avance à Y=10 en position travail)
G1 Z2.7 F300	(Montée à Z=0 Vitesse 300mm/mn)
G92 E0	(Initialisation de l’axe E à 0 Pour mouv. relatif de l’axe E)
G1 E0.8 X70 F200 (Déplacement avec encollage à X=70 (Vitesse 200mm/mn)
G1 X140	(Déplacement sans encollage à X=140)
G1 Z10 F300 (Montée à z=5 pour dégager la pièce Vitesse max 300 mm/mn)
	(Cordon 8 - e=0.8, h=0.6, Vx=600)
G1 X0 Y75 F4000 (Retour à X=0 et avance à Y=5 Vit rapide 4000mm/mn)
G1 Z2.1 (Descente à z=0 La vitesse de 4000mm/mn est conservée)
G4 P1000 (Attente de 1 s)
G1 X3 (Déplacement à X=3 pour essuyer la pointe de l’aiguille )
G1 X0 Y80 Z10 (Déplacement à X=0 et avance à Y=10 en position travail)
G1 Z2.7 F300	(Montée à Z=0 Vitesse 300mm/mn)
G92 E0	(Initialisation de l’axe E à 0 Pour mouv. relatif de l’axe E)
G1 E0.8 X70 F600 (Déplacement avec encollage à X=70 (Vitesse 200mm/mn)
G1 X140	(Déplacement sans encollage à X=140)
G1 Z10 F300 (Montée à z=5 pour dégager la pièce Vitesse max 300 mm/mn)
