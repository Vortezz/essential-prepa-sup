#set heading(numbering: "I.1.a")

#let project(title: "", authors: (), date: none, body) = {
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: "Essentiel de physique")
  set page(numbering: "1", number-align: center)
  set text(font: "Cantarell", lang: "en")

  // Title row.
  align(center)[
    #block(text(weight: 700, 1.75em, "Essentiel de physique"))
    #v(1em, weak: true)
    #date
  ]

  // Author information.
  pad(
    top: 0.5em,
    bottom: 0.5em,
    x: 2em,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(center)[
        *#author.name* \
        #author.phone
      ]),
    ),
  )

  // Main body.
  set par(justify: true)

  body
}

#let theorem(name, t) = box(
    radius: 4pt, 
    fill: red,
    width: 100%,
    align(
        right, 
        block(
          radius: 4pt, 
          fill: rgb("#ffe7e6"),
          width: 100%-3pt, 
          inset: 1em,
          stroke: stroke(cap: "round", thickness: 0.5pt, paint: red),
          align(left, [#text(name + " :", weight: "bold") \ #t])
        ),
      ),
    );

#let demo(t) = box(
  stroke: (
    left: 5pt + gray,
  ),
  box(
    inset: (
      left: 1em,
      top: 4pt,
      bottom: 4pt,
    ),
    align(left, [#text("Preuve :", weight: "bold", gray) \ #text(t, gray)])
  ),
)

#let derivativePart(a, b, c) = $(cal(d) #a)/(cal(d) #b) | #c$
#let derivative(a, b) = $(d #a)/(d #b)$
#let dt = $d t$
#let ddt(a) = $derivative(#a, t)$

#show: project.with(
  title: "Thermodynamique",
  authors: (
    (name: "Victor Sarrazin", phone: ""),
  ),
  date: "2023/2024",
)

#outline(depth:1,indent: 10pt, title: "Optique :", target: heading.where(supplement: [optical]))

#outline(depth:1,indent: 10pt, title: "Électricité :", target: heading.where(supplement: [elec]))

// Faire des circuits : https://www.circuit-diagram.org/editorb/

#outline(depth:1,indent: 10pt, title: "Ondes :", target: heading.where(supplement: [waves]))

#outline(depth:1,indent: 10pt, title: "Mécanique :", target: heading.where(supplement: [meca]))

#outline(depth:1,indent: 10pt, title: "Thermodynamique :", target: heading.where(supplement: [thermo]))

#outline(depth:1,indent: 10pt, title: "Annexe :", target: heading.where(supplement: [annex]))

#let pext = $P_"ext"$

#counter(heading).update(0)
#set heading(numbering: "🔭 I.1.a")

#heading([Introduction à l'optique], supplement: [optical])

A faire

#heading([Lentilles minces et miroir plan], supplement: [optical])

A faire

#heading([L'oeil], supplement: [optical])

A faire

#counter(heading).update(0)
#set heading(numbering: "⚡ I.1.a")

#heading([Introduction à l'électricité], supplement: [elec])

== Généralités

=== Charge électrique

La *charge* est une propriété intrinsigue d'une particule et s'exprime en Coulomb ($c$) et est de dimension $I.T$, est algébrique, additive et conservative (un système fermé est de charge fixe).

La charge est portée par les électrons ($-e$) et les protons ($e$) avec $e = 1.6 times 10^(-19) c$ la *charge élémentaire* (souvent notée $q$).

=== Courant électrique

Le *courant électrique* est un déplacement d'ensemble de charges

=== Dipôle, branche, maille, circuit

Un *dipôle* possède 2 pôles, lui permettant d'être traversé par un courant électrique. Une association de dipôles forme un *circuit*.

Un association de dipôles à la suite est appelée *association série* et forme une *branche*.

Un association de dipôles bouclant sur elle même est appelée *maille*.

=== Intensité électrique

L'*intensité électrique* est un débit de charge noté $I$, avec $I = (delta Q)/dt$ avec $delta Q$ la charge traversant la section pendant $dt$.

Pour mesurer une intensité on utilise un _ampèremètre_ avec le $+$ sur le $m A$ ou $mu A$ et le $-$ sur le COM (en série).

#theorem([Loi des noeuds],[
  Dans une maille on a : $ sum_"entrants" I = sum_"sortants" I $
])

== La tension électrique

La *tension électrique* $U$ est une différence de potentiels en Volts ($V$) et est additive.

#theorem([Expression de $U_"AB"$],[
  On a $U_"AB" = V_A - V_B$ avec $V_A$ et $V_B$ deux potentiels.
])

#theorem([Loi des mailles],[
  Dans une maille, on a : $ sum_"tension maille" epsilon_i U_i $
  avec $epsilon_i = +1$ si $U_i$ est dans le sens du parcours et $epsilon_i = -1$ sinon.
])

La loi des mailles et la loi des noeuds s'appellent les *lois de Kirchhoff*. Elles sont variables en régime continu et en régime lentement variable.

Pour mesurer une tension on utilise un _voltmètre_ avec le $+$ sur la borne $Omega$ et le $-$ sur la borne COM (en dérivation).

== Approximation des régimes quasi stationnaires (ARQS)

#theorem([Critère d'ARQS],[
  Si $tau >> d/c$ avec $tau$ le temps caractéristique, $d$ la taille du circuit et $c$ la longueur du vide alors on est dans l'approximation.
])

Si ce critère est vérifié, tous les points du circuit "voient" le changement en direct. Ce critère est tout le temps vérifié en série.

== Résistors

Un *résistor* est une dipôle qui conduit $+$ ou $-$ bien l'électricité.

#figure(image("elec/resistance.png", width: 20%))

Une résistance est schématisée ainsi en convention récepteur

#theorem([Loi d'Ohm],[
  On a $U = R I$ avec $R$ la résistance en Ohm ($Omega$) en convention récepteur.

  Attention, en convention générateur, on a $U = - R I$
])

On dit qu'un résistor est un dipôle passif (en l'absence de $I$, pas de $U$) et linéaire ($U = f(I)$).

On a $R = l/(sigma S)$ avec $l$ la longueur, $sigma$ la conductivité électrique et $S$ la section.

On considère qu'un fil a une résistance négligeable.

#theorem([Tension d'un fil],[
  La tension au bornes d'un fil est nulle.
])

Le voltmètre ($approx 10 M Omega$) est modélisée par un interrupteur ouvert, et l'ampèremètre ($approx 0.1 Omega$) modélisée par un fil.

#theorem([Puissance dissipée par un résistor],[
  On a $P = R I^2$
])

#demo([
  On a $P_"reçue" = U I = U_R I _R = R I_R I_R = R I_R ^2$
])

On a la *masse*, un point d'un circuit de potentiel nul, $V = 0V$ c'est l'origine des potentiels.

En théorie elle est choisie arbitrairement, mais en pratique elle est imposée par certails appareils reliés à la Terre.

== Associations des résistors

#figure(image("elec/serial_res.png", width: 30%))

#theorem([Association série de résistors],[
  Soit $R_1$ et $R_2$ deux résistances en série, on a $R_e = R_1 + R_2$ la résistance équivalente
])

#demo([
  On a $U_1 = R_1 I$ et $U_2 = R_2 I$ ainsi $U = U_1 + U_2 = R_1 I + R_2 I = (R_1 + R_2) I$ ainsi $R_e = R_1 + R_2$
])

#figure(image("elec/parallel_res.png", width: 25%))

#theorem([Association parallèle de résistors],[
  Soit $R_1$ et $R_2$ deux résistances en parallèle, on a $1/R_e = 1/R_1 + 1/R_2$ la résistance équivalente
])

#demo([
  Par loi des mailles, $U = U_1 = U_2$, ainsi $U = R_1 I_1 = R_2 I_2$, d'après la loi des noeuds, $I = I_1 + I_2 = U/R_1 + U/R_2 = U(1/R_1 + 1/R_2)$ ainsi $U = 1/(1/R_1 + 1/R_2) I$
])

== Ponts diviseurs

#figure(image("elec/serial_res.png", width: 30%))

#theorem([Pont diviseur tension],[Soit $R_1$ et $R_2$ deux résistances en séries, $U = R_1/(R_1 + R_2) I$])

#demo([
  On a $U_1 = R_1 I$ et $U = (R_1 + R_2) I$ d'où $U_1/U = (R_1 I)/((R_1+R_2) I)$
])

#figure(image("elec/parallel_res.png", width: 25%))

#theorem([Pont diviseur courant],[Soit $R_1$ et $R_2$ deux résistances en parallèle, $I_1 = R_2/(R_1 + R_2) I$])

#demo([
  A faire :O
])

== Générateurs

=== Générateur de tension

#figure(image("elec/tension.png", width: 10%))

Un *générateur de tension* est un dipole qui impose une tension entre ses bornes. La tension imposée par un générateur est aussi appelée sa *force électromagnétique* (f.e.m)

$U$ est donc indépendante, c'est une dipôle actif.

#figure(image("elec/thevenin.png", width: 20%))

// TODO : REDO THE PICTURE

Un générateur réel est un générateur de Thévenin, on a :

#theorem([Générateur de Thévenin],[
  On a $U = U_r + E = E - R_i I$ et $P_"fournie" = U I = (E - R_i I) I = E I - R_i I^2$, avec $R_i$ la résistance interne et $E$ la f.e.m
])

=== Générateurs de courant (HP)

#figure(image("elec/courant.png", width: 10%))

Il existe des *générateurs de courant* qui fixent une intensité dans le circuit.

#heading([Circuits d'ordre 1], supplement: [elec])

== Le condensateur

=== Généralités

Le *condensateur* est un dipôle linéaire composé de deux armatures séparées par un milieu isolant (_diélectrique_).

#figure(image("elec/condensator.jpg", width: 10%))

On a $Q$ la charge algébrique par l'armature de gauche et $-Q$ par celle de droite : le condensateur est globalement neutre.

On a $Q = C U$ avec $C$ la *capacité du condensateur* en Farad ($F$)

#theorem([Intensité aux bornes d'un condensateur],[
  En convention récepteur, $I = C ddt(U)$
])

#demo([
  On a $ddt(Q) = (delta Q)/dt = I$ et $Q = C U$ donc $I = ddt(Q) = ddt(C U) = c ddt(U)$
])

#theorem([Énergie stockée dans un condensateur],[
  En convention récepteur, on a $E = 1/2 C U^2$
])

#demo([
  On a $P_"reçue" = U I = U times c ddt(U) = ddt(1/2 C U^2)$ or $P_"reçue" = ddt(E)$ d'où $E = 1/2 C U^2$
])

#theorem([Continuité de $U$ au bornes d'un condensateur],[
  Aux bornes d'un condensateur $U$ est continue
])

#demo([
  On suppose $U$ discontinue donc $E$ aussi, ainsi $P = ddt(E)$ diverge donc $P_"reçue"$ infinie n'est pas possible
])

#theorem([Comportement en régime permanant],[
  En régime permanent un condensateur est équivalent à un interrupteur ouvert ($I = 0A$)
])

=== Associations

#figure(image("elec/serial_capa.png", width: 30%))

#theorem([Association série de condensateurs],[
  Soit $C_1$ et $C_2$ deux condensateurs en parallèle, on a $1/C_e = 1/C_1 + 1/C_2$ le condensateur équivalent
])

#demo([
  On a $U = U_1 + U_2$ avec $i = i_1 = i_2$ d'où $i = C_1 ddt(U_1)= C_2 ddt(U_2)$.

  Ainsi on a $ddt(U) = ddt(U_1) + ddt(U_2)$ soit $i/C_e = i/C_1 + i/C_2$ d'où la relation cherchée.
])

#figure(image("elec/parallel_capa.png", width: 25%))

#theorem([Association parallèle de condensateurs],[
  Soit $C_1$ et $C_2$ deux condensateurs en série, on a $C_e = C_1 + C_2$ le condensateur équivalent
])

#demo([
  Loi des noeuds on a $i = i_1 + i_2$ d'où on a $i_1 = C_1 ddt(U)$ et $i_2 = C_2 ddt(U)$ d'où $i = (C_1 + C_2) ddt(U)$
])

== Charge d'un condensateur

On peut étudier la charge d'un condensateur (ou sa décharge) avec une équation d'ordre 1 dans un circuit RC

#theorem([Équation différentielle RC],[
  On a $ ddt(U) + 1/(R C) U = A $ avec $tau = R C$ le temps caractéristique
])

== La bobine

=== Généralités

La *bobine* est un dipôle linéaire composé d'un enroulement de fils sur lui même

#figure(image("elec/inductor.png", width: 20%))

On associe à une bobine une *inductance* $L$ en Henry ($H$), dépendant du nombre de fils et la quantités de spires (tours)

#theorem([Intensité aux bornes d'une bobine],[
  En convention récepteur, $U = L ddt(i)$
])

#theorem([Énergie stockée dans une bobine],[
  En convention récepteur, on a $E = 1/2 L i^2$
])

#demo([
  On a $P_"reçue" = U I = L ddt(i) times i = ddt(1/2 L i^2)$ or $P_"reçue" = ddt(E)$ d'où $E = 1/2 L i^2$
])

#theorem([Continuité de $i$ au bornes d'une bobine],[
  Aux bornes d'une bobine $i$ est continue
])

#demo([
  On suppose $i$ discontinue donc $E$ aussi, ainsi $P = ddt(E)$ diverge donc $P_"reçue"$ infinie n'est pas possible
])

#theorem([Comportement en régime permanant],[
  En régime permanent un condensateur est équivalent à un fil ($U = 0A$)
])

=== Associations

#figure(image("elec/serial_indu.png", width: 30%))

#theorem([Association série de bobines],[
  Soit $L_1$ et $L_2$ deux bobines en série, on a $L_e = L_1 + L_2$ la bobine équivalente
])

#demo([
  On a $U = U_1 + U_2 = L_1 ddt(i) + L_2 ddt(i) = (L_1 + L_2) ddt(i)$
])

#figure(image("elec/parallel_indu.png", width: 25%))

#theorem([Association parallèle de bobines],[
  Soit $L_1$ et $L_2$ deux bobines en parallèle, on a $1/L_e = 1/L_1 + 1/L_2$ la résistance équivalente
])

#demo([
  Par loi des mailles, $U = U_1 = U_2$, ainsi $U = L_1 ddt(i_1) = L_2 ddt(i_2)$.
  
  D'après la loi des noeuds, $i = i_1 + i_2$ d'où $ddt(i) = ddt(i_1) + ddt(i_2)$ soit $U/L = U/L_1 + U/L_2$ d'où la relation recherchée
])

#heading([Circuits d'ordre 2, Oscillateurs], supplement: [elec])

== Oscillateur harmonique

== Oscillateur amorti

=== Généralités

=== Régime apériodique

=== Régime critique

=== Régime pseudo-périodique

#heading([Circuits en régime sinusoidal forcé], supplement: [elec])

A faire

#heading([Filtrage], supplement: [elec])

A faire

#counter(heading).update(0)

#set heading(numbering: "🎶 I.1.a")

#heading([Introduction aux ondes], supplement: [waves])

A faire

#heading([Diffraction/Interférences], supplement: [waves])

A faire

#heading([La lumière onde], supplement: [waves])

#counter(heading).update(0)

#set heading(numbering: "🔧 I.1.a")

#heading([Cinématique du point], supplement: [meca])

A faire

#heading([Dynamique du point], supplement: [meca])

A faire

#heading([Énergétique du point], supplement: [meca])

A faire

#heading([Introduction à la dynamique des particules chargées], supplement: [meca])

A faire

#heading([Loi du moment cinématique], supplement: [meca])

A faire

#heading([Mouvement dans un champ de force newtonien], supplement: [meca])

A faire

#heading([Mécanique du solide], supplement: [meca])

#counter(heading).update(0)

#set heading(numbering: "💧 I.1.a")

#heading([Introduction à la thermodynamique], supplement: [thermo])

== Généralités

On a $cal(N)_A = 6.02 times 10^(23) m o l^(-1)$ la constante d'Avogadro

Les 3 états de la matière :

- *Solide* : Particules assez ordonnées, proches et peu mobiles (incompressible et indéformable)
- *Liquide* : Particules très désordonnées, proches et très mobiles (incompressible et déformable)
- *Gaz* : Particules très désordonnées, éloignées et très mobiles (compressible et déformable)

On parle d'un *fluide* pour un gaz ou un liquide et d'une *phase condensée* pour un liquide ou un solide.

== Variables d'état

Une *variable d'état* est une grandeur permettant de décrire l'équilibre thermodynamique d'un système.

Une grandeur est dite *extensive* si elle dépend de la taille du système (volume par ex) et *intensive* si ce n'est pas le cas (pression par ex), à noter que le produit de 2 grandeurs extensives donne une grandeur intensive.

=== Pression

La *pression* est une variable d'état en Pascal (Pa) avec $1 b a r = 10^5 P a$, est intensive et est causée par des chocs particulaires sur la paroi

#theorem([Force de pression], [
  On a $arrow(F) = P S arrow(u)$ avec $arrow(u)$ orienté vers l'extérieur de fluide dans le cas d'une paroi plane
])

Si on a une paroi non plane on a $arrow(F) = integral P d S arrow(u)$ avec $arrow(F) = P S arrow(u)$ si la pression est uniforme

=== Température

La température s'exprime en Kelvin (k), avec $T > 0 k$ et $0 °C = 273.15k$, est intensive et provient d'une agitation moléculaire.

On a $E_c = 3/2 k_B T$ l'énergie thermique moléculaire avec $k_B = R/cal(N)_A$ la constante de Boltzmann.

== Équilibre thermodynamique

On atteint un état d'équilibre thermodynamique quand les propriétés macroscopiques du système n'évoluent plus, ainsi on a :
- Équilibre mécanique avec l'extérieur
- Équilibre thermique
- Équilibre radiatif
- Équilibre chimique

A l'équilibre thermodynamique un système voit ses variables d'état liées par une relation d'état

== Modèle des gaz parfaits

#theorem([Gaz parfait], [On parle d'un gaz parfait pour un gaz composé de particules ponctuelles sans intéraction entre elles.])

#theorem([Équation des gaz parfaits], [On a à l'équilibre thermodynamique : $P V = n R T$ avec $R = 8.31 J.k^(-1).m o l^(-1)$ la constante des gaz parfaits.])

#heading([Premier principe], supplement: [thermo])

== Énergie interne, capacité thermique à volume constant

On note $U$ l'*énergie interne* d'un système thermique, c'est une fonction d'état additive et extensive s'exprimant en Joule.

#theorem([1ère loi de Joule], [Dans le cas d'un gaz parfait, $U$ = $A times T$ avec $A$ une constante])

A noter qu'il y a énormément d'énergie stockée de manière interne.

On défini la *capacité thermique* à volume fixé par $C_v = derivativePart(U,T,V)$ et dans le cas d'un GP on a $C_v = derivative(U,T)$, et est additive, extensif et s'exprime en $J.k^(-1)$

#theorem([Expression de $Delta U$], [On a $Delta U = integral_(T_i)^T_f C_v d T = C_v Delta T$])

== Premier principe

#theorem([Premier principe], [Dans un système fermé évoluant entre des états d'équilibre on a $Delta (E_m_("macro") + U) = W + Q$ d'où dans la plupart des cas : \ $ Delta U = W + Q $])

Dans le cas infinitésimal on a $d U = delta W + delta Q$

Avec $W$ le travail reçu par le système ($W > 0$ si récepteur et moteur sinon) et $Q$ le transfert thermique ($Q > 0$ reçoit et fournit sinon).

Il faut bien penser à définir le système pour utiliser le premier principe

== Types de transformations

- *Adiabatique* : Sans transfert thermique ($Q = 0$)
- *Monobare* : Au contact d'un système qui fixe la pression
- *Monotherme* : Au contact d'un système de température fixée (un thermostat)
- *Quasi statiques* : État d'équilibre au cours de toute la transformation
- *Système Calorifugé* : Limite les échanges de chaleur
- *Isochore* : $V$ constant
- *Isotherme* : $T$ constant
- *Isobare* : $P$ constant

On a 3 types de transfert thermiques :

- *Convection*
- *Conduction*
- *Rayonnement*

== Travail des forces de pression

#theorem([Travail des forces de pression], [On a $delta W = - pext d V$ donc $W = integral - pext d V$])

#demo([
  On a $arrow(F_p) = - pext S arrow(e_x)$ d'où on a $delta W = arrow(F_p) dot d x arrow(e_x) = - pext S d x = - pext d V$
])

=== Cas isochore

On a $d V = 0$ d'où $W = 0$

=== Cas isotherme

On a $Delta U = 0$ d'où $W = -Q$

=== Mécanique réversible

On a $pext = P$ car on a toujours un état d'équilibre, d'où :

- Isobare : On a $W = -P Delta V$
- Isotherme : On a $W = -n R T ln(V_f/V_i)$

#demo([
  En effet $W = integral - pext d V = integral - P d V = integral - n R T (d V)/V = -n R T ln(V_f/V_i)$
])

== Diagramme de Watt

On peut représenter l'évolution sur un graphe $(V, P)$, ainsi le travail correspond à l'aire sous le chemin parcouru.

Si un cycle est parcouru dans le sens trigonométrique, on a un récepteur et si il est parcouru dans le sens horaire on a un moteur

== Enthalpie

On a l'*enthalpie* une fonction d'état additive et extensive telle que $H = U + P V$

#theorem([2e loi de Joule], [Dans le cas d'un gaz parfait, $H$ = $A times T$ avec $A$ une constante])

Ainsi on a le second principe :

#theorem([Premier principe monobare], [Dans un système fermé évoluant entre des états d'équilibre avec une transformation monobare on a $Delta (E_m_("macro") + H) = W_u + Q$ d'où dans la plupart des cas : \ $ Delta H = W_u + Q $])

#demo([On a $Delta (E_m_("macro") + U) = W_u + W_"pression" + Q$ or $W_"pression" = - Delta (P V) = 0$, ainsi on a la propriété recherchée])

Avec $W_u$ la puissance utile des autres forces (souvent nulles d'où $Delta H = Q$ dans certains cas)

On définit la capacité thermique à pression fixée par $C_p = derivativePart(H, T, P)$ et $C_p = derivative(H, T)$ dans le cas d'un GP.

#theorem([Expression de $Delta H$], [On a $Delta H = integral_(T_i)^T_f C_p d T = C_p Delta T$])

Dans le cas des phases condensées on a $P V << U$ d'où $U = H$ ainsi $C_p = C_v = C$

#theorem([Relation de Mayer], [Dans le cas d'un gaz parfait on a $C_p = C_v + n R$])

#demo([
  On a $Delta U + Delta (P V) = C_v Delta T + n R Delta T$ d'où $C_p Delta T= C_v Delta T + n R Delta T$ ce qui conclut
])

On pose $gamma = C_p/C_v$

#theorem([Expression de $C_v$ et $C_p$], [Dans le cas d'un gaz parfait on a $C_v = (n R)/(gamma - 1)$ et $C_p = (gamma n R)/(gamma - 1)$])

#demo([
  On a $C_p = gamma C_v = C_v + n R$ d'où $C_v (gamma - 1) = n R$ ainsi $C_v = (n R)/(gamma - 1)$ et $C_p = (n R)/(gamma - 1)$
])

#heading([Second principe], supplement: [thermo])

== Entropie et second principe

On considère un système fermé avec un ou plusieurs thermostats, ainsi il existe une fonction d'état appelée *entropie* notée $S$, additive et extensive en $J.k^(-1)$ qui est une mesure du désordre.

#theorem([Second principe], [Dans un tel système, on a $Delta S = S_"créée" + S_"échangée"$ avec $S_c >= 0$])

Dans le cas infinitésimal on a donc $d S = delta S_c + delta S_e$ et à l'équilibre on a $delta S_c = delta S_e = 0$

#theorem([Expression de $S_e$], [On a $S_e = sum_"thermostats" Q_i/T_i$])

L'entropie d'un système isolé augmente nécessairement au cours d'une transformation thermodynamique

#demo([
  Isolé implique $delta Q_i = 0$ d'où $S_e = 0$ ainsi $Delta S = S_c >= 0$
])

Une transformation adiabatique réversible ne modifie pas l'entropie

#demo([
  On a $Delta S = cancel(sum_"thermostats" Q_i/T_i) + cancel(S_c)$ car $Q_i$ = 0 (adiabatique) et $S_c = 0$ pour ne pas contredire le caractère réversible
])

== Irréversibilité d'une transformation thermodynamique

Une transformation est dite *irréversible* si elle n'a lieu que dans un sens.

Une transformation est *réversible* si on peut en inverser le sens par changement infinitésimal des contraintes extérieures. Ces transformations extérieures sont lentes (quasi statiques) et $S_c = 0$

On a irréversibilité si :
  - Inhomogéneité de température
  - Gradient de pression
  - Réaction chimique
  - Frottement

== Identité thermodynamique (HP)

#theorem([Identité thermodynamique (HP)], [Dans un système fermé avec uniquement des forces de pression on a $d U = T d S - P d V$])

#demo([
  On a $d U = delta Q + delta W = delta Q - pext d V =_("(rév)") delta Q - P d V$ et $d S = cancel(delta S_c)_"(rév)" + delta S_e = (delta Q)/T_"th"$ avec $T_"th" = T$ car réversible.
  D'où $delta Q = T d S$ ainsi $d U = T d S - P d V$
])

== Entropie des gaz parfaits, lois de Laplace

#theorem([Variation d'entropie], [
  On a :
  $ Delta S = (n R)/(gamma - 1) ln(T/T_0) + n R ln (V/V_0) $
  $ Delta S = (n R)/(gamma - 1) ln(P/P_0) + (gamma n R)/(gamma - 1) ln (V/V_0) $
  $ Delta S = (gamma n R)/(gamma - 1) ln(T/T_0) - n R ln (P/P_0) $
])

#theorem([Lois de Laplace], [
  Dans le cas d'une transformation adiabatique réversible d'un gaz parfait on a :
  - $P V^gamma = $ cst
  - $T V^(gamma-1) = $ cst
  - $T^gamma P^(1-gamma) = $ cst
])

#demo([
  On retient la première et on retrouve avec $P V = n R T$
])

Ainsi sur un diagramme de Watt, le courbe est plus marquée pour une transformation adiabatique

== Entropie des phases condensées

#theorem([Entropie des phases condensées], [
  On a $S(T) = S(T_0) + C ln (T/T_0)$ d'où $Delta S = C ln (T/T_0)$
])

#heading([Flux thermiques], supplement: [thermo])

== Flux thermique, puissance

#theorem([Flux thermique], [Un flux est un échange de chaleur par unité de temps algébrique, on a $Phi = (delta Q)/(d t)$, et on peut définir $Phi_"surf" = (delta Q)/(d t d S)$])

On a $Phi$ en $W$ et $Phi_"surf"$ en $W.m^(-2)$

== Échanges conductifs

#theorem([Flux conductif], [Dans le cas d'un échange convectif (c'est à dire via une paroi) entre 2 systèmes, on a $Phi = 1/R Delta T$ avec $R$ la résistance thermique])

#theorem([Résistance thermique], [
  Une résistance thermique est homogène à $k.W^(-1)$, et on a $R = e/(S lambda)$ avec $e$ l'épaisseur, $S$ la surface et $lambda$ la conductivité thermique
])

La conductivité thermique s'exprime en $W.m^(-1).k^(-1)$, plus la conductivité est grande moins on isole.

On a $G = 1/R$ la conductance.

Les résistances thermiques ont le même comportement qu'en électricité, ainsi en série on a $R_"AB" = R_"A" + R_"B"$ et en parallèle $1/R_"AB" = 1/R_"A" + 1/R_"B"$.

#demo([
  - Série : On a $Phi = Phi_"A" = Phi_"B"$ avec $Phi_"A" = (T_A - T_*)/R_"A"$ et $Phi_"B" = (T_* - T_B)/R_"B"$ \ Ainsi on a $T_A - T_B = T_A - T_* + T_* - T_B = R_A Phi_"A" + R_B Phi_"B" = (R_A + R_B) Phi$ \
  
  - Parallèle : On a $Phi_"A" = 1/R_A Delta T$ et $Phi_"B" = 1/R_B Delta T$, et $Phi = Phi_"A" + Phi_"B" = (1/R_A + 1/R_B) Delta T$
])

== Échanges conductovectifs

On considère un fluide et un solide et leurs échanges thermiques

#theorem([Loi thermique de Newton], [
  On a $Phi_"surf" = h (T_"surf" - T_"ext")$ avec $h$ le coefficient de transfert en $W.m^(-2).k^(-1)$, $h$ étant plus grand pour un liquide que pour un gaz.
])

De manière analogue on peut définir $1/R = S h$

== Analogie électrique

On a l'analogie suivante :

#table(columns: (120pt, 120pt), align: center, rows: (),
[*Thermodynamique*],
[*Électricité*],
$Delta T$,
[$U$ ou $Delta V$],
[$Phi$],
$I$,
$Delta T = R Phi$,
$U = R I$
)

Ainsi on peut représenter des problèmes thermodynamiques avec des circuits électriques

#heading([Machines thermiques], supplement: [thermo])

== Description générale d'une machine thermique cyclique

On parle d'un système *cyclique* si il décrit un cycle

#figure(image("thermo/cycle.svg", height: 100pt))

On représente ainsi une machine cyclique, avec $T_1, ..., T_n$ les thermostats. Le système est en convention récepteur sur le schéma.

#theorem([Inégalité de Carnot], [
  Pour un système au contact de plusieurs thermostats, on a $sum_"thermostats" Q_i^("cycle")/T_i <= 0$, et si il est réversible $sum_"thermostats" Q_i^("cycle")/T_i = 0$
])

#demo([
  On a $Delta S = S_c^"cycle" + S_e^"cycle" = 0$ (car $S$ est une fonction d'état) d'où $sum_"thermostats" Q_i^("cycle")/T_i = - S_c <= 0$
])

== Les moteurs

#theorem([Second principe selon Thomson], [Un système au contact avec une seule source de chaleur, ne peut au cours d'un cycle que recevoir du travail et fournir de la chaleur])

#demo[
  On a moteur d'où $W < 0$, avec l'inégalité de Carnot on a $Q/T <= 0$ et le premier principe nous dit que $0 = Q + W$ d'où $W = -Q >= 0$ ce qui est contradictoire
]


#figure(image("thermo/raveau.png", height: 130pt))

Pour étudier un moteur on peut utiliser le diagramme de Raveau avec les zones suivantes :

- *I* : Fonctionnement moteur, $Q_c >= 0$ et $Q_f <= 0$ car on prélève de l'énergie à la source chaude
- *II/III* : Sans intêret
- *IV* : Fonctionnement récepteur, $Q_f >= 0$ et $Q_c <= 0$ car on prélève de l'énergie à la source froide

== Rendement, efficacité

#theorem([Rendement ou efficacité], [
  On définit le rendement dans le cas d'un moteur et l'efficacité dans le cas d'un récepteur de la manière suivante :
  $ eta = "énergie valorisable"/"énergie couteuse" $
])

Ainsi on a le tableau suivant :

#table(columns: (120pt, 120pt), align: center, rows: 20pt,
[*Type de machine*],
[*Rendement/Efficacité*],
[Moteur],
[$eta = - W/Q_c$],
[Réfrigirateur],
[$eta = Q_f/W$],
[Pompe à chaleur],
[$eta = - Q_c/W$],
)

#theorem([Rendement de Carnot], [Pour un moteur ditherme son rendement maximal est : \
$ eta_c = 1 - T_F/T_C$  avec $eta <= eta_c$])

#demo([
  On a $Q_F + Q_C + W = 0$, $Q_C/T_C + Q_F/T_F <= 0$ et $eta = -W/Q_C$ \ \
  D'où $eta = (Q_C + Q_F)/Q_C = 1 + Q_F/Q_C$ or $Q_F <= -Q_C T_F/T_C$ d'où $eta <= 1 - T_F/T_C$
])

#heading([Changement de phase du corps pur], supplement: [thermo])

Une *phase* est une partie d'un système dont les variables intensives sont continues

#figure(
  image("thermo/states.jpg", width: 40%)
)

== Échauffement isobare d'un corps pur

La *température d'ébullition* est la température d'équilibre liquide vapeur (ie les 2 coexistent)

La *température de fusion* est la température d'équilibre solide liquide (ie les 2 coexistent)

La *pression de vapeur saturante* est la pression d'équilibre liquide vapeur

Dans le cas des corps purs, on a $P_"vap" = f(T_"ébul")$

== Diagramme ($P$, $T$), Clapeyron

#figure(
  image("thermo/clapeyron.jpg", width: 30%)
)

$T$ représente le *point triple*, c'est à dire le point où on a équilibre vapeur solide liquide

$C$ représente le *point critique*, c'est à dire au delà duquel il n'y a plus de différence entre état liquide et gazeux (on parle de *fluide supercritique*)

En regardant le diagramme de Clapeyron on a des informations sur l'état du système considéré, et on peut se rendre compte que de l'eau se liquéfie sous l'effet de la compression

== Diagramme ($P$, $v$), isotherme d'Andrews

#figure(
  image("thermo/andrews.svg", width: 50%),
  caption: [Un isotherme d'Andrews]
)

On voit sur le diagramme qu'au dessus de $C$ on ne passe pas par l'équilibre liquide vapeur. De plus on appelle la courbe noire l'*isotherme critique*.

#theorem([Théorème des moments chimiques],[
  On peut retrouver $x_"gaz"$ et $x_"liq"$ les titres en vapeur et en liquide (ie les pourcentages en terme de quantité de matière).

  On a $x_"gaz" = n_"gaz"/n_"tot" = m_"gaz"/m_"tot"$ et $x_"liq" = n_"liq"/n_"tot" = m_"liq"/m_"tot"$

  De plus on a $x_"gaz" = (v - v_"liq")/(v_"gaz" - v_"liq")$ et $x_"liq" = (v_"gaz" - v)/(v_"gaz" - v_"liq")$ d'où $x_"gaz" +x_"liq" = 1$ avec $v, v_"gaz", v_"liq"$ les volumes massiques lus sur un isotherme d'Andrews
])

#demo([
  On a $V = V_g + V_l = m_"tot" v$ avec $v$ le volume massique moyen, $V_g = m_g v_g$ et $V_l = m_l v_l$

  D'où on a $x_l = m_l/m_"tot"$ ainsi on a $m_g v_g + m_l v_l = m_"tot" v$ d'où $v_l x_l cancel(m_"tot") + v_g (1-x_l) cancel(m_"tot") = cancel(m_"tot") v$ d'où $x_l = (v_"gaz" - v)/(v_"gaz" - v_"liq")$
])

Dans le cas d'un diagramme ($P$, $H$) on a aussi $x_l = (h_"gaz" - h)/(h_"gaz" - h_"liq")$

== Enthalpie et entropie de changement d'état

Lors d'un changement d'état, l'enthalpie présente une discontinuité, ainsi on définit l'*enthalpie de changement d'état* (ou chaleur latente), de même il y a discontinuité de l'entropie.

#theorem([Variations d'enthalpie/d'entropie], [
  Soit $Delta_"A"h$ l'enthalpie de changement d'état $A$ et $Delta_"A"s$ l'entropie de changement d'état $A$.

  On a $Delta_A H = m Delta_"A"h$ et $Delta_A S = (Delta_A H)/T_A$ avec $T_A$ la température de changement d'état.
])

De plus on a $Delta_"sub"h > 0$, $Delta_"vap"h > 0$ et $Delta_"fus"h > 0$ et $Delta_"con"h = -Delta_"sub"h$, $Delta_"liq"h = -Delta_"vap"h$ et $Delta_"sol"h = -Delta_"fus"h$

D'après l'expression des variations, on en déduit que $S_"gaz" > S_"liq" > S_"sol"$ ce qui est logique d'après la définition de l'entropie

#counter(heading).update(0)

#set heading(numbering: "📝 I.1.a")

#heading([Analyse dimensionnelle], supplement: [annex])

A faire
// Grand tableau avec tous les unités rencontrées

#heading([Incertitudes], supplement: [annex])

A faire
// Expliquer les types d'incertitudes

#heading([Équations différentielles], supplement: [annex])

A faire

// Ordre 1/2 en linéaire
// Temps caractéristique, méthode 63%, tangentes
// Non linéaires

#heading([Numérique], supplement: [annex])

// Monte Carlo/Régression linéaire/Euler...

#outline(depth:2,indent: 10pt, title: "Table des matières :")