#set heading(numbering: "I.1.a")
#import "@local/unify:0.6.0": *
#import "@local/physica:0.9.3": *
#import "@local/cetz:0.2.2": *

#let project(title: "", authors: (), date: none, body) = {
  set document(author: authors.map(a => a.name), title: "Essentiel de physique")
  
  set page(numbering: "1", number-align: center, footer: locate(loc => 
      if (loc.page() > 1) {
        box(width: 100%, grid(
          columns: (40%, 20%, 40%),
          rows: (20pt),
          [],
          align(center + horizon, str(loc.page())),
          align(right + horizon, text("Victor Sarrazin", size: 9pt)),
        ))
    } else {
      []
    }
  ))
  set text(font: "Cantarell", lang: "en")

  align(center + horizon)[
    #block(text(weight: 800, 30pt, "🧪 Essentiel de physique"))
    #v(1em, weak: true)
    #date
  ]

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

  align(center,image("physics/logo.png", width: 50%))

  set par(justify: false)

  body
}


#show raw.where(block: true): it => { set par(justify: false); grid(
  columns: (100%, 100%),
  column-gutter: -100%,
  block(width: 100%, inset: 1em, for (i, line) in it.text.split("\n").enumerate() {
    box(width: 0pt, align(right, str(i + 1) + h(2em)))
    hide(line)
    linebreak()
  }),
  box(
    radius: 4pt, 
    fill: black,
    width: 100%,
    align(
        right, 
        block(
          radius: 4pt, 
          fill: if it.lang == "python" or it.lang == "ml" { rgb("#fffcdf") } 
                else if it.lang == "c" { rgb("#e8f1fd") } 
                else { luma(246) }, 
          width: 100%-3pt, 
          inset: 1em,
          stroke: stroke(cap: "round", thickness: 0.5pt),
          align(
            left, 
            stack(
              place(
                dx: 100%-12pt,
                image("global/languages/" + it.lang + ".svg", width: 12pt)
              ),
              it
            ),
          ),
        ),
      ),
    ),
)}

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

#let todo(text:"") = box(
    radius: 4pt, 
    fill: yellow,
    width: 100%,
    align(
        right, 
        block(
          radius: 4pt, 
          fill: rgb("#fcfcd2"),
          width: 100%-3pt, 
          inset: 1em,
          stroke: stroke(cap: "round", thickness: 0.5pt, paint: yellow),
          align(left, [#emoji.pencil A faire #text])
        ),
      ),
    );

#let warning(t) = box(
    radius: 4pt, 
    fill: orange,
    width: 100%,
    align(
      right, 
        block(
          radius: 4pt, 
          fill: rgb("#faeec0"),
          width: 100%-3pt, 
          inset: 1em,
          stroke: stroke(cap: "round", thickness: 0.5pt, paint: orange),
          grid(
            columns: (28pt, 100% - 24pt),
            align(left + horizon, image("global/warning.svg", width: 20pt)),
            align(left, [#text([Attention :], weight: "bold") \ #t])
            ),
          )
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
    align(left, [#text("Preuve :", weight: "bold", luma(56.7%)) \ #text(t, luma(56.7%))])
  ),
)

#let derivativePart(a, b, c) = $eval(pdv(#a, #b))_(#c)$
#let derivative(a, b) = $(d #a)/(d #b)$
#let dt = $dd(t)$
#let ddt(a) = $dv(#a, t)$

#let ex = $arrow(e_x)$
#let ey = $arrow(e_y)$
#let ez = $arrow(e_z)$
#let er = $arrow(e_r)$
#let et = $arrow(e_theta)$
#let ep = $arrow(e_phi)$

#let ext = $"ext"$

#let graph(funcs: (), size: (10,4), domain: (0, 10), tickx: none, ticky: none, lines: (), x_axis: $x$, y_axis: $y$, width: 100%) = box(width: width, 
  align(center, 
    canvas({
      plot.plot(axis-style: "school-book", size: size, x-label: x_axis, y-label: y_axis, x-tick-step: tickx, y-tick-step: ticky, {
        for func in funcs {
          plot.add(domain: domain, func, samples: 500)
        }

        for line in lines {
          plot.add-hline(line)
        }
      })
    })
  )
)

#show: project.with(
  title: "Essentiel de physique",
  authors: (
    (name: "Victor Sarrazin", phone: ""),
  ),
  date: "2023/2024",
)

#align([_Bienvenue dans l'essentiel de physique de mes cours de prépa. Ce document a pour objectif de contenir l'intégralité des cours de physique afin de les condenser et de les adapter._

_Dans la dernière partie une liste de méthodes est détaillée pour faciliter notre voyage dans la physique._

#align(right, text([_Bonne lecture..._]))])

#pagebreak()

#align(center, text([📋 Sommaire], weight: 800, size: 24pt))

#outline(depth:1,indent: 10pt, fill: [], title: "Optique :", target: heading.where(supplement: [optical]))

// Faire des montages : https://phydemo.app/ray-optics/simulator/

#outline(depth:1,indent: 10pt, fill: [], title: "Électricité :", target: heading.where(supplement: [elec]))

// Faire des circuits : https://www.circuit-diagram.org/editorb/

#outline(depth:1,indent: 10pt, fill: [], title: "Ondes :", target: heading.where(supplement: [waves]))

#outline(depth:1,indent: 10pt, fill: [], title: "Mécanique :", target: heading.where(supplement: [meca]))

// Simu pendule : https://phet.colorado.edu/sims/html/pendulum-lab/latest/pendulum-lab_all.html

#outline(depth:1,indent: 10pt, fill: [], title: "Thermodynamique :", target: heading.where(supplement: [thermo]))

#outline(depth:1,indent: 10pt, fill: [], title: "Magnétostatique :", target: heading.where(supplement: [magne]))

#outline(depth:1,indent: 10pt, fill: [], title: "Mécanique quantique :", target: heading.where(supplement: [quantum]))

#outline(depth:1,indent: 10pt, fill: [], title: "Fiches TP :", target: heading.where(supplement: [tp]))

#outline(depth:1,indent: 10pt, fill: [], title: "Annexe :", target: heading.where(supplement: [annex]))

#let pext = $P_"ext"$

#pagebreak()

#counter(heading).update(0)

#set heading(numbering: "🔭 I.1.a")

#align(center, text([🔭 Optique], weight: 800, size: 24pt))

#box(height: 1em)
#heading([Introduction à l'optique], supplement: [optical],)

== Généralités

On considère des milieux *transparent homogène isotropes* (THI) :
- Transparent : La lumière n'est pas absorbée
- Homogène : Invariant par translation
- Isotrope : Invariant par quelque soit la direction depuis laquelle on regarde

On a la *vitesse de la lumière* dans le vide, $c = qty("3.0e8", "m/s")$

#theorem([Indice optique],[
  On a l'*indice optique* $n$ (ou _indice de réfraction_), usuellement $n > 1$.
  On a $n = c/v$ avec $v$ la vitesse dans un THI donné.
])

On a $n_"vide" = 1$, $n_"air" - n_"vide" = num("3e-4")$ et $n_"eau" = 1.3$

#theorem([Relation de dispertion], [
  On a $lambda = c/f$ avec $f$ la fréquence temporelle et $lambda$ la longueur d'onde dans le vide. Dans un THI on a donc $lambda = c/(n f)$
])

#figure(image("physics/optical/spectrum.png", width: 70%))

On a $lambda_"violet" = qty("400", "nm")$ et $lambda_"rouge" = qty("800", "nm")$. Si $lambda < qty("400", "nm")$ on est dans le domaine des *ultraviolets* et si $lambda > qty("800", "nm")$ on est dans le domaine des *infrarouges*.

La puissance lumineuse moyenne par unité de surface est appelée *éclairement* ($xi$) ou *intensité lumineuse* ($I$).

== Caractérisation spectrale des sources lumineuses

Une onde lumineuse possède une décomposition spectrale. On utilise principalement un spectromètre à réseau pour déterminer cette décomposition.

#figure(image("physics/optical/laser_spectrum.png", width: 50%))

On a dans le cas du laser une seule raie spectrale, on parle alors de lumière *monochromatique*.

#figure(image("physics/optical/spectral_spectrum.jpg", width: 50%))

On a dans le cas d'une lampe spectrale plusieurs raies, c'est un spectre des éléments qui composent la valeur dans l'ampoule. Chaque pic correspond à un 1 photon d'énergie donnée

#figure(image("physics/optical/sun_spectrum.png", width: 50%))

On a dans le cas du soleil un spectre continu (corps noir) avec des "trous" liés aux absoptions sélectives des espèces chimiques présentes dans l'atmosphère.

== Source lumineuse ponctuelle, rayon lumineux

Une *source lumineuse ponctuelle* est une source de lumière dont les dimesions sont négligeables devant les distances caractéristiques du problème.

On appelle *rayon lumineux* une ligne selon laquelle se propage la lumière.

#theorem([Propriétés des rayons lumineux],[
  - Les rayons lumineux sont indépendants les uns des autres
  - Les rayons lumineux se propagent de façon rectilligne uniforme dans les milieux THI
])

== Approximation de l'optique géométrique

#theorem([Approximation de l'optique géométrique],[
  Les systèmes rencontrés par la lumière lors de sa propagation sont de dimension grande devant la longueur d'onde.
])

Dans la suite on se place dans cette approximation

== Lois de Snell-Descartes

#figure(image("physics/optical/snell_descartes.jpg", width: 50%))

=== Lois de l'optique géométrique

On parle d'un *dioptre* pour désigner la surface entre deux milieux transparents.

#theorem([Principe de retour inverse],[La forme d'un rayon lumineux ne dépend pas du sens dans lequel la lumière le parcourt])

#theorem([Loi de Descartes pour la réflexion],[Les rayons incidents et réfléchis sont dans le même plan , et $ alpha = i $ Avec $alpha$ l'angle réféchi et $i$ d'incidence])

#theorem([Loi de Descartes pour la réfraction],[Les rayons incidents et réfractés sont dans le même plan , et $ n_r sin(r) = n_i sin(i) $ Avec $r$ l'angle réféchi et $i$ d'incidence, avec $n_r, n_i$ les indices optiques des 2 milieux])

=== Réflexion totale

Si $n_1 > n_2$, on dit que le milieu $1$ est plus *réfringent* que le milieu $2$.

#theorem([Réflexion totale],[Il existe un angle d'incidence limite $i_"1,lim" = arcsin(n_2/n_1)$ tel que si $i_1 > i_"1,lim"$ il n'y ait plus de rayon réfracté])

#demo([
  On part de la loi de Descartes pour la réfraction, $n_1 sin(i) = n_r sin(r)$ avec $r > i$ et $n_1 > n_2$ d'où $n_1/n_2 = sin(r)/sin(i) > 1$ d'où $sin(r) > sin(i)$.

  Ainsi $sin(r) = n_i/n_r sin(i)$ d'où si $i > arcsin(n_2/n_1)$ on a $sin(r) > 1$ ce qui est contradictoire.
])

Ce phénomène est utilisé dans les fibres optiques.

#box(height: 1em)
#heading([Lentilles minces et miroir plan], supplement: [optical])

== Vocabulaire

Un *système optique* est un système plus ou moins complexe susceptible de perturber le trajet des rayons lumineux.

On a :

#align(center, text([Rayons incidents $-->$ Système optique $-->$ Rayons émergents]))

Si des rayons incidents proviennent d'un même point, on parle de *point objet*.

Si des rayons émergents proviennent d'un même point, on parle de *point image*.

On dit que $A'$ est conjugué à $A$ si $A'$ est l'image de $A$, et on note $A arrow.cw.half^"miroir" A'$

Un système qui conjugue à un point objet un point image est dit *stigmatique*. Seul le *miroir plan* l'est parfaitement.

On parle de *système centré* pour un système possédant un axe de symétrie appelé *axe optique* ($O A$)

On parle d'*aplanétisme* si $2$ points objets dans le même plan orthogonal à $O A$ sont conjugués à $2$ points image dans un même plan orthogonal à $O A$ (encore le cas du miroir plan)

Un point est *réel* si il exist réellement, et *virtuel* un point où se coupent les prolongements des rayons incidents.

== Lentilles minces

On parle de lentille mince car l'épaisseur est petite devant les rayons de courbure.

#theorem([Conditions de Gauss],[
  Tous les rayons sont *paraxiaux*, soit peu inclinés et peu éloignés de $O A$.

  Dans ces conditions on a un stigmatisme approché et un applanétisme approché.

  On peut aussi se placer dans l'approximation des petits angles, $alpha << 1$ d'où $tan alpha = sin alpha = alpha$ et $cos alpha = 1$
])

Le *centre optique* est le point d'un système optique où les rayons ne sont pas déviés.

Le *foyer principal image* ($F'$) est l'image conjuguée d'un point objet à l'infini dans la direction de l'axe optique.

Le *foyer principal objet* ($F$) est l'objet conjugé d'un point image à l'infini dans la direction de l'axe optique.

#theorem([Distance focale],[
  On a la *distance focale image* : $overline(O F') = f'$ et on a la *distance focale objet* : $overline(O F) = f$

  Ces deux grandeurs sont algébriques
])

On a $abs(f) = abs(f')$. Une lentille est très convergente/divergente quand $abs(f')$ est très petit.

On note la *vergence* d'une lentille $v = 1/f$ en dioptrie $delta$ avec $[delta] = unit("m^-1")$

On définit le *grandissement*, $gamma = overline(A' B')/overline(A B)$ soit la taille de l'image sur la taille de l'objet

=== Lentille convergente

Une lentille est dite *convergente* si elle est à bords fins.

#figure(image("physics/optical/lentille_cv.jpg", width: 60%))

=== Lentille divergente

Une lentille est dite *divergente* si elle est à bords épais.

#figure(image("physics/optical/lentille_dv.jpg", width: 60%))

== Constructions 

On fera toujours les constructions au stylo, et on respectera les règles suivantes :

- Un rayon incident qui passe par $O$ est non dévié
- Un rayon incident qui passe par $F$ émerge parallèlement à $O A$
- Un rayon émergent qui passe par $F'$ incide parallèlement à $O A$
- Deux rayons incidents parallèles entre eux émergent en se croisant en un même point du plan focal image
- Deux rayons émergents parallèles entre eux incident en se croisant en un même point du plan focal objet

#figure(image("physics/optical/optical.png", width: 80%))

== Relations de conjugaison

#theorem([Relations de Descartes (centre optique)],[
  On a :
    $ 1/overline(O A') - 1/overline(O A) = 1/f' $
    $ gamma = overline(O A')/overline(O A) $
])

#theorem([Relations de Newton (foyer)],[
  On a :
    $ overline(F' A') times overline(F A) = - (f')^2 $
    $ gamma = - overline(F' A')/f' = - f/overline(F A) $
])

#demo([Cette preuve est hors programme théoriquement.
#figure(image("physics/optical/conjug.png"))

#todo(text:[(Si pas la flemme)])
])

== Condition $4 f'$

#theorem([Condition $4f'$],[
  Pour obtenir une image réelle d'un objet réel avec une lentille convergente,
  $ D >= 4f' $
])

#demo([
  On pose $overline(A A') = D$ d'où $overline(O A') = D - x$ et $overline(O A) = -x$ (grandeurs algébriques)

  On utilie la relation de conjugaison, $1/overline(O A') - 1/overline(O A) = 1/f'$ d'où $1/(D - x) + 1/x = 1/f'$
  
  Ainsi on a $x^2 - D x + f' D$ donc $Delta = D(D-4 f')$, ainsi si $D >= 4 f'$ on a $Delta >= 0$ donc $x >= 0$ donc $A'$ est réel, sinon $A'$ est virtuel (d'où la condition)
])

#box(height: 1em)
#heading([Appareils optiques], supplement: [optical])

== Généralités

On parle de *diamètre apparent* pour l'angle sous lequel on voit un objet.

#theorem([Grossissement],[
  On a le *grossissement*, $ G = alpha_"appareil optique" / alpha_"oeil nu" $
])

== La lunette astronomique

#figure(image("physics/tp/lunette_astro.png", width: 50%))

La lunette astronomique est un système optique composé de deux lentilles, une *objectif* et une *oculaire*.

L'*objectif* est la lentille qui reçoit la lumière, et l'*oculaire* est la lentille qui donne l'image.

Le *foyer principal objet* de l'objectif doit être confondu avec le *foyer principal image* de l'oculaire.

On parle d'un système *afocal* si on donne une image à l'infini d'un objet à l'infini.

Ce dispositif permet d'avoir une image à l'infini d'un objet à l'infini.

Il est détaillé dans les fiches TP.

== L'oeil

La plus petite séparation angulaire que l'oeil peut distinguer est de $1'$ (minute d'arc) soit $1/60$ degré.

L'oeil est modélisable comme un dispositif optique :

- On a l'iris qui joue le role de diaphragme

- Le cristallin qui joue le role de lentille convergente

- La rétine qui joue le role d'écran

On parlera de *puctum proximum* pour la distance minimale à laquelle on peut voir distinctement ($qty("25","cm")$, et de *punctum remotum* pour la distance maximale à laquelle on peut accomoder ($oo$)

#pagebreak()

#counter(heading).update(0)

#set heading(numbering: "⚡ I.1.a")

#align(center, text([⚡ Électricité], weight: 800, size: 24pt))

#box(height: 1em)
#heading([Introduction à l'électricité], supplement: [elec])

== Généralités

=== Charge électrique

La *charge* est une propriété intrinsigue d'une particule et s'exprime en Coulomb ($c$) et est de dimension $I.T$, est algébrique, additive et conservative (un système fermé est de charge fixe).

La charge est portée par les électrons ($-e$) et les protons ($e$) avec $e = 1.6 times 10^(-19) c$ la *charge élémentaire* (souvent notée $q$).

=== Courant électrique

Le *courant électrique* est un déplacement d'ensemble de charges

On parle de *régime continu* si le courant est constant, et de *régime variable* si le courant varie.

=== Dipôle, branche, maille, circuit

Un *dipôle* possède 2 pôles, lui permettant d'être traversé par un courant électrique. Une association de dipôles forme un *circuit*.

Un association de dipôles à la suite est appelée *association série* et forme une *branche*.

On parle de *noeud* pour un point où plusieurs branches se rejoignent.

Un association de dipôles bouclant sur elle même est appelée *maille*.

=== Intensité électrique

L'*intensité électrique* est un débit de charge noté $I$, avec $I = (delta Q)/dt$ avec $delta Q$ la charge traversant la section pendant $dt$.

Pour mesurer une intensité on utilise un _ampèremètre_ avec le $+$ sur le $m A$ ou $mu A$ et le $-$ sur le COM (en série).

#figure(
  image("physics/elec/nodes_law.png", width: 20%)
)

#theorem([Loi des noeuds],[
  Dans une maille on a : $ sum_"entrants" I = sum_"sortants" I $
])

Ordres de grandeur de l'intensité :

- $I_"téléphone" approx unit("mA")$
- $I_"prise" = "qq" unit("A")$
- $I_"TGV, ligne haute tension" = 500 - 1000 unit("A")$
- $I_"foudre" = 10^4 unit("A")$

== La tension électrique

La *tension électrique* $U$ est une différence de potentiels en Volts ($unit("V")$) et est additive.

#figure(
  image("physics/elec/tension_ab.png", width: 20%)
)

#theorem([Expression de $U_"AB"$],[
  On a $U_"AB" = V_A - V_B$ avec $V_A$ et $V_B$ deux potentiels électriques
])

Ordres de grandeur de la tension :

- $U_"pile" = 1 - 9 unit("V")$
- $U_"batterie" = 12 unit("V")$
- $U_"prise" = 220 unit("V")$
- $U_"ligne haute tension" = 150 - 1000 unit("kV")$
- $U_"foudre" = 10^8 unit("V")$

#figure(
  image("physics/elec/loop_law.png", width: 20%)
)

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

Si ce critère est vérifié, tous les points du circuit "voient" le changement en direct. Ce critère est tout le temps vérifié en tp.

== Résistors

Un *résistor* est une dipôle qui conduit $+$ ou $-$ bien l'électricité.

#figure(image("physics/elec/resistance.png", width: 20%))

Une résistance est schématisée ainsi en convention récepteur (ie l'intensité et la tension ne sont pas dans le même sens), et dans ce cas la $P = U I$ représente la puissance reçue.

#theorem([Loi d'Ohm],[
  On a $U = R I$ avec $R$ la résistance en Ohm ($unit("Ohm")$) en convention récepteur.

  Attention, en convention générateur, on a $U = - R I$
])

On définit la *conductance* $G = 1/R$ en Siemens ($unit("S")$).

Ordres de grandeur de la résistance :

- $R_"Ampèremètre" = "qq" unit("Ohm")$
- $R_"Fer à repasser" = 40 unit("Ohm")$
- $R_"Électronique" = 10^6 - 10^7 unit("Ohm")$
- $R_"Voltmètre" = 10^6 unit("Ohm")$

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

On a la *masse*, un point d'un circuit de potentiel nul, $V = 0 unit("V")$ c'est l'origine des potentiels.

En théorie elle est choisie arbitrairement, mais en pratique elle est imposée par certails appareils reliés à la Terre.

== Associations des résistors

#figure(image("physics/elec/serial_res.png", width: 30%))

#theorem([Association série de résistors],[
  Soit $R_1$ et $R_2$ deux résistances en série, on a $R_e = R_1 + R_2$ la résistance équivalente
])

#demo([
  On a $U_1 = R_1 I$ et $U_2 = R_2 I$ ainsi $U = U_1 + U_2 = R_1 I + R_2 I = (R_1 + R_2) I$ ainsi $R_e = R_1 + R_2$
])

#figure(image("physics/elec/parallel_res.png", width: 25%))

#theorem([Association parallèle de résistors],[
  Soit $R_1$ et $R_2$ deux résistances en parallèle, on a $1/R_e = 1/R_1 + 1/R_2$ la résistance équivalente
])

#demo([
  Par loi des mailles, $U = U_1 = U_2$, ainsi $U = R_1 I_1 = R_2 I_2$, d'après la loi des noeuds, $I = I_1 + I_2 = U/R_1 + U/R_2 = U(1/R_1 + 1/R_2)$ ainsi $U = 1/(1/R_1 + 1/R_2) I$
])

== Ponts diviseurs

#figure(image("physics/elec/serial_res.png", width: 30%))

#theorem([Pont diviseur tension],[Soit $R_1$ et $R_2$ deux résistances en séries, $U_1 = R_1/(R_1 + R_2) U$])

#demo([
  On a $U_1 = R_1 I$ et $U = (R_1 + R_2) I$ d'où $U_1/U = (R_1 I)/((R_1+R_2) I)$
])

#figure(image("physics/elec/parallel_res.png", width: 25%))

#theorem([Pont diviseur courant],[Soit $R_1$ et $R_2$ deux résistances en parallèle, $I_1 = R_2/(R_1 + R_2) I = (1/R_1)/(1/R_1 + 1/R_2) I$])

#demo([
  On a $I_1 = U/R_1$ et $U = (R_1 R_2)/(R_1 + R_2) I$ d'où $I_1 = (R_2)/(R_1+R_2) I$
])

== Générateurs

=== Générateur de tension

#figure(image("physics/elec/tension.png", width: 10%))

Un *générateur de tension* est un dipole qui impose une tension entre ses bornes. La tension imposée par un générateur est aussi appelée sa *force électromotrice* (f.e.m)

$U$ est donc indépendante, c'est une dipôle actif.

#figure(image("physics/elec/thevenin.png", width: 20%))

Un générateur réel est un générateur de Thévenin, on a :

#theorem([Générateur de Thévenin],[
  On a $U = U_r + E = E - R_i I$ et $P_"fournie" = U I = (E - R_i I) I = E I - R_i I^2$, avec $R_i$ la résistance interne et $E$ la f.e.m
])

=== Générateurs de courant (HP)

#figure(image("physics/elec/courant.png", width: 10%))

Il existe des *générateurs de courant* qui fixent une intensité dans le circuit.

#box(height: 1em)
#heading([Circuits d'ordre 1], supplement: [elec])

== Le condensateur

=== Généralités

Le *condensateur* est un dipôle linéaire composé de deux armatures séparées par un milieu isolant (_diélectrique_).

#figure(image("physics/elec/condensator.jpg", width: 10%))

On a $Q$ la charge algébrique par l'armature de gauche et $-Q$ par celle de droite : le condensateur est globalement neutre.

On a $Q = C U$ avec $C$ la *capacité du condensateur* en Farad ($unit("F")$)

Ordres de grandeur de la capacité :

- $C_"condensateur de TP" = 1 unit("nF") - 1 unit("uF")$
- $C_"condensateur en électrotechnique" = 1 unit("uF") - 1 unit("F")$
- $C_"condensateur en électronique" = 1 unit("pF") - 1 unit("uF")$

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
  En régime permanent un condensateur est équivalent à un interrupteur ouvert ($I = 0 unit("A")$)
])

=== Associations

#figure(image("physics/elec/serial_capa.png", width: 30%))

#theorem([Association série de condensateurs],[
  Soit $C_1$ et $C_2$ deux condensateurs en parallèle, on a $1/C_e = 1/C_1 + 1/C_2$ le condensateur équivalent
])

#demo([
  On a $U = U_1 + U_2$ avec $i = i_1 = i_2$ d'où $i = C_1 ddt(U_1)= C_2 ddt(U_2)$.

  Ainsi on a $ddt(U) = ddt(U_1) + ddt(U_2)$ soit $i/C_e = i/C_1 + i/C_2$ d'où la relation cherchée.
])

#figure(image("physics/elec/parallel_capa.png", width: 25%))

#theorem([Association parallèle de condensateurs],[
  Soit $C_1$ et $C_2$ deux condensateurs en série, on a $C_e = C_1 + C_2$ le condensateur équivalent
])

#demo([
  Loi des noeuds on a $i = i_1 + i_2$ d'où on a $i_1 = C_1 ddt(U)$ et $i_2 = C_2 ddt(U)$ d'où $i = (C_1 + C_2) ddt(U)$
])

== Charge d'un condensateur

On peut étudier la charge d'un condensateur (ou sa décharge) avec une équation d'ordre 1 dans un circuit RC

#theorem([Équation différentielle RC],[
  On a $ ddt(U) + U/tau = U_infinity/tau $ avec $tau = R C$ le temps caractéristique dans le circuit RC
])

== La bobine

=== Généralités

La *bobine* est un dipôle linéaire composé d'un enroulement de fils sur lui même

#figure(image("physics/elec/inductor.png", width: 20%))

On associe à une bobine une *inductance* $L$ en Henry ($unit("H")$), dépendant du nombre de fils et la quantités de spires (tours)

Ordres de grandeur de l'inductance :

- $L_"bobine de TP" = 1 unit("uH") - 1 unit("mH")$
- $L_"haut parleur" = 1 unit("mH")$
- $L_"1m de cable" = 100 unit("nH")$

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

#theorem([Comportement en régime permanent],[
  En régime permanent un condensateur est équivalent à un fil ($U = 0 unit("V")$)
])

=== Associations

#figure(image("physics/elec/serial_indu.png", width: 30%))

#theorem([Association série de bobines],[
  Soit $L_1$ et $L_2$ deux bobines en série, on a $L_e = L_1 + L_2$ la bobine équivalente
])

#demo([
  On a $U = U_1 + U_2 = L_1 ddt(i) + L_2 ddt(i) = (L_1 + L_2) ddt(i)$
])

#figure(image("physics/elec/parallel_indu.png", width: 25%))

#theorem([Association parallèle de bobines],[
  Soit $L_1$ et $L_2$ deux bobines en parallèle, on a $1/L_e = 1/L_1 + 1/L_2$ la résistance équivalente
])

#demo([
  Par loi des mailles, $U = U_1 = U_2$, ainsi $U = L_1 ddt(i_1) = L_2 ddt(i_2)$.
  
  D'après la loi des noeuds, $i = i_1 + i_2$ d'où $ddt(i) = ddt(i_1) + ddt(i_2)$ soit $U/L = U/L_1 + U/L_2$ d'où la relation recherchée
])

#box(height: 1em)
#heading([Circuits d'ordre 2, Oscillateurs], supplement: [elec])

Les oscillateurs sont présentés dans un cas électrique, mais on les retrouve aussi en mécanique ou encore en thermodynamique.

== Oscillateur harmonique

#figure(image("physics/elec/lc.png", width: 30%))

On considère un circuit LC, on trouve $L C dv(U,t,2) + U = E$ d'où en posant $omega_0 = 1/(L C)$ on retrouve :

#theorem([Oscillateur harmonique],[
  On a l'équation différentielle de l'oscillateur harmonique :

  $ dot.double(theta) + omega_0^2 theta = omega_0^2 B $
  avec $omega_0$ la *pulsation caractéristique* homogène à un $unit("r/s")$ et $B$ une constante
])

La forme générale est $"sp" + A cos (omega_0 t) + B sin(omega_0 t)$, la résolution étant détaillée en @equa[annexe]. Elle admet la courbe suivante.

#graph(funcs: (calc.sin,), domain: (0,100))

Ainsi l'oscillateur possède un comportement oscillant avec $2 pi f = omega_0$

== Oscillateur amorti

=== Généralités

#figure(image("physics/elec/rlc.png", width: 30%))

On considère maintenant un circuit RLC, ainsi on trouve l'équation différentielle suivante $E/(L C) = dv(U, t, 2) + R /L ddt(U) + 1/(L C) U$, en posant $omega_0 = 1/(L C)$ et $Q = 1/R sqrt(L/C)$ on a :

#theorem([Oscillateur amorti], [
  On a l'équation différentielle de l'oscillateur armorti :

  $ dot.double(theta) + omega_0/Q dot(theta) + omega_0^2 theta = omega_0^2 theta_infinity $
  avec $omega_0$ la *pulsation caractéristique* homogène à un $unit("r/s")$, $Q$ le *facteur de qualité* adimensionné
  ])

Si on a beaucoup d'oscillations, $Q$ correspond au nombre de périodes avant armortissement.

Selon la valeur de $Q$ on a un des trois types d'oscillateurs suivants :

- Si $Q < 1/2$, on est en régime apériodique
- Si $Q = 1/2$, on est en régime critique
- Si $Q > 1/2$, on est en régime pseudo-périodique

=== Régime apériodique

Dans le cas apériodique on a $Delta > 0$ d'où $U(t) = "sp" + A e^(-t/tau_1) + B e^(-t/tau_2)$, la résolution étant détaillée en @equa[annexe].

$U$ s'amortit donc en quelques $max(tau_1, tau_2)$, et en faisant un DL on a $tau_2 = 1/(w_0 Q)$

#graph(funcs: ((x) => {
  return calc.pow(calc.e, -x/(25))
},), domain: (0,100))

=== Régime critique

Dans le cas critique, on a $Delta = 0$ d'où $U(t) = "sp" + (A t + B)e^(-t/tau)$, la résolution étant détaillée en @equa[annexe], on a quelques $tau = 1/(w_0)$

Le cas critique est très compliqué à réaliser expérimentalement.

#graph(funcs: ((x) => {
  return (0.01 * x + 20) * calc.pow(calc.e, -x/(25))
},), domain: (0,100))

=== Régime pseudo-périodique

Dans le cas pseudo-périodique, on a $Delta < 0$ d'où on a $U(t) = "sp" + (A cos (omega t) + B sin (omega t)) e^(-t/tau)$ avec $omega$ la *pseudo-pulsation*, la résolution étant détaillée en @equa[annexe].

On a quelques $tau = (2 Q)/w_0$

Ainsi dans ce cas les oscillateurs voient leur amplitude d'oscillations diminuer avec le temps.

#graph(funcs: ((x) => {
  return calc.sin(x) * calc.pow(calc.e, -x/(25))
},), domain: (0,100))

On définit le *décrément logarithmique* $delta = ln(A(t)/(A(t+T))) = T/tau$, avec $T$ la *pseudo-période*. Le décrément logarithmique s'obtient en prenant deux valeurs maximales et en faisant $delta = ln(v_1/v_2)$ avec $t_1 < t_2$.

La durée du transitoire est de quelques $tau$.

#warning([En régime pseudo-périodique il n'est pas possible de déterminer graphiquement $tau$ comme dans les autres régimes.])

#box(height: 1em)
#heading([Circuits en régime sinusoidal forcé], supplement: [elec])

== Régime transitoire

#figure(image("physics/elec/rlc.png", width: 30%))

Le circuit est en régime sinusoïdal forcé si le *générateur basse fréquence* (GBF) délivre une tension sinusoïdale. Ainsi on a l'apparition d'un déphasage aux temps longs, et l'amplitude du GBF n'est pas forcément la même que celle de $U$.

Ainsi le second terme dans les équations différentielles devient de la forme $A cos(omega t)$

== Vocabulaire des signaux périodiques

#graph(funcs: (calc.sin,), domain: (0,20))

On définit : 
- La *période* $T$ en $unit("s")$ correspondant à l'écart entre deux passages au même point
- La *fréquence* $f$ en $unit("Hz")$ correspondant au nombre de périodes en une seconde d'où $f = 1/T$
- La *valeur moyenne* $expval(u) = 1/T integral_t^(t + T) u (tilde(t)) dd(tilde(t))$
- L'*amplitude crête à crête* (peak to peak) $Delta = u_"max" - u_"min"$
- La *valeur efficace*, $u_"eff" = sqrt(expval(u^2))$

#theorem([Valeur efficace pour un signal sinusoïdal],[
  Dans le cas d'un signal de la forme $S_0 cos(omega t)$, on a $expval(S) = 0$ et $S_"eff" = S_0/sqrt(2)$
])

#demo([
  En effet en intégrant sur une période, on a $expval(S) = 0$

  On a $expval(S^2) = 1/(2 pi) integral_t^(t + 2 pi) (S_0 cos(omega tilde(t)))^2 dd(tilde(t)) = expval(S^2) = S_0^2 /(2 pi) integral_t^(t + 2 pi) (1 + cos(omega tilde(t)))/2 dd(tilde(t)) = S_0^2/(2 pi) (2 pi)/2 = S_0^2/2$ d'où en passant à la racine, $S_"eff" = S_0/sqrt(2)$
])

== Déphasage entre signaux

Soit $s_1(t) = s cos(omega t + phi_1)$ et $s_2(t) = s cos(omega t + phi_2)$, on définit le *déphasage* de $s_2$ par rapport à $s_1$ par $Delta phi = phi_2 - phi_1$

Le déphasage est défini modulo $2 pi$

- Si $phi_1 equiv phi_2 mod 2pi$ alors les deux signaux sont en *accord de phase*
- Si $Delta phi = plus.minus pi$, alors les deux signaux sont en *opposition de phase*
- Si $Delta phi = plus.minus pi/2$, alors les deux signaux sont en *quadrature de phase*
- Si $phi_2 > phi_1$, $s_2$ est en *avance de phase* sur $s_1$
- Si $phi_2 < phi_1$, $s_2$ est en *retard de phase* sur $s_1$

#graph(funcs: (calc.cos, (x) => {
  return calc.cos(x + 2)
}))

Pour mesurer le déphasage, on mesure l'écart de temps entre 2 passages au même endroit et on obtient $Delta t_1$ et $Delta t_2$, ainsi on doit choisir, en connaissance du système entre $1$ et $2$, et $abs(Delta phi) = (Delta t_i)/T times 2 pi mod 2 pi$

== Représentation complexe d'un signal harmonique

Pour parler d'une représentation complexe en physique on utilise $underline(s) = a + i b$, et le conjugué de $underline(s)$ est noté $underline(s)^* = overline(underline(s)) = a - i b$

#warning([Dans le contexte spécifique de l'électricité et pour éviter des confusions avec l'intensité $i$, on note $j$ le nombre imaginaire tel que $j^2 = -1$ (définition différente des mathématiques)])

En posant $u = U_0 cos(omega t + phi)$, on a $underline(u) = U_0 e^(j (omega t + phi))$ d'où $underline(u) = U_0 e^(j phi) e^(j omega t)$ avec $underline(U) = U_0 e^(j phi)$ *l'amplitude complexe* et $U = abs(underline(u)(t))$

De plus on a $phi = arg(underline(U)) = arg(U_0 e^(j phi))$

Dériver en complexe revient à multiplier par $j omega$

== Impédances complexes

=== Généralités

#theorem([Impédance complexe],[
  En convention récepteur, on définit $underline(z) = underline(u)/underline(i) = U_0/I_0 e^(j(phi_u-phi_i))$ l'*impédance complexe* homogène à une résistance
])

#theorem([Cas d'une résistance],[
  Pour une résistance, on a $underline(z_R) = R$, d'où $underline(z) in RR_+$, on dit que le dipôle est *résistif*
])

#theorem([Cas d'une bobine],[
  Pour une bobine, on a $underline(z_L) = j omega L$, d'où $underline(z) in i RR$ et $phi_u - phi_i = pi/2$, donc $u(t)$ est en quadrature de phase avance par rapport à $i(t)$, on dit que le dipôle est *inductif*.
])

#demo([
  On a $u_L = L ddt(i)$ d'où $underline(u_L) = L j omega underline(i)$ d'où $underline(z_L) = j omega L$
])

#theorem([Cas d'un condensateur],[
  Pour un condensateur, on a $underline(z_C) = 1/(j omega C)$, d'où $underline(z) in i RR$ et $phi_u - phi_i = -pi/2$, donc $u(t)$ est en quadrature de phase retard par rapport à $i(t)$, on dit que le dipôle est *capacitif*.
])

#demo([
  On a $i = C ddt(u_C)$ d'où $underline(i) = L j omega underline(u_C)$ d'où $underline(z_C) = 1/(j omega C)$
])

On définit aussi l'*admittance complexe* comme étant $underline(y) = 1/underline(z)$

=== Comportement basse et haute tension

#theorem([Comportement basse fréquence],[
  En basse fréquence :
  - La bobine se comporte comme un *fil*
  - Le condensateur se comporte comme un *interrupteur ouvert*
])

#theorem([Comportement haute fréquence],[
  En haute fréquence :
  - La bobine se comporte comme un *interrupteur ouvert*
  - Le condensateur se comporte comme un *fil*
])

== Lois de l'électricité en RSF

Les lois de l'électricité restant valides dans l'ARQS, elles sont aussi valides si $omega << (2 pi c)/d$.

Les impédances s'associent en série et en parallèle comme des résistances, et les ponts diviseurs s'appliquent aussi aux impédances.

== Étude d'un circuit

Pour étudier un circuit :
- On peut établir l'équation différentielle de $u$, puis passer dans $CC$ et déterminer $underline(u)$ puis $U$ et $phi$
- On peut utiliser la méthode des impédances complexes (voir ci dessous), valide uniquement en RSF

On considère le circuit suivant, qu'on peut remplacer avec des impédances :

#grid(
    columns: 2,
    figure(image("physics/elec/rc.png", width: 50%)),
    figure(image("physics/elec/rc_c.png", width: 50%)),
)

Ainsi en basse et haute fréquence on a :

#grid(
    columns: 2,
    figure(image("physics/elec/rc_bf.png", width: 50%)),
    figure(image("physics/elec/rc_hf.png", width: 50%)),
)

Par loi des mailles on a $underline(z_R) = R$ et $underline(z_C) = 1/(j omega C)$ d'où le dipole équivalent est $underline(z) = R + 1/(j omega C)$

En utilisant un pont diviseur tension on a $underline(u_C) = underline(z_C)/(underline(z_R) + underline(z_C)) E = 1/(1 + j omega R C) E$

On remarque qu'on peut retrouver l'équation différentielle, on a $underline(u) = 1/(1 + j omega R C) underline(e)$ d'où $underline(u) + j omega R C underline(u) = underline(e)$ d'où $u +  R C dot(u) = e$

== Résonnance

Lorsque l'amplitude de la réponse sinusoïdale d'un système à une excitation sinusoïdale, d'amplitude fixe mais de fréquence variable passe par un maximun, on dit qu'il y a *résonance*.

Dans un RLC série alimeté par un générateur de tension idéal, on a : $underline(I) = underline(U)/underline(R) = (U_0\/R)/(1 + j Q(omega/omega_0 - omega_0/omega))$ ($omega_0 = 1/(sqrt(L C))$ et $Q = 1/(R) sqrt(L/C)$)

Si on trace la *réponse en amplitude*, l'amplitude réelle présente un maximum, alors on dit qu'il y a *résonance en intensité*. On définit $omega_"res"$ la *pulsation de résonnance*, pas toujours égale à $omega_0$ (notamment dans du 2nd ordre).

On définit $omega_c$ les *pulsations de coupure* tel que $I(omega_c/omega_0) = I_max/sqrt(2)$

On a $Delta omega_c = abs(omega_c_1 - omega_c_2)$ la *largeur de résonance*

De plus on a aussi $omega_"res"/(Delta omega_c)$ l'*acuité de résonance*, plus elle est élevée, plus on a un pic.

On peut tracer la *réponse en phase*, $phi = - arctan(Q (omega/omega_0 - omega_0/omega))$, on remarque dans le cas d'un RLC que $phi(omega_"res") = 0$, $abs(phi(omega_c)) = pi/4$ et $omega_"res" = omega_0$.

On a résonance en intensité peu importe le facteur de qualité, mais ça n'est pas toujours le cas (notamment en tension ou en vitesse en mécanique)

On a aussi $Q = omega_"res"/(Delta omega_c)$

#box(height: 1em)
#heading([Filtrage], supplement: [elec])

Les signaux dans la réalité sont complexes à analyser car souvent superposés à un bruit qu'on cherche à éliminer. Ainsi on réalise un *filtrage*, analogique (ici) ou numérique.

== Spectre d'un signal, décomposition de Fourier

Un signal périodique de période $T$ peut se décomposer en une superposition de signaux sinusoïdaux de fréquences multiples.

On a $u(t) = E_0 + sum_(n=1)^(+ infinity) E_n cos(2 pi n f t + phi_n)$ (décomposition de Fourier)

On a $E_0$ la *valeur moyenne* du signal et les $E_k cos(2 pi k f t + phi_k)$ sont appelés les *harmoniques*. La première harmonique, $E_1 cos(2 pi f t + phi_1)$ est appelée *le fondamental*.

Donner le spectre en amplitude c'est fournir les valeurs des $E_n$

#todo(text: ([Spectre en amplitude]))

== Réponse fréquentielle d'un quadripole

Un *quadripôle* est un circuit électrique comportant 2 bornes d'entrée et 2 bornes de sortie. On impose dans ce cours des dipôles linéaires, d'être en sortie ouverte donc l'intensité sortante est nulle.

On a la *réponse fréquentielle*, $e(t) = E cos(omega t)$ et on étudie $s(t)$ en régime établi.

Dans un quadripole linéraire, $e$ et $s$ sont liés par une équation différentielle, et $e$ étant sinusoïdale, les impédances sont autorisées dans ce cadre.

#theorem([Filtre],[
  Un *filtre* est caractérisé par la *fonction de transfert* complexe $underline(H) = underline(s)/underline(e)$
])

On a $underline(H) = (underline(S) cancel(e^(j omega t)))/(underline(E) cancel(e^(j omega t))) = (underline(S))/(underline(E))$, et $underline(H)$ est adimensionné.

On a $underline(H) = (P(j omega))/(Q (j omega))$, avec $P, Q in CC[X]$, et le filtre est de l'*ordre* du degré de Q.

#theorem([Gain], [
  Le *gain* du filtre est défini par $abs(underline(H)) = abs(underline(S)/underline(E)) = S/E$, et la connaissance du gain renseigne sur le rapport des amplitudes de l'entrée et de la sortie.
])

#theorem([Déphasage], [
  On a $arg(underline(H)) = phi_s - phi_e$
])

#demo([
  On a $arg(underline(H)) = arg(underline(S)/underline(E)) = arg((S e^(j phi_s))/(E e^(j phi_e))) = arg(e^(j(phi_s - phi_e))) = phi_s - phi_e$
])

Donc l'argument de $underline(H)$ nous renseigne sur le déphasage entre la sortie et l'entrée.

== Filtre d'ordre 1

#theorem([Filtre ordre 1],[
  Dans un *filtre du premier ordre*, on a $underline(H) = (a_0 + a_i j omega)/(b_0 + b_i j omega)$
])

Pour trouver $underline(H)$ on peut faire une équation différentielle ou les impédances $CC$.

On peut ensuite mettre $underline(H)$ sous forme canonique, ainsi $underline(H) = (...)/(1 + j omega/omega_0)$ avec $omega_0$ la *pulsation caractéristique du filtre*.

Pour étudier un filtre :
- On regarde d'abord son comportement BF/HF avec les dipôles équivalents pour les bobines et condensateurs. Si on a $u = cases(0 "en BF", e "en HF")$ on a un *passe-haut* sinon si $u = cases(e "en BF", 0 "en HF")$ on a un *passe-bas*.

#warning([*On est en HF si $omega >> omega_0 <==> 2 pi f >> 2 pi f_0 <==> f >> f_0$*])

- On regarde ensuite le gain $abs(underline(H))$ en BF et HF en négligeant $omega/omega_0$ ou $omega_0/omega$ selon le cas.

#theorem([Gain en décibel],[
  On a le *gain en décibel* $G_unit("dB") = 20 log_10 (abs(underline(H)))$, l'échelle log étant plus adaptée car à chaque facteur $times 10$ on a $plus.minus 20k$
])

On a la *pulsation de coupure* à $-3 unit("dB")$ telle que $G_unit("dB") = - 3 unit("dB")$

La *bande passante du filtre* à $-3 unit("dB")$ sont les $omega$ tels que $G_unit("dB")(omega) >= G_(unit("dB") max) - 3 unit("dB")$

On peut retrouver ces valeurs avec $abs(underline(H))$, en effet $abs(underline(H))(omega_c) = abs(underline(H))_max/sqrt(2)$

On a la *largeur de la bande passante*, $Delta omega = max(omega) - min(omega)$ avec $omega$ dans la bande passante.

Dans un filtre du premier ordre, $omega_c = omega_0$ et $Delta omega = omega_0$

#align(center, 
  table(
    columns: 4,
    align: center + horizon,
    [Type],
    [Transmittance],
    [Pulsation de coupure],
    [Gain],
    [Passe-bas (ordre 1)],
    [$ 1/(1 + j omega/omega_0) $],
    [$ omega_0 $],
    [$ 1/sqrt(1 + (omega/omega_0)^2) $],
    [Passe-haut (ordre 1)],
    [$ (j omega/omega_0)/(1 + j omega/omega_0) $],
    [$ omega_0 $],
    [$ 1/sqrt(1 + (omega/omega_0)^2) $]
  )
)

On peut tracer les *diagrammes de Bode* en fonction de $omega/omega_0$ pour le gain et le déphasage, et observer un comportement intégrateur ou dérivateur.

On a un comportement intégrateur dans le cas d'un passe-bas et dérivateur dans le cas d'un passe-haut.

== Filtre d'ordre 2

Seul le filtre passe-bande d'ordre 2 est au programme

#theorem([Transmittance passe-bande],[
  Dans un *filtre passe-bande d'ordre 2*, on a $underline(H) = 1/(1 + j Q (omega/omega_0 - omega_0/omega))$
])

On retrouve $Q$ le facteur de qualité.

Comme son nom l'indique, le filtre passe-bande laisse passer une bande de fréquences autour de $omega_0$.

#theorem([Lien pulsation coupure et facteur de qualité],[
  On a $omega_0/(Delta omega_c) = Q$
])

Ainsi si $Q$ est grand, la bande passante est étroite, et si $Q$ est petit, la bande passante est large.

Les résultats suivants sont hors programme mais peuvent être utiles :

#align(center,
  table(
    columns: 3,
    align: center + horizon,
    [Type],
    [Transmittance],
    [Pulsation de coupure],
    [Passe-bande (ordre 2)],
    [$ 1/(1 + j Q (omega/omega_0 - omega_0/omega)) $],
    [$ omega_0 $],
    [Passe-bas (ordre 2)],
    [$ 1/(1 + j omega/omega_0 - (omega/(Q omega_0))^2) $],
    [$ omega_0 $],
    [Passe-haut (ordre 2)],
    [$ (-(omega/omega_0)^2)/(1 + j omega/omega_0 - (omega/(Q omega_0))^2) $],
    [$ omega_0 $],
    [Réjecteur de bande],
    [$ (1 + (omega/(omega_0))^2)/(1 + j omega/omega_0 - (omega/(Q omega_0))^2) $],
    [$ omega_0 $]
  )
)

#warning([
  On remarquera que la forme canonique a toujours un $1$ au dénominateur
])

#pagebreak()

#counter(heading).update(0)

#set heading(numbering: "🎶 I.1.a")

#box(height: 1em)
#align(center, text([🎶 Ondes], weight: 800, size: 24pt))

#heading([Introduction aux ondes], supplement: [waves])

== Définition et exemples

Une *onde progressive* est une perturbation du champ qui se propage de proche en proche sans transport global de matière mais avec transport global d'énergie.

Une one est dit *transverse* si si la perturbation est orthogonale au sens de propagation

#graph(funcs: ((x) => {
    return calc.sin(x)+ 0.3* calc.cos(20 * x)
  },), domain: (0, 6))

Une onde est dite *longitudinale* si cette perturbation est dans le même sens que la direction de propagation

#graph(funcs: ((x) => {
    return calc.sin(x *(1-0.001*x))
  },), domain: (0, 200))

#theorem([Onde mécanique],[
Une *onde mécanique* est une onde qui a besoin d'un milieu matériel pour se propager
  ])

On se limitera à la description de la propagation des ondes dans un milieu illimité, non dispersif et transparent :
- *Illimité* : On néglige les effets de bord
- *Non dispersif* : La vitesse ne dépend pas de la longueur d'onde
- *Transparent* : Pas de perte d'énergie de l'onde vers le milieu

Ondes accoustiques :

- Sons audibles : $20 - 20000 unit("Hz")$
- Téléphonie : $300 - 3400 unit("Hz")$
- La3 par un diapason : $440 unit("Hz")$

Ondes électromagnétiques :

- WiFi : $2.4 - 5 unit("GHz")$
- Lumière visible : $400 - 800 unit("THz")$ ($num("4e14") - num("8e14") unit("Hz")$)
- Radio FM : $88 - 108 unit("MHz")$

== Célérité, couplage temps/espace

Dans les conditions d'études, une onde unidimensionnelle se propage en se translatant

On a une onde qui se déplace de la manière suivante, en #text("bleu", fill: blue) en $t_0$ et en #text("rouge", fill: red) en $t_1 > t_0$

#graph(funcs: ((x) => {
  if (x == 0) {
    return 0
  }

  if (x < 0.2) {
    return 1
  } else if (x < 0.4) {
    return 4 * (x + 0.2) - 0.6
  } else if (x < 0.665) {
    return - 3 * (x + 0.2) + 3.6
  } else {
    return 1
  }
},(x) => {
  if (x == 0) {
    return 0
  }

  if (x < 0.4) {
    return 1
  } else if (x < 0.6) {
    return 4 * x - 0.6
  } else if (x < 0.865) {
    return - 3 * x + 3.6
  } else {
    return 1
  }
}), domain: (0,1), width: 100%, x_axis: $t$)

On notera qu'un graphe en fonction de $t(y)$ donnera une symétrie par rapport à l'axe des ordonnées de l'onde.

#theorem([Forme de l'onde planaire],[
  Dans le cas d'une onde planaire on a : $ s(x, t) = F(x plus.minus v t) $

avec $v$ la *célérité de l'onde* et $F$ dépendant  de la forme de l'onde.

Si l'onde se déplace vers les $x$ croissants on a $x - v t$ et si $x$ se déplace vers les $x$ décroissants on a $x + v t$
])

Dans le cas *sphérique isotrope* (onde émise dans toutes les directions), on a $s(d, t) = A(d) times F(d - v t)$

== Ondes planes progressives harmoniques

Une onde *plane* est une onde 3D mais ne nécessitant qu'une seule dimension pour être décrite un plan $P(x,t)$.

Une onde est dite *harmonique* lorsque $P(x,t) = P_0 cos(k (x plus.minus v t) + phi) = P_0 cos(k x plus.minus omega t + phi)$

Le $k$ est appelé *vecteur d'onde* et est de dimension $unit("r L^-1")$ et $k = (2 pi)/lambda$

#theorem([Relations avec $k$],[
  On a $T = lambda/v$, $f = v/lambda$ et $omega = k v$
])

Une onde harmonique possède une double périodicité : spatiale de longueur d'onde $lambda$ et temporelle de périodicité de période $T$.

#theorem([Vitesse de phase],[
  On a $v = omega/k$, dans notre cas c'est la célérité.
])

La *surface d'onde* est le lieu des points qui sont dans le même état vibratoire (dans une onde harmonique c'est le lieu des points qui ont la même phase).

== Puissance d'une onde

On définit la *puissance surfacique moyenne d'une onde*, $P_"surf" = k expval(s^2)$

On définit aussi la *quantité moyenne d'énergie par unité de temps* qui traverse cette surface, $P = integral.double_"surface" P_"surf" dd(s)$

Pour une onde plane se déplaçant vers les $x$ croissants, on a $P_"surf" = k S_0^2/2$

#demo([
  Soit $s(x,t) = cos(omega t - x t + phi)$, ainsi $P_"surf" = k expval(S_0^2 cos^2(...)) = k S_0^2/2$
])

Dans un volume d'espace, $P_"entrante" = P_"sortante"$

#demo([
 $P_"entrante" = k S_e^2/2$ et 
 $P_"sortante" = k S_s^2/2$ or $S_e = S_s$ dans ce cours d'où $P_"entrante" = P_"sortante"$
])

De même, dans un milieu sphérique isotrope, on a $P_"entrante" = P_"sortante" = P_"source"$

#demo([
  $P_"entrante" = P_"source"$ et $P_"sortante" = P_"surf" times 4 pi R^2$ et puisqu'il n'y a pas d'absorption et de stockage, $P_"entrante" = P_"sortante" = P_"source"$
])

De plus, on a $S = C/R$ avec $R$ le rayon du cercle considéré

== Spectre d'une onde périodique

On considère $s(0, t) = S_0 + sum_(m=1)^(+ infinity) S_m cos(m omega t + phi_m)$ comme dans le cours d'optique

#theorem([Principe de superposition],[
  Dans un milieu linéaire, l'onde totale qui résulte de plusieurs ondes est la somme des ondes
])

De plus on a la *relation de dispersion* entre $k_omega$ et $m_omega$, $m_omega = k_m c$

== Ordre de grandeur

On a $lambda = 10^-6 unit("m")$ pour les ondes lumineuses, $f = 10^14 unit("Hz")$ et $omega = 10^15 unit("r/s")$

Le spectre de l'audible est de $20 unit("Hz")$ à $20 unit("kHz")$ et le spectre des ondes radio est de $10 unit("kHz")$ à $10 unit("GHz")$

#box(height: 1em)
#heading([Diffraction/Interférences], supplement: [waves])

La *diffraction* et les *interférences* sont deux principes intrinsèques aux ondes qui ne dépendent pas de leur nature.

== Diffraction

La *diffraction* se fait selon le schéma suivant :

#figure(image("physics/waves/diffraction.png", width: 50%))

#theorem([Critère de diffraction],[
  On a le *critère de diffraction* $lambda/a$ (addimensionné) :

  - Si $a < lambda/2$ il ne se passe rien
  - Si $lambda approx a$, on a une onde circulaire avec la même pulsation et la même longueur d'onde
  - Si $a > "qq" lambda$ on a une onde restreinte angulairement
  - Si $a >> lambda$ l'onde n'est pas diffractée
])

#theorem([Formule de la diffraction],[
  Si $lambda <= a$, l'onde est contrainte dans un secteur angulaire d'un demi angle au sommet $theta$ tel que $sin(theta) approx lambda/a$
])

== Interférences

Les interférences résultent d'une superposition de plusieurs ondes selon le principe de superposition.

Les *interférences* se font selon le schéma suivant :

Les zones noires sont appelées *inteférences destructives* et les zones blanches sont appelées *interférences constructives*.

#figure(image("physics/waves/interferences.png", width: 30%))

L'*intensité* d'une onde est la puissance surfacique.

On a la représentation complexe d'une onde, $s = S cos(omega t + phi(M))$ d'où $underline(s) = S exp^(j(omega t + phi(M)))$

#theorem([Formule de Fresnel],[
  On a la *formule des interférences* ou *de Fresnel* en considérant 2 ondes harmoniques de même pulsation :
  $ I = I_1 + I_2 + 2sqrt(I_1 I_2) cos(phi_1(M) - phi_2(M)) $
])

#demo([
  On a $underline(s) = underline(s_1) + underline(s_2)$ d'où $S^2 = abs(underline(u))^2 = (underline(s_1) + underline(s_2))(underline(s_1)^* + underline(s_2)^*) = underline(s_1) underline(s_1)^* + underline(s_2) underline(s_2)^* + underline(s_1) underline(s_2)^* + underline(s_1)^* underline(s_2)$

  Et $S_1 e^(j(omega t - phi_1)) S_2 e^(-j(omega t - phi_2)) + S_1 e^(-j(omega t - phi_1)) S_2 e^(j(omega t - phi_2)) = S_1 S_2 [e^(j(phi_1 - phi_2)) + e^(-j(phi_1 - phi_2))] = 2 S_1 S_2 cos(phi_1 - phi_2)$

  D'où $S^2 = S_1^2 + S_2^2 + 2 S_1 S_2 cos(phi_1 - phi_2)$ 
  
  Soit $k/2 S^2 = k/2 S_1^2 + k/2 S_2^2 + 2 (sqrt(k/2) S_1) (sqrt(k/2) S_2) cos(phi_1 - phi_2)$

  Donc on a bien $I = I_1 + I_2 + 2sqrt(I_1 I_2) cos(phi_1- phi_2)$
])

On remarque donc bien que si $I_1=I_2=I_0$, on a $I = 2I_0 (1+ cos(Delta phi))$

Si les deux ondes sont en phase, on a $cos(Delta phi) = 1$ d'où $I = I_1 + I_2 + 2 sqrt(I_1 I_2)$ ou encore $I = 4I_0$ sous les hypothèses précédentes. On dit dans ce cas qu'on a des *inteférences constructives*.

Si les deux ondes sont opposition en phase, on a $cos(Delta phi) = -1$ d'où $I = I_1 + I_2 - 2 sqrt(I_1 I_2)$ ou encore $I = 0$ sous les hypothèses précédentes. On dit dans ce cas qu'on a des *inteférences destructives*.

On définit la *différence de marche* $delta(M) = d_2(M) - d_1(M)$ la différence de chemin optique entre les deux ondes.

De même on a des interférences constructives si $Delta phi = 2 k pi$ ou $delta(M) = k lambda$ (différence de marche) et des interférences destructives si $Delta phi = (2 k + 1) pi$ ou $delta(M) = (2 k + 1) lambda/2$

#todo(text:[(Voir pour expliciter les expressions des trous d'Young + interfrange)])

#theorem([Interfrange],[
  On a l'*interfrange* $i = (lambda d)/a$ l'espacement entre deux interférences constructives
])

#box(height: 1em)
#heading([La lumière onde], supplement: [waves])

== Généralités

Dans le point de vue ondulatoire, la lumière est une onde se déplaçant à $qty("299792458","m/s")$

La plupart des diélectriques suivent la *loi de Cauchy*, $n(lambda) = A + B/lambda^2$, $A>0$ dépendant du matériau et $B$ dépendant du diélectrique

On parle de *diélectrique dispersent* une dispersion de la lumière avec $lambda$ dans le prisme arc-en-ciel.

Souvent on fera l'hypothèse que cette dispersion est négligeable.

== Modèle scalaire

La lumière est une onde scalaire $(arrow(E), arrow(B))$ (3D) mais on se place en 1D en disant que la lumière est de forme $s(x, y,z,t)$

Dans le cas d'un milieu homogène et d'une onde plane harmonique avec $lambda_0$ la longueur d'onde dans le vide on a $lambda = lambda_0/n$ et $k = (2 pi)/lambda = (2 pi)/lambda_0 n$

#demo([
  Le milieu est linéaire, d'òu on a $omega_"vide" = omega_"diélectrique" = omega$ avec $omega = c k_0 = c (2 pi)/lambda_0$ dans le vide et $omega = c/n k = c/n (2 pi)/lambda$

  Ainsi $c/n (2 pi)/lambda = c (2 pi)/lambda_0$ d'où $n lambda = lambda_0$ soit $lambda = lambda_0/n$
])

Dans un milieu homogène, le *chemin optique* est $L_"AB" = n x$

#theorem([Expression générale du chemin optique],[
Dans un milieu inhomogène, le chemin optique est $L_"AB" = integral_A^B n dd(l)$
])

#theorem([Retard de phase],[
  On a le *retard de phase* entre $A$ et $B$ noté $Delta phi = (2 pi)/lambda_0 L_"AB"$
])

#demo([
  On a $Delta phi = (Delta t)/T times 2 pi = 1/(c T) times L_"AB" = (2 pi)/lambda_0 L_"AB"$ car $c T = lambda_0$
])

== Diffraction

Il est possible de retrouver la nature de l'objet diffractant avec la forme de la figure de diffraction

Pour un objet rectangulaire le caractère diffractant est d'autant plus marqué que le côté est proche de $lambda$

On observe une *tache d'Airy* lorsque l'on fait passer un laser dans une fente

#figure(image("physics/waves/airy.jpg", width: 30%))

== Interférences

On peut refaire l'expérience des trous de Young en lumière monochromatique :

#figure(image("physics/waves/young.jpg", width: 50%))

Il est aussi possible de la faire en lumière blanche, on observe que plus on s'éloigne du point central, plus les couleurs disparaissent car aucune longueur d'onde ne sera majoritaire

#counter(heading).update(0)

#pagebreak()

#set heading(numbering: "🔧 I.1.a")

#align(center, text([🔧 Mécanique], weight: 800, size: 24pt))

#box(height: 1em)
#heading([Cinématique du point], supplement: [meca])

== Généralités

Un *solide indéformable* est un système matériel $Sigma$ tel que $forall M_1, M_2 in Sigma$, $norm(arrow(M_1 M_2))$ est constant dans le temps.

Un *point matériel* est un solide indéformable donc on néglige la taille et les mouvements de rotation sur lui même.

Pour un point il faut 3 infos sur sa position, et pour un solide il faut 3 infos en plus : celles sur sa rotation.

Pour décrire l'état mécanique d'un système il faut connaître 3 vitesses pour un point, et pour un solide il faut en plus connaître 3 vitesse angulaires.

La *cinématique* est l'étude des mouvements sans se préoccuper des causes.

== Observateur, repère, référentiel

On a besoin de 3 informations spatiales et 1 information temporelle pour décrire un mouvement.

Un *repère* est composé d'une origine, de 3 axes et d'une unité de longueur (souvent le mètre).

Le *mètre* est défini par la distance parcourue par la lumière dans le vide en $1/299792458 unit("s")$

L'observateur est lui muni d'une unité de temps, souvent la seconde.

La *seconde* est définie par la durée de 919263177 périodes de la radiation correspondant à la transition entre les deux niveaux hyperfins de l'état fondamental de l'atome de césium 133.

#theorem([Référentiel],[
  Un *référentiel* est un repère d'espace et de temps
])

On se place dans le contexte de la relativité galiléenne, le temps est absolu et l'espace est absolu (pas vrai en général).

== Position, vitesse, accélération

#theorem([Position],[
  Soit $O$ l'origine et $M$ un point matériel, ainsi *vecteur position* est $arrow(O M)$
])

Le *vecteur déplacement élémentaire* est $dd(arrow(O M)) = arrow(M(t) M(t + dt))$

#theorem([Vitesse],[
  La *vitesse* est la dérivée de la position par rapport au temps, $arrow(v) = ddt(arrow(O M))$
])

Le vecteur vitesse est tangent à la trajectoire.

#theorem([Accélération],[
  L'*accélération* est la dérivée de la vitesse par rapport au temps, $arrow(a) = ddt(arrow(v)) = dv(arrow(O M),t,2)$
])

On dit qu'un mouvement est *rectiligne* si la trajectoire est une droite, *circulaire* si la trajectoire est un cercle, *curviligne* si la trajectoire est une courbe.

De plus le mouvement est *uniforme* si la vitesse est constante, *accéléré* si la vitesse augmente, *décéléré* si la vitesse diminue.

=== Coordonnées cartésiennes

#figure(image("physics/meca/coord_carte.svg", width: 30%))

#theorem([Coordonnées cartésiennes],[
  On a : $ arrow(O M) = x ex + y ey + z ez $

  $ dd(arrow(O M)) = dd(x) arrow(e_x) + dd(y) arrow(e_y) + dd(z) arrow(e_z) $

  $ arrow(v) = dot(x) arrow(e_x) + dot(y) arrow(e_y) + dot(z) arrow(e_z) $

  $ arrow(a) = dot.double(x) arrow(e_x) + dot.double(y) arrow(e_y) + dot.double(z) arrow(e_z) $
])

=== Coordonnées cylindriques

#figure(image("physics/meca/coord_cylin.svg", width: 30%))

#theorem([Coordonnées cylindriques],[
  On a : $ arrow(O M) = arrow(O m) + arrow(m M) = r er+ z ez $

  $ dd(arrow(O M)) = dd(r) er + r dd(theta) et + dd(z) ez $

  $ arrow(v) = dot(r) er + r dot(theta) et + dot(z) ez $

  $ arrow(a) = (dot.double(r) - r dot(theta)^2) er + (2 dot(r) dot(theta) + r dot.double(theta)) et + dot.double(z) ez $
])

#demo([
  On a $er = cos(theta) ex + sin(theta) ey$ d'où $ddt(er) = ddt(cos(theta(t)) ex) + ddt(sin(theta(t)) ey) = -sin(theta(t)) dot(theta) ex + cos(theta(t)) dot(theta) ey = dot(theta) et$

  D'où $ddt(er) = dot(theta) et$ et $ddt(et) = - dot(theta) er$

  Ainsi on a $arrow(v) = ddt(arrow(O M)) = dot(r) er + r dot(theta) et + dot(z) ez$

  De plus on a $arrow(a) = ddt((dot(r) er + r dot(theta) et) + dot(z) ez)$

  Avec $ddt(dot(r) er) = dot.double(r) er + dot(r) dot(theta) et$ et $ddt(r dot(theta) et) = dot(r) dot(theta) et + r dot.double(theta) et - r dot(theta)^2 er$

  D'où $arrow(a) = (dot.double(r) - r dot(theta)^2) er + (2 dot(r) dot(theta) + r dot.double(theta)) et + dot.double(z) ez$
])

La composante $r er$ est la composante radiale et $z ez$ est la composante axiale.

=== Coordonnées sphériques

#figure(image("physics/meca/coord_spher.svg", width: 30%))

On appelle $phi$ la longitude et $theta$ la colatitude

#theorem([Coordonnées sphériques],[
  On a : $ arrow(O M) = r er + theta et + phi ep $

  $ dd(arrow(O M)) = dd(r) er + r dd(theta) et + r sin(theta) d(phi) ep $

  $ arrow(v) = dot(r) er + r dot(theta) et + r sin(theta) dot(phi) ep $

  La formule de l'accélération n'est pas à connaître
])

=== Base de Frenet

On a la *base de Frenet* pour les abscisses curvilignes.

On considère le *cercle osculateur*, c'est à dire le cercle qui approxime le mieux la courbe en un point.

#theorem([Base de Frenet],[
  Avec $arrow(tau)$ le *vecteur unitaire tangent* et $arrow(n)$ le *vecteur unitaire normal* au cercle osculateur, on a :

  $ arrow(a) = v^2/r arrow(n) + ddt(v) arrow(tau) $
])

== Description de quelques mouvements

=== Mouvement uniforme 1D

On est à vitesse constante, ainsi $arrow(v) = ddt(x) ex$ d'où en intégrant on a $x = norm(arrow(v)) t + x_0$

=== Mouvement circulaire uniforme

Dans un mouvement circulaire uniforme on a $r$ fixé, donc avec $arrow(v) = cancel(dot(r) er) + r dot(theta) et$ d'où $norm(arrow(v)) = r dot(theta)$ donc $theta(t) = omega t + theta_0$

#box(height: 1em)
#heading([Dynamique du point], supplement: [meca])

En dynamique on s'intéresse aux causes des mouvements contrairement à la cinématique.

== Masse, centre de masse, quantité de mouvement

L'*inertie* est la résistance d'un corps à une variation de son état de mouvement.

La *masse* en physique est une mesure de l'inertie d'un corps, elle s'exprime en kilogramme ($unit("kg")$), est extensive et additive.

On appelle *centre de masse* le point où l'on peut assimiler la masse du système à une masse ponctuelle, et on note $G$ le centre de masse (aussi appelé barycentre). On a $arrow(O G) = 1/M sum m_i arrow(O_i G_i)$

#theorem([Quantité de mouvement],[
  La *quantité de mouvement* est le produit de la masse par la vitesse, $arrow(P) = m arrow(v)$
])

La vitesse d'un système de points est la vitesse du centre de masse.

Une *force* décrit une intéraction pour modifier l'état de mouvement (c'est à dire la quantité de mouvement) d'un point matériel. On note $arrow(F)_(a -> b)$ l'action de $a$ sur $b$. Une force est une grandeur vectorielle, s'exprime en Newton ($unit("N")$), est extensive et additive.

== Les lois de Newton

=== 1ère loi de Newton

Un *système isolé* est un système qui n'échange pas de quantité de mouvement avec l'extérieur.

Un *système pseudo-isolé* est un système qui échange de la quantité de mouvement avec l'extérieur mais dont la somme des forces extérieures est nulle (la résultante des forces extérieures est nulle).

#theorem([Principe d'intertie],[
  Il existe une classe de référentiels dits d'*inertie* ou *galiléens* dans lesquels un système isolé ou pseudo-isolé est à l'équilibre ou en mouvement rectiligne uniforme.
])

2 référentiels galiléens sont en translation rectiligne uniforme l'un par rapport à l'autre.

On a les référentiels de référence suivants :

- *Héliocentrique* : Le point fixe est le centre de masse du soleil, et les 3 axes pointent vers des étoiles fixes. Il est supposé galiléen.

- *De Copernic* : Le point fixe est le centre de masse du système solaire, et les 3 axes pointent vers des étoiles fixes. Il est supposé galiléen.

- *Géocentrique* : Le point fixe est le centre de la Terre, et les 3 axes pointent vers des étoiles fixes. Il est supposé galiléen sur des $t << 1$ an.

- *Terrestre* : Le point fixe est accroché à la surface terrestre et les trois axes sont fixes à la surface terrestre. Il est supposé galiléen sur des $t << 1$ j.

=== 2ème loi de Newton

#theorem([Principe fondamental de la dynamique (PFD)],[
  Dans un référentiel galiléen, un point matériel vérifie $ddt(arrow(P)) = sum arrow(F)$, ainsi la résultante des forces est égale à la dérivée de la quantité de mouvement.

  A $m$ constante, on a $m arrow(a) = sum arrow(F)$ et dans un système isolé ou pseudo-isolé, $m arrow(a) = 0$
])

=== 3ème loi de Newton

#theorem([Principe des actions réciproques],[On a $arrow(F)_(A -> B) = - arrow(F)_(B -> A)$])

== Méthode de résolution des exercices

Pour résoudre un exercice on suit les étapes suivantes :

1. On fait un grand schéma avec le répère et la/les base(s)

2. On définit le système étudié, le référentiel d'étude et on précise le caractère galiléen.

3. On fait un *bilan des actions mécaniques externes* (BAME) et on le fait apparaître sur le schéma

4. On fait l'exercice

== Forces à connaître

=== Poids

On considère un corps de masse $m$ plongé dans un champ gravitationnel $arrow(g)$

#theorem([Poids],[
  On a $arrow(P) = m arrow(g)$ le *poids* s'appliquant sur le corps
])

=== Poussée d'Archimède

On considère un corps plongé dans un fluide de masse volumique $rho_f$ et un champ de pesanteur $arrow(g)$

#theorem([Poussée d'Archimède],[
  On a $arrow(Pi) = -rho_f V arrow(g)$ avec $V$ le volume déplacé valide si et seulement si le fluide est à l'équilibre en l'absence du corps
])

Il ne faut pas hésiter à la négliger si $rho_"corps" >> rho_f$

=== Réaction d'un support

La réaction du support est une force au contact, avec $arrow(R_n)$ la composante normale (toujours vers l'extérieur) et $arrow(R_t)$ la composante tangentielle (Spé), nulle en l'absence de frottements solides.

On n'a pas de formule pour $arrow(R_n)$

=== Tension d'un fil inextensible

On a $arrow(T)$ dirigé vers le fil, avec le point d'application au contact système/fil, si le fil n'est pas tendu on a $arrow(T) = 0$

On n'a pas de formule pour $arrow(T)$

On peut retrouver l'équation différentielle d'un pendule avec cette force

=== Force de rappel élastique (loi de Hooke)

Un ressort applique une force qui s'oppose à la déformation

#theorem([Force de rappel élastique],[
  On a $arrow(F) = k(l - l_0) arrow(u)$ avec $k$ la *constante de raideur* du ressort et $l_0$ sa *longueur à vide*, et $arrow(u)$ est un vecteur unitaire à déterminer avec précision (pour garantir l'opposition à la déformation).
])

La constante de raideur s'exprime en $unit("N/m")$, plus $k$ est grand plus il est compliqué déformer le ressort.

=== Force de frottement

On a 2 types de frottements

#theorem([Frottements fluides linéaires],[
  On a $arrow(F_f) = - alpha arrow(v)$ qui s'opposent à la vitesse
])

Il existe aussi les frottements quadratiques, pour des vitesses plus élevées modélisés par $arrow(F_f) = - beta arrow(v)^2$

== Intéractions à connaître

=== Intéraction gravitationnelle

On considère 2 points massifs

#theorem([Force d'intéraction gravitationnelle],[
  On a $arrow(F) = - cal(G) (m_1 m_2)/d^2 arrow(u)$ avec $cal(G) = qty("6.7e-11","m^3/kg/s^2")$ la constante de pesanteur
])

=== Intéraction coulombienne

On considère 2 particules chargées

#theorem([Force d'intéraction coulombienne],[
  On a $arrow(F) = 1/(4 pi epsilon_0) (q_1 q_2)/d^2 arrow(u)$ avec $epsilon_0 = qty("8.9e-11","F/m^1")$ la permitivité diélectrique du vide
])

#box(height: 1em)
#heading([Énergétique du point], supplement: [meca])

== Travail et puissance d'une force

#theorem([Travail élémentaire],[
  Soit $M$ un point matériel se déplaçant de $dd(O M)$ en $dd(t)$, on a $delta W = arrow(F) dot dd(arrow(O M))$
])

Si $delta W > 0$, on dit que $arrow(F)$ est *motrice*, si $delta W < 0$, on dit que $arrow(F)$ est *résistante* et si $delta W = 0$, $arrow(F)$ ne *travaille pas*.

Si $A$ est un état initial et $B$ un état final on a $W_(A -> B) = integral_"chemin" delta W$

On note que si $arrow(F)$ est constante on a $W = arrow(F) dot arrow(A B)$

On a pour le poids $W_p = - m g h$

#demo([
  On a $delta W = arrow(F) dot dd(arrow(O M)) = (- m g ez) dot (dd(x) ex + dd(y) ey dd(z) ez) = -m g ez$

  D'où $W = integral_a^b delta W = -m g(z_b-z_a)$
])

#theorem([Puissance d'une force],[
  On a la puissance d'une force, $P = arrow(F) dot arrow(v)$ d'où $delta W = P dd(t)$
])

#demo([
  On a $delta W = arrow(F) dot dd(arrow(O M)) = arrow(F) dot ddt(arrow(O M)) dd(t) = P dd(t)$
])

== Théorème de l'énergie cinétique

#theorem([Énergie cinétique],[
  On a l'*énergie cinétique*, $cal(E)_c = 1/2 m v^2$
])

#theorem([Théorème énergie cinétique],[
  Dans un référentiel galiléen on a :
  $ Delta cal(E)_c = sum W_arrow(F)_"ext" $
])

#theorem([Théorème puissance cinétique],[
  On a $ ddt(cal(E)_c) = sum P_"ext" $
])

#demo([
  Par PFD on a $m ddt(arrow(v)) = sum arrow(F)_"ext"$ d'où $m ddt(arrow(v)) dot arrow(v) = sum arrow(F)_"ext" dot arrow(v)$, ainsi on a $ddt((1/2 m v^2)) = sum P_"ext"$ donc on a $dd((1/2 m v^2)) = sum P_"ext" dd(t)$ donc en intégrant $Delta cal(E_c) = sum W_arrow(F)_"ext"$
])

== Force conservative, énergie potentielle

Une force est dit *conservative* si son travail ne dépend pas du chemin parcouru

On a $cal(E)_p$ l'*énergie potentielle*, et est définie à une constante près.

#theorem([Énergies potentielles à connaître],[
  Une force conservative admet une énergie potentielle :

  - Pour le poids, $cal(E)_(p p) = m g h$ (appelée *énergie potentielle de pesanteur*), avec un $-$ devant si $ez$ est descendant

  - Pour le rappel élastique, $cal(E)_p = k/2 (l - l_0)^2$

  - Pour la gravitation, $cal(E)_p = - cal(G) (m_1 m_2)/d$

  - Pour la force coulombienne, $cal(E)_p = (q_1 q_2)/(4 pi epsilon_0 d)$
])

#demo([
  On a $delta W = arrow(F) dot dd(arrow(O M)) = (k(l - l_0) arrow(u)) dot dd(arrow(O M))$

  D'où $arrow(u) dot (dd(arrow(O M)_r) + dd(arrow(O M)_t)) = arrow(u) dot arrow(u) dd(l) = dd(l)$

  Donc on a $delta W = - k (l - l_0) dd(l) = - dd((k/2 (l-l_0)^2))$ d'où $cal(E)_p = k/2 (l - l_0)^2$
])

Les forces de frottement ne sont pas conservatives.

#theorem([Relation $dd(cal(E)_p)$/$delta W$],[
  On a $delta W = - dd(cal(E)_p)$
])

Un système est dit *conservatif* si toutes les forces sont conservatives

#theorem([Relation $cal(E)_p$/$arrow(F)$],[

  On a $arrow(F) = dv(cal(E)_p,O M) arrow(O M)$
])

== Théorème de l'énergie mécanique

#theorem([Énergie mécanique],[
  On a l'*énergie mécanique*, $cal(E)_m = cal(E)_c + cal(E)_p$
])

#theorem([Théorème énergie mécanique],[
  Dans un référentiel galiléen on a :
  $ Delta cal(E)_m = sum W_arrow(F)_"ext non conservatives" $
  avec $arrow(F)$ les *forces non conservatives*
])

#demo([
  On a $Delta cal(E)_c = sum W_arrow(F)_"ext" = sum W_arrow(F)_"ext non conservatives" + sum W_arrow(F)_"ext conservatives"$

  Or $W_arrow(F)_"ext conservative" = integral delta W = integral -dd(cal(E)_p) = - Delta cal(E_p)$

  D'où $Delta cal(E)_c = sum W_arrow(F)_"ext non conservatives" - Delta cal(E_p)$ donc on a bien 
  $Delta cal(E)_m = sum W_arrow(F)_"ext non conservatives"$
])

== Graphe d'énergie potentielle

On se place dans des systèmes qui évoluent en 1D, on peut tracer la courbe suivante :

#graph(funcs: ((x) => {
  if (x > 17) {
    return - 0.001 * x + 0.7 ;
  }

  return 0.5 * calc.cos(1/2 * x) + 1
},), y_axis: $cal(E)_p$, lines: (1,), domain: (0,40))

Un *point de rebroussement* est un point tel que $cal(E)_p (x) = cal(E)_m$, ainsi $cal(E)_c = 0$ d'où $v = 0$, et elle change de signe

Les zones au dessus de la ligne rouge ($cal(E)_m$) sont dites *innaccessibles* car $cal(E)_p > cal(E)_m$ d'où $cal(E)_c < 0$ ce qui est impossible.

On a un *puit de potentiel* si on est coincé entre 2 points de rebroussement, ainsi on est dans un *état lié* et $x$ ne tend pas vers $infinity$

Si on a un seul point de rebroussement, on est en *état libre* et $x$ tend vers $infinity$

On dit que $x_e$ est une *position d'équilibre* si $dv(cal(E)_p,x)(x_e) = 0$ et elle est *stable* si après une petite perturbation une force tend à la ramener à sa position d'équlibre (ou que la courbe est concave)

On a un *potentiel attractif* si $dv(cal(E)_p,x,2) > 0$ et *répulsif* si $dv(cal(E)_p,x,2) < 0$

#box(height: 1em)
#heading([Loi du moment cinématique], supplement: [meca])

== Approche vectorielle

#theorem([Moment cinétique],[
  Soit un point matériel de masse $m$ avec une vitesse $arrow(v)$ en $M$, on a le *moment cinétique* :

  $ arrow(L_A) = arrow(A M) and m arrow(v) $
])

Dans le cas d'un mouvement circulaire, on a $arrow(L_A) = m r^2 dot(theta) ez$

#demo([
  On a $arrow(A M) = r er$ et $arrow(v) = cancel(dot(r) er) + r dot(theta) et$

  Ainsi on a $arrow(L_A) = r er and m r dot(theta) et = m r^2 dot(theta) ez$
])

Le moment cinétique est extensif et additif, de plus $[arrow(L_A)] = unit("m^2  kg /s")$

On a ainsi $arrow(L_A) bot arrow(A M)$ et $arrow(L_A) bot arrow(v)$ d'où $arrow(L_A) = 0$ si $arrow(A M)$ et $arrow(v)$ sont colinéaires.

#theorem([Moment d'une force], [
  Le *moment d'une force* $arrow(F)$ en $C$ sur $A$ est :

  $ arrow(M_A) = arrow(A C) and arrow(F) $
])

Le moment d'une force modélise la capacité de $arrow(F)$ à mettre en relation autour de $A$, et on a $[A] = unit("N m")$

#theorem([Théorème du moment cinétique],[
Dans un référentiel galiléen avec *$A$ fixe* dans le référentiel d'étude, on a $ ddt(arrow(L_A)) = sum arrow(M_A) (arrow(F)_"ext")$
])

#demo([
  On a $ddt(arrow(L_A)) = ddt(arrow(L_O)) = ddt((arrow(O M) and m arrow(v))) = ddt(arrow(O M)) and m arrow(v) + arrow(O M) and m ddt(arrow(v))$

  Donc $ddt(arrow(O M)) and m arrow(v) = arrow(v) and m arrow(v) = 0$ et $arrow(O M) and ddt((m arrow(v))) = arrow(O M) and sum arrow(F)_"ext"$

  D'où $ddt(arrow(L_A)) = arrow(O M) and sum arrow(F)_"ext" = sum arrow(M_O) (arrow(F)_"ext")$
])

== Approche scalaire

Notons $A_u = (A, arrow(u))$ un axe orienté avec $arrow(u)$ un vecteur unitaire.

#theorem([Moment cinétique par rapport à $A_u$],[
  On a le *moment cinétique par rapport à $A_u$* : $ L_A_u = arrow(L_A) dot arrow(u) $
])

#theorem([Moment d'une force par rapport à $A_u$],[
  On a le *moment d'une force par rapport à $A_u$* : $ M_A_u = arrow(M_A) dot arrow(u) $
])

Ainsi $M_A_u (arrow(F))$ ne dépend que de la composante de $arrow(F)$ dans le plan perpendiculaire à $A_u$, d'où la distance $d$ sur le schéma.

On appelle *bras de levier* la distance entre $A$ et la droite d'action de $arrow(F)$

#figure(image("physics/meca/bras-de-levier.svg", width: 40%))

#theorem([Moment de force par bras de levier],[
  On a $M_A_u (arrow(F)) = plus.minus norm(arrow(F)) times "bras de levier"$, avec un $+$ si la force  entraine une rotation dans le sens, et un $-$ sinon.
])

Ainsi si la droite d'action passe par $A$, le bras de levier est nul donc il n'y a pas de mouvement.

#theorem([Théorème du moment cinétique du moment scalaire],[
Dans un référentiel galiléen avec *$A_u$ fixe* dans le référentiel d'étude, on a $ ddt(L_A_u) = sum M_A_u (arrow(F)_"ext") $
])

#demo([Immédiat par produit scalaire])

#box(height: 1em)
#heading([Mouvement dans un champ de force newtonien], supplement: [meca])

Une *force centrale* est une force qui pointe vers/depuis un point fixe du référentiel d'étude.

== Statuer sur le caractère central

On considère un astéroïde ($a$) de masse $m$ et un astre ($A$) de masse $M$, par principe des actions réciproques, on a $norm(arrow(F)_(a -> A)) = norm(arrow(F)_(A -> a))$

Pour savoir qui impose une force centrale sur qui, on regarde le rapport $m/M$

On parle de *force newtonienne* si $arrow(F) = - k/r^2 arrow(u_r)$, et ces forces dérivent d'un potentiel

== Propriétés de mouvement dans un champ de force centrale

#theorem([Conservation de $arrow(L_0) (M)$],[
  Dans le cas des forces centrales, $arrow(L_0) (M)$ se conserve.
])

#demo([
  En effet, on a d'après le TMC, $ddt(arrow(L_0)) = sum arrow(M_O) arrow(F)_"ext" = arrow(M)_O (arrow(F)) = arrow(O M) and arrow(F)$.

  Or $arrow(O M)$ et $arrow(F)$ sont colinéaires d'où $ddt(arrow(L_0)) = 0$ donc $arrow(L_0)$ se conserve
])

Une première conséquence de ce résultat est que $M$ évolue dans le plan orthogonal à $arrow(L_O)$

#demo([
  On a $P bot arrow(L_O)$ et $O in P$ ainsi on a $arrow(L_O) (M) = arrow(O M) and m arrow(v)$

  On a $arrow(O M) bot arrow(L_O)$ d'où $M in P$
])

Une autre conséquence est la *loi des aires*, l'aire balayée pendant $arrow(O M)$ est proportionnelle à $Delta t$

#demo([
  On a $ddt(A)$ l'aire balayée par unité de temps avec une vitresse oréolaire.

  On a $arrow(M(t) M(t + dd(t))) = dd(arrow(O M)) = ddt(arrow(O M)) dd(t) = arrow(v) dt$

  On a $A = norm(arrow(O M) and arrow(v) dt)$ d'où $ddt(A) = 1/2 norm(arrow(L_O) (M))/m$ donc c'est constant
])

#theorem([Constante des aires],[
  Pour réduire la dimension du problème on pose $cal(C) = L_O_z/m = r^2 dot(theta)$ la *constante des aires*. 
])

Le satellite ne change pas de sens de rotation

#demo([
  En effet on a $arrow(L_O) (M) = m r^2 dot(theta) ez$, avec $r^2 >0$, $m>0$ d'où $dot(theta) > 0$
])

== Approche énergétique, cas d'une force conservatrice

On a $cal(C) > 0$ et $dot(theta) > 0$, de plus le système est conservatif d'où la conservation de $cal(E)_m$

On a $cal(E)_m = 1/2 m dot(r)^2 + 1/2 m cal(C)^2/r^2 - cal(G) (M m)/r$ avec $cal(E)_p = 1/2 m cal(C)^2/r^2 - cal(G) (M m)/r$

On constate l'apparition d'un nouveau terme pour l'énergie potentielle : on appelle $cal(E)_(p,"eff") = 1/2 m cal(C)^2/r^2$ l'*énergie potentielle effective*

D'où on a :

#graph(funcs: ((x) => {
  return 2/(2 *calc.pow(x,2)) - 7/x
},), domain: (0.1, 3), x_axis: $r$, y_axis: $cal(E)_(p,"eff")$)

Ainsi selon le rayon du satellite on a une trajectioire libre ou liée.

Le graphe d'$cal(E)_(p,"eff")$ passe par un minimum pour $r = r_0$, dans ce cas la trajectoire est *circulaire*.

Si $cal(E)_m$ > 0, la trajectoire est une hyperbole, si $cal(E)_m$ = 0, la trajectoire est une parabole, et si $cal(E)_m$ < 0, la trajectoire est une ellipse.

Lorsque l'astéroide est au plus proche de l'astre (ou au plus loin) on a $dot(r) = 0$

On parle de *périastre* quand il est au plus proche de l'astre, *périhélie* quand il est au plus près du Soleil, et *périgée* quand il est plus proche de la Terre

De même on parle de *apoastre* quand il est au plus loin de l'astre, *aphélie* quand il est au plus loin du Soleil, et *apogée* quand il est plus loin de la Terre

== Lois de Kepler

#theorem([3 lois de Kepler],[
  Kepler a énoncé les trois lois suivantes :

  1. Les planètes du *système solaire* décrivent des *orbites elliptiques* dont le soleil occupe l'un des foyers

  2. *Loi des aires* (voir plus tôt)

  3. *Loi des périodes*, le rapport $T^2/a^3$ est indépendant de la planète considérée dans le système solaire, avec $a$ le demi-axe de l'ellipse, et dans le cas du système solaire, $T^2/a^3 = (4 pi^2)/(cal(G) M_s)$
])

#todo(text: [(Savoir retrouver $T^2/a^3$, vitesse et Em + vitesse orbite basse et vitesse+  de libération)])

== Jour solaire vs jour sidéral

Un *jour solaire* est un intervalle de temps entre 2 passage au zénith du Soleil, on a $T_s = qty("24", "h") = qty("86400", "s")$

Un *jour sidéral* est la durée pour que la Terre fasse un tour complet dans le référentiel géocentrique, on a $T_"sidéral" = qty("86164", "s") = qty("23","h") qty("56","min") qty("4","s")$

#figure(image("physics/meca/sideral.png", width: 20%))

On a $alpha = (2 pi)/(num("365.25") "jours")$ 

== Satellites géostationnaires

Un satellite est dit *géostationnaire* si il pointe toujours vers le même point de la Terre.

Un satellite géostationnaire est à une altitude de $h = 35786 unit("km")$, a une période de révolution de $T_"sidéral" = qty("86164", "s")$ et a une trajectoire circulaire dans le plan équatorial.

#box(height: 1em)
#heading([Mécanique du solide], supplement: [meca])

== Généralités

Le *référentiel propre* ($cal(R_p)$) est le référentiel dans lequel le solide est immobile

#figure(image("physics/meca/ref_propre.jpg", width: 40%))

Ainsi on a 2 repères : le référentiel d'étude ($cal(R)$) et le référentiel lié (ou propre)

Le repère propre n'est à priori pas galiléen

== Mouvements de translation

=== Aspect cinématique

#theorem([Solide en translation],[
  Un solide est dit en translation dans $cal(R)$ si les axes du repère lié sont d'orientation fixe dans $cal(R)$
])

Une conséquence est que $arrow(u)_e_x$ et $arrow(u)_e_y$ n'ont pas de dépendance temporelle, et qu'on n'a pas besoin d'angle pour décrire le mouvement : la dynamique du point s'applique


#theorem([Rapport $arrow(M_1 M_2)$],[
Pour tout $M_1, M_2 in Sigma^2$, le rapport $arrow(M_1 M_2)$ est constant
])

#demo([
  Notons $arrow(M_1 M_2) = x arrow(u)_e_x + y arrow(u)_e_y + z arrow(u)_e_z$
])

#theorem([Vitesse dans $cal(R)$],[
  Tous les points du solide ont la même vitesse dans $cal(R)$
])

#demo([
  On $ddt(arrow(M_1 M_2)) = 0$ d'après la conséquence précédente, d'où $arrow(M_1 M_2) = arrow(M_1 O) + arrow(O M_2) = -arrow(O M_1) + arrow(O M_2)$ avec $O$ l'origine du référentiel d'étude

  Et $ddt(arrow(M_1 M_2)) = -ddt(arrow(O M_1)) + ddt(arrow(O M_2)) = -arrow(v_1) + arrow(v_2)$ d'où $arrow(v_1) = arrow(v_2)$
])

=== Grandeurs cinétiques

#theorem([Barycentre],[
  On a $G$ le *barycentre* du solide tel que : $ m_"tot" arrow(O G) = integral.triple_(M in "solide") arrow(O M) dd(m) $
])

#theorem([Grandeurs cinétiques],[
  On a dans le cas d'un solide en translation :

  - $arrow(p) = m_"tot" arrow(v)$

  - $arrow(L_O) = arrow(O G) and m_"tot" arrow(v)$

  - $cal(E)_c = 1/2 m_"tot" v^2$
])

#demo([
  Ces démonstrations sont non exigibles, on les rappelle car elles permettent de se remémorer les formules

  - On a $arrow(p) = integral.triple dd(arrow(p) (M)) = integral.triple dd(m) arrow(v) (M) =_(arrow(v) "cst") arrow(v) integral.triple dd(m) = m_"tot" arrow(v)$

  - On a $arrow(L_O) = integral.triple dd(arrow(L_O) (M)) = integral.triple arrow(O M) and dd(m) arrow(v) (M) =_(arrow(v) "cst")  = [integral.triple arrow(O M) dd(m)] and arrow(v) =_"barycentre" arrow(O G) and m_"tot" arrow(v)$

  - On a $cal(E)_c = integral.triple dd(cal(E)_c) (M) = v^2 integral.triple 1/2 dd(m) = 1/2 m_"tot" v^2$
])

=== Loi de la quantité de mouvement

Une loi importante n'est pas mise en défaut par un solide en translation

#theorem([Loi de la quantité de mouvement],[
  Dans un référentiel galiléen, pour un solide soumis à des forces extérieures à $m$ fixée on a $ddt(arrow(p_"ext")) = sum arrow(F)_ext$ d'où :

  $ m ddt(arrow(v)) = sum arrow(F)_ext $
])

== Mouvement de rotation par rapport à un axe fixe

=== Aspect cinématique

#theorem([Solide en rotation par rapport à un axe fixe],[
  Un solide est dit en rotation par rapport à un axe fixe si il existe un axe ($Delta$) fixe dans le référentiel d'étude et le référentiel propre
])

#theorem([Distribution des vitesses],[
  Dans un solide en rotation la vitesse varie linéairement avec la distance au projeté de l'axe de rotation
])

#demo([
  On repère le point $M$ en coordonnées cylindriques, avec $omega$ sa vitesse de rotation, et $H$ son projeté sur l'axe.

  On a $arrow(O M) = arrow(O H) + arrow(H M) = z ez + r er$ ($arrow(O H)$ étant sur $ez$ et $arrow(H M)$ sur $er$ à une distance $r$ fixée) et $arrow(v) = ddt(arrow(O M)) = cancel(dot(z) ez) + cancel(dot(r) er) + r dot(theta) et$

  D'où $arrow(v) = r omega et$
])

Le vecteur $arrow(omega)$ est appelé *vecteur rotation instantané* du solide.

#warning([La loi de quantité de mouvement n'a plus de sens ici, $ddt(arrow(p)) = sum arrow(F)_ext arrow.r.double.not m ddt(arrow(v)) = sum arrow(F)_ext$])

Il ne faut aussi pas confondre mouvement circulaire, rotation et translation circulaire

Dans l'exemple d'une grande roue, les cabines sont en *translation circulaire*, tandis que la roue est en *rotation* autour d'une axe fixe

=== Moment d'inertie

#theorem([Moment cinétique d'un solide en rotation],[Soit $Delta$ un axe fixe orienté par $ez$, on a le *moment cinétique* $L_Delta = J_Delta omega$ avec $J_Delta$ le *moment d'inertie*])

#theorem([Moment d'inertie],[Soit $Delta$ un axe fixe orienté par $ez$, on a le *moment d'inertie* $J_Delta = integral.triple r^2 dd(m)$ en $unit("m^2 kg")$
])

Le moment d'inertie est additif et *quantifie l'inertie à la mise en rotation*

On a les moments d'inertie suivants :

#align(center, table(
  columns: (140pt, 100pt),
  rows: (20pt, 20pt, 20pt, 20pt, 20pt, 20pt),
  align: center,
  [*Forme*],
  $J_Delta$,
  [Tige],
  $1/3 m r^2$,
  [Cerceau],
  $m r^2$,
  [Disque homogène (HP)],
  $1/2 m r^2$,
  [Boule homogène (HP)],
  $2/5 m r^2$,
  [Coquille (HP)], 
  $2/3 m r^2$
))

#demo([
  On note $mu$ la *masse linéique*, on a $J_Delta = integral_0^r r^2 mu dd(r) = mu integral_0^r r^2 dd(r) = mu r^3/3$
  
  Or dans le cas d'une tige *homogène* on a $mu = m/r$ d'où $J_Delta = m r^2/3$
])

#theorem([Énergie cinétique],[
  Dans le cas d'un solide en rotation, on a $cal(E)_c = 1/2 J_Delta dot(theta)^2$
])

#demo([
  On a $dd(cal(E)_c) = 1/2 dd(m) v^2 (M) = 1/2 dd(m) r^2 omega^2$

  D'où $cal(E)_c = integral.triple dd(cal(E)_c) = integral.triple 1/2 dd(m) r^2 omega^2 = 1/2 (integral.triple dd(m) r^2) omega^2 = 1/2 J_Delta omega^2$
])

=== Actions mécanique et condition d'équilibre

Une *action mécanique* est une contrainte appliquée par un système, c'est à dire les forces, les moments de force et les couples

#theorem([Couple],[
  Un couple est constitué de deux forces de même module, de sens opposé et de droites d'action non confondues
])

Un couple ne modifie pas la quantité de mouvement

#demo([
  On a $ddt(arrow(p)) = arrow(F_1) + arrow(F_2) = 0$
])

#theorem([Moment d'un couple],[Un couple crée un moment noté $arrow(Gamma)$ avec $arrow(Gamma) = plus.minus F d ez$ avec $d$ la distance entre les droites d'action])

#demo([
  On a $arrow(M_O)_"tot" = arrow(M_O) (arrow(F_1)) + arrow(M_O) (arrow(F_2)) = arrow(O P_1) and arrow(F_1) + arrow(O P_2) and - arrow(F_1) = (arrow(O P_1) - arrow(O P_2)) and arrow(F_1) = arrow(P_2 P_1) and arrow(F_1)$
])

A noter que $arrow(Gamma)$ est aussi appelé couple et s'exprime en $unit("N m")$

#theorem([Condition d'équilibre d'un solide],[
  Le solide est à l'équilibre si $sum arrow(F)_ext = 0$ (translation solide) et $sum arrow(M_O) (arrow(F)_ext) = 0$ (rotation)
])

=== Théorème du moment cinétique pour un solide

#theorem([Théorème du moment cinétique pour un solide],[
  Soit $Delta$ un axe fixe, ainsi on a avec $arrow(F)_ext$ les forces extérieures connues et $arrow(Gamma)_ext$ les couples qui ne sont pas des moments des forces extérieures :

  $ J_Delta dot.double(theta) = sum M_Delta (arrow(F)_ext) +  sum Gamma_ext $
])

#demo([
  Par le TMC on a $ddt(L_Delta) = sum M_Delta (arrow(F)_ext)$ avec $ddt(L_Delta) = ddt(J_Delta dot(theta)) = J_Delta dot.double(theta)$ ce qui conclut en séparant les termes selon leur connaissance ou non
])

== Énergétique du solide

Dans un solide indéformable il n'y a pas de travail interne

#warning([Cette affirmation entre en défaut lorsque l'on travaille avec un solide articulé])

#theorem([Théorème de la puissance cinétique pour un solide en rotation], [
  On a $P = M_Delta (arrow(F)) times omega$ d'où on a :
  $ ddt(cal(E)_c) = sum P_ext = sum M_Delta (arrow(F_ext)) dot(theta) $
])

#demo([
  On part du TMC solide, on a $ddt(J_Delta dot(theta)) = sum M_Delta (arrow(F)_ext)$ d'où en multipliant par $dot(theta)$, on a $ddt(1/2 J_Delta dot(theta)^2) = sum P_ext$
])

Il est toujours possible d'utiliser les théorèmes d'énergétique de la dynamique du point mais il faut faire attention au domaine d'application

#pagebreak()

#counter(heading).update(0)

#set heading(numbering: "💧 I.1.a")

#align(center, text([💧 Thermodynamique], weight: 800, size: 24pt))

#box(height: 1em)
#heading([Introduction à la thermodynamique], supplement: [thermo])

== Généralités

On parle de *système thermodynamique* pour une portion de matière ou un ensemble de portions de matière séparées du reste de l'univers par une frontière réelle ou imaginaire qui est constitué d'un trop grand nombre de particules pour être étudié individuellement.

*Échelle macroscopique* : On observe la matière à notre échelle, à cette échelle la matière est continue

*Échelle microscopique* : On observe la matière à l'échelle des particules, à cette échelle la matière est discrète (donc discontinue)

*Échelle mésoscopique* : On observe la matière à l'échelle intermédiaire, à cette échelle la matière apparaît continue

On a $cal(N)_A = 6.02 times 10^(23) unit("mol^-1")$ la constante d'Avogadro

Les 3 états de la matière :

- *Solide* : Particules assez ordonnées, proches et peu mobiles (incompressible et indéformable)
- *Liquide* : Particules très désordonnées, proches et très mobiles (incompressible et déformable)
- *Gaz* : Particules très désordonnées, éloignées et très mobiles (compressible et déformable)

On parle d'un *fluide* pour un gaz ou un liquide et d'une *phase condensée* pour un liquide ou un solide.

== Variables d'état

Une *variable d'état* est une grandeur permettant de décrire l'équilibre thermodynamique d'un système.

Une grandeur est dite *extensive* si elle dépend de la taille du système (volume par ex) et *intensive* si ce n'est pas le cas (pression par ex), à noter que le produit de 2 grandeurs extensives donne une grandeur intensive.

Pour toute grandeur $G$ extension on peut définir la *grandeur molaire* $G_m = G/n$ avec $n$ le nombre de moles et la *grandeur massique* $g = G/m$ avec $m$ la masse.

=== Pression

La *pression* est une variable d'état en Pascal ($unit("Pa")$) avec $1 unit("bar") = 10^5 unit("Pa")$, est intensive et est causée par des chocs particulaires sur la paroi

#theorem([Force de pression], [
  On a $arrow(F) = P S arrow(u)$ avec $arrow(u)$ orienté vers l'extérieur de fluide dans le cas d'une paroi plane
])

Si on a une paroi non plane on a $arrow(F) = integral P d S arrow(u)$ avec $arrow(F) = P S arrow(u)$ si la pression est uniforme

=== Température

La température s'exprime en Kelvin ($unit("K")$), avec $T > 0 unit("K")$ et $0 unit("dC") = 273.15 unit("K")$, est intensive et provient d'une agitation moléculaire.

On a $cal(E)_c = 3/2 k_B T$ l'énergie thermique moléculaire avec $k_B = R/cal(N)_A$ la constante de Boltzmann.

== Équilibre thermodynamique

On atteint un état d'équilibre thermodynamique quand les propriétés macroscopiques du système n'évoluent plus, ainsi on a :
- Équilibre mécanique avec l'extérieur
- Équilibre thermique
- Équilibre radiatif
- Équilibre chimique

A l'équilibre thermodynamique un système voit ses variables d'état liées par une relation d'état

== Modèle des gaz parfaits

#theorem([Gaz parfait], [On parle d'un gaz parfait pour un gaz composé de particules ponctuelles sans intéraction entre elles.])

#theorem([Équation des gaz parfaits], [On a à l'équilibre thermodynamique : $P V = n R T$ avec $R = qty("8.31", "J/K/mol")$ la constante des gaz parfaits.])

_Si quelqu'un voulait la démo de l'équation des gaz parfaits j'ai pas envie désolé :)_

#box(height: 1em)
#heading([Premier principe], supplement: [thermo])

== Énergie interne, capacité thermique à volume constant

On note $U$ l'*énergie interne* d'un système thermique, c'est une fonction d'état additive et extensive s'exprimant en Joule : c'est l'énergie microscopique du système.

La variation des fonctions d'état ne dépend que des états initial et final, et est indépendante du chemin parcouru.

#theorem([1ère loi de Joule], [Dans le cas d'un gaz parfait, $U$ = $A T$, ainsi elle ne dépend que de la température])

Dans le cas d'un gaz parfait monoatomique on a $U = 3/2 n R T$ et dans le cas d'un gaz parfait diatomique on a $U = 5/2 n R T$

A noter qu'il y a énormément d'énergie stockée de manière interne.

On défini la *capacité thermique* à volume fixé par $C_v = derivativePart(U,T,V)$ et dans le cas d'un GP on a $C_v = dv(U,T)$, et est additive, extensif et s'exprime en $unit("J/K")$

#theorem([Expression de $Delta U$], [On a $Delta U = integral_(T_i)^T_f C_v d T = C_v Delta T$])

== Premier principe

#theorem([Premier principe], [Dans un *système fermé* évoluant entre des états d'équilibre on a $Delta (E_m_("macro") + U) = W + Q$ d'où dans la plupart des cas : \ $ Delta U = W + Q $])

Dans le cas infinitésimal on a $d U = delta W + delta Q$

Avec $W$ le travail reçu par le système ($W > 0$ si récepteur et moteur sinon) et $Q$ le transfert thermique ($Q > 0$ reçoit et fournit sinon).

On a 3 types de transfert thermiques :

- *Convection* : Transfert accompagné d'un déplacement macroscopique de matière et concerne donc les fluides

- *Conduction* : Transfert thermique qui intervient dans un milieu où la température n'est pas homogène, et qui ne s'accompagne pas de déplacement de matière : c'est celui qui prédomine dans les solides

- *Rayonnement* : Transfert thermique par rayonnement électromagnétique

Il faut bien penser à définir le système pour utiliser le premier principe

== Types de transformations

- *Adiabatique* : Sans transfert thermique ($Q = 0$)
- *Monobare* : Au contact d'un système qui fixe la pression
- *Monotherme* : Au contact d'un système de température fixée (un thermostat)
- *Quasi statiques* : État d'équilibre au cours de toute la transformation
- *Brutale* : Les variables d'état ne sont pas définies dans les moments intermédiaires mais seulement à l'état initial et final
- *Système Calorifugé* : Limite les échanges de chaleur
- *Isochore* : $V$ constant
- *Isotherme* : $T$ constant
- *Isobare* : $P$ constant

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

Ainsi on a le premier principe monobare :

#theorem([Premier principe monobare], [Dans un système fermé évoluant entre des états d'équilibre avec une transformation monobare on a $Delta (E_m_("macro") + H) = W_u + Q$ d'où dans la plupart des cas : \ $ Delta H = W_u + Q $])

#demo([On a $Delta (E_m_("macro") + U) = W_u + W_"pression" + Q$ or $W_"pression" = - Delta (P V) = 0$, ainsi on a la propriété recherchée])

Avec $W_u$ la puissance utile des autres forces que celles de pression (souvent nulles d'où $Delta H = Q$ dans certains cas)

On définit la capacité thermique à pression fixée par $C_p = derivativePart(H, T, P)$ et $C_p = dv(H, T)$ dans le cas d'un gaz parfait.

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

#box(height: 1em)
#heading([Second principe], supplement: [thermo])

== Entropie et second principe

On considère un système fermé avec un ou plusieurs thermostats, ainsi il *existe* une fonction d'état appelée *entropie* notée $S$, additive et extensive en $unit("J/K")$ qui est une mesure du désordre.

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

#box(height: 1em)
#heading([Flux thermiques], supplement: [thermo])

== Flux thermique, puissance

#theorem([Flux thermique], [Un flux est un échange de chaleur par unité de temps algébrique, on a $Phi = (delta Q)/(d t)$, et on peut définir $Phi_"surf" = (delta Q)/(d t d S)$])

On a $Phi$ en $W$ et $Phi_"surf"$ en $unit("W/m^2")$

== Échanges conductifs

#theorem([Flux conductif], [Dans le cas d'un échange convectif (c'est à dire via une paroi) entre 2 systèmes, on a $Phi = 1/R Delta T$ avec $R$ la résistance thermique])

#theorem([Résistance thermique], [
  Une résistance thermique est homogène à $unit("K/W")$, et on a $R = e/(S lambda)$ avec $e$ l'épaisseur, $S$ la surface et $lambda$ la conductivité thermique
])

La conductivité thermique s'exprime en $unit("W/m/K")$, plus la conductivité est grande moins on isole.

On a $G = 1/R$ la conductance.

Les résistances thermiques ont le même comportement qu'en électricité, ainsi en série on a $R_"AB" = R_"A" + R_"B"$ et en parallèle $1/R_"AB" = 1/R_"A" + 1/R_"B"$.

#demo([
  - Série : On a $Phi = Phi_"A" = Phi_"B"$ avec $Phi_"A" = (T_A - T_*)/R_"A"$ et $Phi_"B" = (T_* - T_B)/R_"B"$ \ Ainsi on a $T_A - T_B = T_A - T_* + T_* - T_B = R_A Phi_"A" + R_B Phi_"B" = (R_A + R_B) Phi$ \
  
  - Parallèle : On a $Phi_"A" = 1/R_A Delta T$ et $Phi_"B" = 1/R_B Delta T$, et $Phi = Phi_"A" + Phi_"B" = (1/R_A + 1/R_B) Delta T$
])

== Échanges conductovectifs

On considère un fluide et un solide et leurs échanges thermiques

#theorem([Loi thermique de Newton], [
  On a $Phi_"surf" = h (T_"surf" - T_"ext")$ avec $h$ le coefficient de transfert en $unit("W/m^2/K")$, $h$ étant plus grand pour un liquide que pour un gaz.
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

#box(height: 1em)
#heading([Machines thermiques], supplement: [thermo])

== Description générale d'une machine thermique cyclique

On parle d'un système *cyclique* si il décrit un cycle

#figure(image("physics/thermo/cycle.svg", height: 100pt))

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


#figure(image("physics/thermo/raveau.png", height: 130pt))

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

#table(columns: (120pt, 140pt, 140pt), align: center+horizon, rows: 30pt,
[*Type de machine*],
[*Transferts thermiques*],
[*Rendement/Efficacité*],
[Moteur],
[$Q_c > 0$ et $Q_f < 0$],
[$ eta = - W/Q_c $],
[Réfrigirateur],
[$Q_c < 0$ et $Q_f > 0$],
[$ e = Q_f/W $],
[Pompe à chaleur],
[$Q_c < 0$ et $Q_f > 0$],
[$ e = - Q_c/W $],
)

#theorem([Rendement de Carnot], [Pour un moteur ditherme son rendement maximal est : \
$ eta_c = 1 - T_F/T_C$  avec $eta <= eta_c$])

#demo([
  On a $Q_F + Q_C + W = 0$, $Q_C/T_C + Q_F/T_F <= 0$ et $eta = -W/Q_C$ \ \
  D'où $eta = (Q_C + Q_F)/Q_C = 1 + Q_F/Q_C$ or $Q_F <= -Q_C T_F/T_C$ d'où $eta <= 1 - T_F/T_C$
])

#theorem([Efficacité de Carnot (réfrigirateur)], [Pour un réfrigirateur son efficacité maximale est : \
$ e_c = T_F/(T_C - T_F)$  avec $eta <= eta_c$])

#demo([
  On a $Q_F + Q_C + W = 0$, $Q_C/T_C + Q_F/T_F <= 0$ et $eta = Q_F/W$ \ \
  D'où $eta = - Q_F/(Q_C + Q_F)$ avec $Q_F >= -Q_C T_F/T_C$ d'où $eta <= T_F/(T_C - T_F)$
])

Dans les faits, $3 <= e <= 4$

#theorem([Efficacité de Carnot (pompe à chaleur)], [Pour une pompe à chaleur son efficacité maximale est : \
$ e_c = T_C/(T_C - T_F)$  avec $eta <= eta_c$])

#demo([
  On a $Q_F + Q_C + W = 0$, $Q_C/T_C + Q_F/T_F <= 0$ et $eta = -Q_C/W$ \ \
  D'où $eta = Q_C/(Q_C + Q_F)$ avec $Q_F >= -Q_C T_F/T_C$ d'où $eta <= T_C/(T_C - T_F)$
])

Dans les faits, $2 <= e <= 5$

#box(height: 1em)
#heading([Changement de phase du corps pur], supplement: [thermo])

Une *phase* est une partie d'un système dont les variables intensives sont continues

#figure(
  image("physics/thermo/states.jpg", width: 40%)
)

== Échauffement isobare d'un corps pur

La *température d'ébullition* est la température d'équilibre liquide vapeur (ie les 2 coexistent)

La *température de fusion* est la température d'équilibre solide liquide (ie les 2 coexistent)

La *pression de vapeur saturante* est la pression d'équilibre liquide vapeur

Dans le cas des corps purs, on a $P_"vap" = f(T_"ébul")$

== Diagramme ($P$, $T$)

#figure(
  image("physics/thermo/clapeyron.jpg", width: 30%)
)

$T$ représente le *point triple*, c'est à dire le point où on a équilibre vapeur solide liquide

$C$ représente le *point critique*, c'est à dire au delà duquel il n'y a plus de différence entre état liquide et gazeux (on parle de *fluide supercritique*)

En regardant le diagramme on a des informations sur l'état du système considéré, et on peut se rendre compte que de l'eau se liquéfie sous l'effet de la compression

== Diagramme de Clapeyron ($P$, $v$), isotherme d'Andrews

#figure(
  image("physics/thermo/andrews.svg", width: 50%),
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

Les enthalpies de changement d'état sont définies par la différence d'enthalpie entre les deux états à température fixée.

#theorem([Variations d'enthalpie/d'entropie], [
  Soit $Delta_"A"h$ l'enthalpie de changement d'état $A$ et $Delta_"A"s$ l'entropie de changement d'état $A$.

  On a $Delta_A H = m Delta_"A"h$ et $Delta_A S = (Delta_A H)/T_A$ avec $T_A$ la température de changement d'état.
])

De plus on a $Delta_"sub"h > 0$, $Delta_"vap"h > 0$ et $Delta_"fus"h > 0$ et $Delta_"con"h = -Delta_"sub"h$, $Delta_"liq"h = -Delta_"vap"h$ et $Delta_"sol"h = -Delta_"fus"h$

D'après l'expression des variations, on en déduit que $S_"gaz" > S_"liq" > S_"sol"$ ce qui est logique d'après la définition de l'entropie

#pagebreak()

#counter(heading).update(0)

#set heading(numbering: "🧲 I.1.a")

#align(center, text([🧲 Magnétisme], weight: 800, size: 24pt))

#box(height: 1em)
#heading([Introduction à la dynamique des particules chargées], supplement: [magne])

== Force de Lorentz

On considère des particules dans un champ magnétique et électrique

#theorem([Force de Lorentz],[
  On a la *force de Lorentz*, $arrow(F) = q arrow(E) + q arrow(v) and arrow(B)$ la force subie par un électron
])

Dans l'étude d'un mouvement dans un champ électromagnétique, le poids et les forces de frottement sont négligées.

== Origine électrique

Le champ électrique peut modifier l'énergie cinétique d'une particule chargée : elle peut agir à la fois sur la norme et la direction de la vitesse.

On note $arrow(E)$ un *champ électrique* en $unit("V/m")$ et une particule plongée dans un tel champ subit la composante électrique c'est à dire $arrow(F) = q arrow(E)$

Pour créer un champ homogène on utilise un condensateur, $arrow(E)$ est homogène quand on n'est pas trop proche des bords (pas des bornes) du condensateur

#theorem([Champ électrique créé par un condensateur],[
  Un condensateur crée un champ électrique $E = U/d$ avec $U$ la tension et $d$ la distance entre les électrodes
])

Le champ $arrow(E)$ est orienté vers l'armature de plus faible potentiel

Le vecteur accélération d'une particule chargée dans un champ électrique est $arrow(a) = q arrow(E)/m$ et est donc constant : sa trajectoire est donc une portion de parabole ou une droite si sa vitesse initiale est nulle ou parallèle à $arrow(E)$

La force de Lorentz électrique dérive d'un potentiel

#theorem([Énergie potentielle de Lorentz électrique],[
  On a $E_p = q V = q (-x E_x)$ en supposant que $arrow(E) = E_x ex$
])

#demo([
  On a $arrow(F) = q arrow(E) = q U/d ey = - dv(u,g)(- q U/d y + C) ey$

  Ainsi $E_p = - q U/d y + C$ d'où $V(y) = E_p/q = - U/d y + C'$

  Pour déterminer $C$ on peut placer une masse dans le circuit
])

L'*électron-volt* ($unit("eV")$) correspond à l'énergie d'un électron à un potentiel de $qty("1","V")$, ainsi $qty("1","eV") = qty("1.6e-19","J")$

Dans un système conservatif on a $v = sqrt((2 abs(q) U)/m)$ si $v <= 0.1 c$

#demo([
  On a $0 = Delta cal(E)_m = Delta cal(E)_c + Delta cal(E)_p = Delta cal(E)_c + q(V_f - V_i)$ d'où $Delta cal(E)_c = q(V_i - V_f)$

  En supposant $v_0 = 0$ et $V_i = 0$, on trouve $1/2 m v_f^2 = q U$ d'où $v = sqrt((2 abs(q) U)/m)$
])

== Origine magnétique

Un champ magnétique ne peut pas modifier l'énergie cinétique d'une particule chargée, il agit uniquement sur la direction de la vitesse.

Un *champ magnétique* est un champ vectoriel noté $arrow(B)$ en Tesla ($unit("T")$)

La composante magnétique de la force de Lorentz est $arrow(F) = q arrow(v) and arrow(B)$

Une particule de charge $q$ à une vitesse initiale $arrow(v_0)$ perpendiculaire à $arrow(B)$ décrit un cercle de rayon $R = (m v_0)/(abs(q) B)$ à la vitese angulaire $omega = (abs(q) B)/m$, on parle de *pulsation cyclotron*

#demo([
  #todo(text:[(Pas prioritaire mais à faire)])
])

La puissance est nulle, en effet $P = (q arrow(v) and arrow(B)) dot arrow(v) = 0$, de plus la force ne travaille pas donc $Delta cal(E)_c = 0$

#box(height: 1em)
#heading([Généralités sur le champ magnétique], supplement: [magne])

== Généralités

Le *champ magnétique* est un champ vectoriel $arrow(B)(M, t)$ s'exprimant en Tesla ($unit("T")$). On le mesure avec une sonde à effet Hall.

On a les ordres de grandeurs suivants :
- $B_"Terre" = qty("e-5", "T") = qty("0.01", "mT")$
- $B_"aimant" = qtyrange("0.1", "1", "T")$
- $B_"IRM" = "qqs" unit("T")$
- $B_"LABO" = qty("10", "T")$

#theorem([Lignes de champ],[
  Les *lignes de champ* sont un tracé colinéaire en tout point au champ magnétique.

  Leur principal intêret est la lisibilité et que la distance entre les lignes de champ varie comme l'inverse de l'intensité du champ.
])

Le champ est nul en un point si les lignes de champ se croisent en ce point

Propriété HP : Les lignes de champ sont orthogonales aux lignes iso-champ.

#theorem([Propriétés des lignes de champ],[
  - 2 lignes de champ ne se croisent pas, *sauf si le champ est nul localement*
  - Dans le cas des lignes de champ magnétiques elles sont toujours bouclées sur elles-même.
])

== Dépendance courant électrique et lignes de champ

#theorem([Champ magnétique créé par un circuit],[
  Un circuit parcouru par un courant constant (ou lentement variable) crée un champ magnétique constant (ou lentement variable) $arrow(B)("pos", I)$ proportionnel à $I$
])

Pour trouver le sens des lignes de champ on utilise la règle de la main droite : on oriente son pouce dans le sens du courant et les lignes de champ vont dans le sens de repliement des mains.

Un fil infiniment mince crée un champ magnétique $arrow(B) = (mu_0 I)/(2 r) arrow(e_theta)$ avec $I$ orienté vers $z > 0$ et $mu_0 = 4 pi qty("e-7","H/m")$ la permittivité magnétique du vide.

Un *spire* est un fil circulaire.

#theorem([Théorème de superposition],[
  Dans un milieu linéaire, le champ magnétique total est la somme (la superposition) de chaque $arrow(B)_i$ créé par chaque source de $arrow(B)$ prise indépendamment. On a donc :
  $ arrow(B) = sum_"sources" arrow(B)_i $
])

Dans le cas d'une série de spires, on a pour chaque spire la courbe suivante :

#graph(funcs: ((x) => {
  return 1/(calc.sqrt(2 * 3.14)) * calc.exp(-0.001 * calc.pow(x - 40, 2))
},(x) => {
  return 1/(calc.sqrt(2 * 3.14)) * calc.exp(-0.001 * calc.pow(x - 50, 2))
},(x) => {
  return 1/(calc.sqrt(2 * 3.14)) * calc.exp(-0.001 * calc.pow(x - 60, 2))
},(x) => {
  return 1/(calc.sqrt(2 * 3.14)) * calc.exp(-0.001 * calc.pow(x - 70, 2))
},(x) => {
  return 1/(calc.sqrt(2 * 3.14)) * calc.exp(-0.001 * calc.pow(x - 80, 2))
},), domain: (100, 3))

D'où pour $arrow(B)$ on a :

#graph(funcs: ((x) => {
  return 1/(calc.sqrt(2 * 3.14)) * calc.exp(-0.001 * calc.pow(x - 40, 2)) + 1/(calc.sqrt(2 * 3.14)) * calc.exp(-0.001 * calc.pow(x - 50, 2)) + 1/(calc.sqrt(2 * 3.14)) * calc.exp(-0.001 * calc.pow(x - 60, 2)) + 1/(calc.sqrt(2 * 3.14)) * calc.exp(-0.001 * calc.pow(x - 70, 2)) +1/(calc.sqrt(2 * 3.14)) * calc.exp(-0.001 * calc.pow(x - 80, 2))
},), domain: (100, 3))

On a donc le champ magnétique dans le solenoïde infini égal à $arrow(B) = mu_0 n i$ avec $n$ le nombre de spires par unité de longueur et $i$ l'intensité

== Champ magnétiques continus dans la nature

Dans la nature il est possible de trouver des champs magnétiques. Certains matériaux possèdent la propriété d'être aimantés ou magnétisables. C'est lié à une propriété magnétique des électrons, le _spin_.

La Terre en est un bon exemple, le noyau externe constitue un champ magnétique sous l'effet d'un mouvement convectif.

== Moment magnétique, dipôle magnétique

#theorem([Moment magnétique],[
  Dans le cas d'une spire parcourue par un courant $I$, on a :
  $ arrow(mu) = I S arrow(u) = I arrow(S) $
  avec $S$ l'aire du disque, $arrow(u)$ un vecteur unitaire ou $arrow(S)$ le vecteur surface
  
  On a $[arrow(mu)] = unit("A m^2")$
])

Le moment magnétique quantifie à quel point l'aimant est "fort" : la norme du moment magnétique est proportionnelle à la force de l'aimant et la direction de $arrow(mu)$ définit l'axe de révolution des lignes de champ.

#theorem([Couple de Laplace, Energie potentielle],[
  Un dipôle magnétique de moment $arrow(mu)$ subit le *couple de Laplace*, $arrow(Gamma) = arrow(mu) and arrow(B)$.

  Cette intéraction étant conservative, on a $E_p = - arrow(mu) dot arrow(B)$
])

En champ lointant, $arrow(mu)$ traduit l'"intensité" de cette source de champ magnétique et même si un aimant ne présente pas de courant électrique, un aimant possède un moment magnétique.

#warning([On a $arrow(Gamma)$ connu mais pas les forces donc on ne peut pas appliquer un PFD])

== Créer un champ magnétique

On peut utiliser des bobines ou un aimant pour créer un champ magnétique.

Dans un solénoïde infini, le champ est continu par morceaux sauf si on s'approche trop près du bord.

Pour créer un champ tournant, on alimente des bobines par des courants sinusoïdaux déphasés.

== Lire une carte magnétique

#theorem([Lecture d'une carte de champ],[
  Plus les lignes de champ son proches, plus $norm(arrow(B))$ est grand.

  L'orientation des lignes de champ ou des fils respectent la règle de la main droite
])

Dans le cas d'un aimant les lignes de champ sortent du pôle nord et rentrent par le pôle sud.

#figure(image("physics/magnet/magnet.png", width: 50%))

== Action mécanique d'un champ magnétique sur un système physique

On a l'expérience des rails de Laplace :

#figure(image("physics/magnet/laplace.png", width: 30%))

#theorem([Forces de Laplace],[
  Un barreau rectiligne conducteur de longueur $l$ parcouru par une intensité $I$ dans un champ magnétique $arrow(B)$ subit une force $ arrow(F_L) = I l arrow(u) and arrow(B) $ avec $arrow(u)$ un vecteur unitaire orienté dans le sens du courant.

  Dans le cas d'un chemin on a $ arrow(F_L) = integral I arrow(dd(l)) and arrow(B) $
])

#demo([
  On se place dans un cas simple, les électrons ont tous la même vitesse $arrow(v)$ et sont distribués de manière homogène.

  On a $n^*$ le nombre d'électrons par unité de volume.

  On a $I = (delta Q)/dd(t)$ avec $delta Q = delta N e$ la charge traversant la section pendant $dd(t)$, et $delta N$ le nombre d'électrons traversant la section pendant $dd(t)$.

  D'où $delta N = n^* S v dd(t)$ soit $I = n^* S v e$

  On a $arrow(F_L) = N times arrow(F)_"Lorentz"$ avec $N$ le nombre d'électrons et $arrow(F)_"Lorentz" = - e arrow(v) and arrow(B) = (-e)(-v arrow(e_x)) and arrow(B) = e v arrow(e_x) and arrow(B)$.

  D'où $arrow(F_L) = N e v arrow(e_x) and arrow(B) = n^* l S e v arrow(e_x) and arrow(B) = I l arrow(u) and arrow(B)$
])

Dans un circuit filiforme non rectiligne, $arrow(F_L) = integral I arrow(dd(l)) and arrow(B)$

Dans le cas du schéma au dessus, les forces sur les rails de Laplace sont opposées et se compensent.

La force s'applique au baricentre du barreau.

On considère maintenant le schéma suivant :

#figure(image("physics/magnet/squared_spire.png", width: 30%))
#figure(image("physics/magnet/squared_spire_top.png", width: 30%))

#theorem([Force et moment dans une spire carrée],[
  Dans une spire carrée, on a $arrow(F_L) = 0$ et $arrow(M_0) = arrow(mu) and arrow(B)$
])

#demo([
  Pour la force :

  On a $arrow(F_L) = arrow(F_L^(M N)) + arrow(F_L^(N P)) + arrow(F_L^(P Q)) + arrow(F_L^(Q M))$

  On a $arrow(F_L^(M N)) = I arrow(M N) and arrow(B)$ et $arrow(F_L^(P Q)) = I arrow(P Q) and arrow(B) = - I arrow(M N) and arrow(B)$ d'où $arrow(F_L^(M N)) + arrow(F_L^(P Q)) = 0$

  De même pour $arrow(F_L^(N P)) + arrow(F_L^(Q M)) = 0$ d'où $arrow(F_L) = 0$
])

#demo([
  Pour le moment :

  On se place dans le second schéma, on a $arrow(M_0)(arrow(F_L)) = arrow(M_0)(arrow(F_L^(M N))) + arrow(M_0)(arrow(F_L^(N P))) + arrow(M_0)(arrow(F_L^(P Q))) + arrow(M_0)(arrow(F_L^(Q M)))$

  On a $arrow(M_0)(arrow(F_L^(M N))) = arrow(O C) and (I arrow(M N) and arrow(B)) = I (-a/2 arrow(e_r)) and (-a arrow(e_z) and (-B arrow(e_y))) = I a^2/2 B arrow(e_r) and arrow(e_x) = - I a^2/2 B sin(theta) ez$ 

  On a $arrow(M_0)(arrow(F_L^(P Q))) = arrow(O E) and (I arrow(P Q) and arrow(B)) = - arrow(O C) and (I arrow(M N) and arrow(B)) = - I a^2/2 B sin(theta) ez$

  On a $arrow(M_0)(arrow(F_L^(N P))) = arrow(O D) and (I arrow(N P) and arrow(B)) = I (-a/2 arrow(e_z)) and (-a arrow(e_r) and (-B arrow(e_y))) = a/2 arrow(e_z) and I a B cos(theta) arrow(e_z) = 0$

  De même pour $arrow(M_0)(arrow(F_L^(Q M))) = 0$

  D'où $arrow(M_0)(arrow(F_L)) = -I a^2 B arrow(e_r) and arrow(e_z) = - I a^2 B sin(theta) arrow(e_z) = - mu B sin(theta) arrow(e_z)$

  Par ailleurs $arrow(mu) and arrow(B) = (- mu arrow(e_theta)) and (- B arrow(e_y)) = - mu B sin(theta) arrow(e_z)$
])

== Approche énergétique : Puissance des forces de Laplace

#theorem([Puissance des forces de Laplace],[
  La puissance des forces de Laplace est $P = I L B dot(x)$
])

#demo([
  On a $arrow(F_L) = I arrow(M N) and arrow(B) = I L B arrow(e_x)$ d'où $P = arrow(F_L) dot arrow(v) = I L B dot(x)$
])

#box(height: 1em)
#heading([Lois de l'induction : le cas des circuits fixes], supplement: [magne])

== Les phénomènes d'induction

L'*induction électromagnétique* est le phénomène par lequel un courant électrique apparaît dans un circuit fermé sans générateur.

L'induction est utilisée dans les transformateurs électriques ou encore les rechargement par induction.

On considère des circuits *filiformes* *rigides* *fixes* :

- *filiforme* : On ne considère que le contour
- *rigides* : Ne se déforment pas

#theorem([Flux],[
  Dans un champ magnétique $arrow(B)$ avec $S$ la surface on a :
  $ Phi_B = integral.double_"surface délimitée \n par le contour" arrow(B) dot dd(arrow(S)) $
  avec $dd(arrow(S))$ orienté selon le sens du courant (règle de la main droite) et $[Phi_B] = unit("Wb") = unit("T/m^2")$ (Weber)
])

Le flux est additif (par linéarité des intégrales)

On a $[Phi_B] = unit("T m^2")$, et dans le cas d'une spire de rayon $a$ on a $Phi_B = arrow(B) dot arrow(u) pi a^2$

#theorem([Flux total],[
  Dans un champ magnétique $arrow(B)$ on a :
  $ Phi_"tot" = sum_"chaque spire" Phi_"1 spire" $
])

On considère un aimant qu'on approche d'une bobine, avec $arrow(u)$ et $arrow(B)$ de direction opposée.

Si l'aimant est loin ou immobile, $Phi = 0$ et il n'y a pas de courant

Quand on rapproche l'aimant, $Phi$ diminue et $i>0$ et $u>0$

Quand on éloigne l'aimant, $Phi$ augmente et $i<0$ et $u<0$

Ainsi une diminution du flux induit un courant positif

Ces observations sont toujours valable lorsque la bobine bouge et non l'aimant

On remarque que le champ magnétique induit est toujours dans le sens inverse à la variation de champ magnétique extérieur

#theorem([Loi de Lenz],[
  On a la *loi de Lenz* qui est un principe de modération : Un phénomène d'induction s'oppose par ses conséquences aux causes qui l'ont engendré
])

Pour étudier un circuit, on l'oriente puis on définit le vecteur surface $arrow(S)$ perpendiculaire au plan du circuit et orienté par la règle de la main droite.

== Loi de Faraday

On place dans le cadre de l'ARQS

#theorem([Loi de Faraday],[
  Si $Phi_B$ varie il apparaît alors dans le circuit une force électromotrice induite du même sens que la convention d'orientation du circuit.

  On a :

  $ e = - ddt(Phi_B) $
])

Le $-$ dans la formule est dû à la loi de Lenz

== Auto induction et couplage inductif

#theorem([Flux propre et coefficient d'auto inductance],[
  Un circuit parcouru par un courant $i$ crée un champ magnétique. Le flux correspondant dans le circuit est appelé *flux propre* et $Phi_P = L i$, avec $L$ le coefficient d'*auto inductance* ou *inductance* (en Henry)
])

On a $e = - ddt(Phi_B) = - ddt(L i) = - L ddt(i)$ (en convention générateur) donc on retrouve une formule du chapitre d'électricité, de même que la continuité de $i$ peut se retrouver avec la loi de Lenz : le système limite $i$ lors de son apparition

Ainsi l'énergie stockée dans une bobine est stockée sous forme d'énergie magnétique

Dans le cas d'un circuit avec faible enroulement on néglige les auto-inductances

Puisque le flux est additif on trouve $e = -ddt(Phi_"tot") = -ddt(Phi_"propre")-ddt(Phi_ext)$

Ainsi deux circuits proches l'un de l'autres peuvent présenter un couplage magnétique

#theorem([Inductance mutuelle],[
  On a $Phi_(1 -> 2) = M i_1$ et $Phi_(2 -> 1) = M i_2$, avec $M$ l'*inductance mutuelle* en Henry
])

En électricité on notera une impédance mutuelle par un #todo(text: [(Faire un schéma et la puissance reçue avec le schema)])

== Influence totale

#figure(image("physics/magnet/transformer.svg", width: 50%))

On peut guider les lignes de champs en utilisant un guide magnétique

#theorem([Expression de l'auto inductance],[
  Pour deux bobines de même longueur $l$ avec $N_1$ et $N_2$ spires on a :

  $ L_1 = mu_0 S N_1^2/l $
])

#demo([
  On a $B_1 = mu_0 n_i i_1 = mu_0 N_1/l i_1$ et $Phi_"spire" = B_1 S$ d'où $Phi_"N,spire" = N_1 Phi_"spire" = mu_0 S N_1^2/l i_1$ donc on retrouve bien $L_1$
])

#theorem([Expression de la mutuelle],[
  Pour deux bobines de même longueur $l$ avec $N_1$ et $N_2$ spires on a :

  $ M = mu_0 S (N_1 N_2)/l $
])

#demo([
  On a $Phi_(B_1 -> "bobine 2") = N_2 Phi_(B_1 -> "1 spire de 2")$ avec $Phi_(B_1 -> "1 spire de 2") = mu_0 S (N_1)/l i_1$

  D'où on a $Phi_(B_1 -> "bobine 2") = mu_0 S (N_1 N_2)/l i_1$ d'où l'expression de $M$
])

On remarque aussi que $M^2 = L_1 L_2$

La mutuelle change de signe si on pivote de $qty("90", "d")$

Dans la matière en réalité, $mu_0$ n'est pas constant et dépend du matériau choisi

Dans les faits on aura des pertes dans les matériaux avec $M_"réel" < M_"th"$

Dans le cas de l'intéraction totale on a $abs(e_1/e_2) = N_1/N_2$ car $e_1 = plus.minus e_2$

On utilise ce genre de dispositifs pour faire des transformateurs pour passer de basse tension à haute tension.


#box(height: 1em)
#heading([Lois de l'induction : le cas des circuits mobiles], supplement: [magne])

== Force électromotrice d'un circuit en mouvement

En considérant un conducteur se déplaçant à une vitesse $arrow(v_0)$, on a $e = - (delta Q)/dt$ avec $delta Q$ le *flux coupé* (HP)

#theorem([Force électromotrice],[
  On a $e = - ddt(Phi)$
])

== Rail de Laplace générateur

En considérant un rail de Laplace, on analyse un système de la manière suivante :

1. On fait une mise en équation mécanique
2. On fait une mise en équation électrique
3. On fait une équation différentielle et un bilan de puissance

Ensuite on réalise un bilan de puissances :

On multiplie par $dot(x)$ ou $i$ puis on obtient un bilan qui peut faire intervenir $R i^2$ la puissance dissipée par effet Joule, ou encore $ddt(cal(E)_c)$ comme termes

Il peut aussi y avoir des termes en plus, comme la puissance fournie par l'opérateur

A noter que pour un circuit mobile, la somme des puissances est nulle (il y a conversion de l'énergie mécanique en énergie électrique)

#pagebreak()

#counter(heading).update(0)

#set heading(numbering: "🪄 I.1.a")

#align(center, text([🪄 Mécanique quantique], weight: 800, size: 24pt))

#box(height: 1em)
#heading([Introduction à la mécanique quantique], supplement: [quantum])

== Nature ondulatoire de la lumière

Un *corps noir* est un objet qui absorbe toute la lumière incidente, et qui émet un rayonnement thermique.

Le début de la théorie quantique est liée à l'effet photoélectrique, qui est l'émission d'électrons (arrachés) par un matériau sous l'effet de la lumière. On observe une fréquence seuil au delà de laquelle l'effet photoélectrique se produit, mais on n'arrive pas à expliquer pourquoi avec la théorie ondulatoire.

C'est là qu'entre en jeu Einstein, avec la théorie des *quanta* : on considère que la lumière n'est plus continue mais est faite de quanta d'énergie $h f$ d'où la présence d'une fréquence seuil.

#theorem([Relation de Plank-Einstein],[
  La lumière se compose de *photon* d'énergie $E = h f$ avec $h = qty("6.63e-34", "J s")$ la constante de Planck et $f$ la fréquence (parfois notée $nu$)

  Dans le vide, la lumière se propage à la vitesse $c = qty("3e8", "m/s")$

  Le photon possède une quantité de mouvement $p = h/lambda = (h f)/c$ avec $lambda$ la longueur d'onde
])

#warning([
  Les expressions ci dessus ne sont vraies que pour les photons, et $arrow(p) = m arrow(v)$ n'est valable que dans le cas *non relativiste* ($v <= 0.1c$)
])

== Nature ondulatoire de la matière

En mécanique classique on représente un électron par un corpuscule, mais cette représentation est incompatible avec les trous de Young : en effet on observe un phénomène d'interférence avec des électrons.

#theorem([Relation de de Broglie],[
  Pour toute particule de quantité de mouvement $p$ on a une longueur d'onde associée $lambda = h/p$ avec $h$ la constante de Planck
])

On prononce "de Broglie" comme "de Broille"

Les phénomènes quantiques sont observables quand les obstacles sont de l'ordre de la longueur d'onde de de Broglie, si jamais la longueur d'onde est trop petite devant la taille de l'obstacle on retrouve les lois classiques.

#pagebreak()

#counter(heading).update(0)

#set heading(numbering: "👩‍🔬 I.1.a")

#align(center, text([👩‍🔬 Fiches TP], weight: 800, size: 24pt))

#box(height: 1em)
#heading([Régression linéaire], supplement: [tp])

== Explication

La régression linéaire consiste à établir une relation linéaire entre une variable dépendante $y$ et une ou plusieurs variables indépendantes $x_1, dots, x_n$.

Pour cela, on utilise Python et les bibliothèques `numpy` et `matplotlib`.

== Comment faire?

=== Importer les bibliothèques

Pour importer les bibliothèques, on utilise la commande `import`.

```python
import numpy as np
import matplotlib.pyplot as plt
```

=== Créer les données

On considère les listes $X$ et $Y$ suivantes (ces données sont fictives et sont normalement issues d'une expérience réelle) :

```python
X = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
Y = [1, 2.4, 3.6, 4.8, 5.5, 6.5, 7.5, 8.5, 9.5, 10.5]
```

=== Tracer le nuage de points

En physique on ne relie jamais des points expérimentaux par des segments, mais on trace un nuage de points. Pour cela, on utilise la commande `plt.plot` avec `o` comme forme.

```python
plt.plot(X, Y, "o")
plt.label("X (unité)")
plt.ylabel("Y (unité)")

plt.show()
```

=== Réaliser la régression linéaire

Pour réaliser la régression linéaire, on utilise la commande `np.polyfit` qui prend en argument les listes $X$ et $Y$ ainsi que le degré du polynôme (ici 1 car on veut une droite).

```python
a, b = np.polyfit(X, Y, 1)
```

=== Tracer la droite de régression

Pour tracer la droite de régression, on utilise la commande `plt.plot` avec `--` comme forme.

Pour avoir des valeurs régulières en abscisse, on utilise la commande `np.linspace` qui prend en argument la valeur minimale, la valeur maximale et le nombre de valeurs voulues dans l'intervalle.

```python
# Si on veut laisser les points expérimentaux on utilise la commande suivante
plt.plot(X, Y, "o")

# Tracé de la droite de régression
list_x = np.linspace(min(X), max(X), 100) # 100 valeurs entre min(X) et max(X)
plt.plot(list_x, a * np.array(list_x) + b, "--")
plt.xlabel("X (unité)")
plt.ylabel("Y (unité)")

plt.show()
```

Il est ensuite possible de récupérer les coefficients de la droite de régression avec `a` et `b` et de les afficher.

```python
print("a = ", a)
print("b = ", b)
```

Il est bien sûr aussi possible de les récupérer de manière géométrique avec une règle.

#box(height: 1em)
#heading([Instruments d'optique], supplement: [tp])

== Viseur

Le viseur est un appareil optique composé de deux lentilles convergentes appelées objectif et oculaire, avec une réticule entre les deux.

L'intérêt du viseur est que tout objet que l'on voit net à travers le viseur est à une même distance, d'où on peut estimer la distance avec un objet.

== Lunette Astronomique

La lunette astronomique est un appareil optique composé de deux lentilles convergentes appelées objectif et oculaire. On a le foyer image de l'objectif qui est le foyer objet de l'oculaire.

#figure(image("physics/tp/lunette_astro.png", width: 70%))

Ainsi la lunette permet d'observer une image à l'infini, en la grandissant avec un grandissement $G$, et de renvoyer une image réelle à l'infini.

== Collimateur

Le collimateur est un appareil optique composé d'une source lumineuse et d'une lentille convergente. Il permet de rendre parallèle un faisceau lumineux.

Pour cela, on place la source lumineuse au foyer principal objet de la lentille convergente.

#box(height: 1em)
#heading([Auto-collimation], supplement: [tp])

== Principe

On a une source qui éclaire, les faisceaux lumineux passent par une lentille convergente et se réfléchissent sur un miroir plan. On place un écran dans le plan de l'objet (c'est à dire le plan de la source lumineuse).

== Réalisation

=== Montage

On effectue donc le montage expliqué précédemment.

L'intérêt de l'auto-collimation est de déplacer la lentille pour observer différents phénomènes.

=== Règle des $4f$

Comme vu dans le chapitre d'optique géométrique, on a la règle des $4f$ qui donne une condition pour observer une image.

Si cette condition est respectée, on dispose de 2 positions pour observer une image nette.

#box(height: 1em)
#heading([Euler], supplement: [tp])

== Présentation

La méthode d'Euler est une méthode de résolution numérique d'équations différentielles. Elle est basée sur le principe de la tangente à la courbe représentative de la solution de l'équation différentielle.

== Principe algorithmique

On considère une équation différentielle de la forme $y' = f(x, y)$, avec $f$ une fonction continue. On cherche à déterminer une fonction $y$ telle que $y' = f(x, y)$.

On divise l'intervalle $[t_"min", t_"max"]$ en $n$ sous-intervalles de longueur $Delta t$ (appelé pas de résolution). Et on a donc $t_k$ = $t_"min" + k * Delta t$.

On cherche à déterminer $y_k$ tel que $y_k$ = $y(t_k)$. Puisque l'on connaît $y_0$ (on connaît $y(t_"min")$), on peut déterminer tous les $y_k$ en utilisant la relation de récurrence suivante :

$ y_(k+1) = y_k + f(t_k, y_k) * Delta t $

== Exemple d'application

On considère la fonction `euler` suivante :

```python
def euler(F, y_0, tmin, tmax, dt):
    list_t = np.arange(tmin, tmax + dt, dt)
    N = len(list_t)
    y = np.zeros(N)

    y[0] = y_0

    for k in range(N - 1):
        y[k + 1] = y[k] + F(y[k], tmin + k * dt) * dt

    return list_t, y
```

On considère l'équation différentielle $y' = y$ avec $y(0) = 1$.

On a donc $f(x, y) = y$ et $y_0 = 1$.

On peut donc définir la fonction `F` suivante :

```python
def F(y, x):
    return y
```

On peut alors tracer la solution de l'équation différentielle sur l'intervalle $[0, 10]$ avec un pas de résolution de $0.1$ (valeurs prises pour l'exemple) :

```python
import matplotlib.pyplot as plt

t, y = euler(F, 1, 0, 10, 0.1)

plt.clf()
plt.figure()

plt.plot(t, y, ".") # On ne relie pas les points en physique
plt.xlabel("X (unité)")
plt.ylabel("Y (unité)")

plt.legend()

plt.show()
```

Il sera donc possible de visualiser l'allure de la solution de l'équation différentielle.

== Bonnes pratiques

Il faut toujours vérifier que le pas de résolution est suffisamment petit pour que la solution obtenue soit proche de la solution réelle.

Si le pas de résolution est trop grand, la solution obtenue sera très éloignée de la solution réelle.

Mais si le pas de résolution est trop petit, le temps de calcul sera très long.

Il faut donc trouver un compromis entre la précision de la solution et le temps de calcul.

#box(height: 1em)
#heading([Multimètre], supplement: [tp])

== Présentation

Le multimètre est un appareil de mesure qui permet de mesurer des grandeurs électriques telles que la tension, l'intensité ou la résistance. On appelle voltmètre la partie du multimètre qui permet de mesurer la tension, ampèremètre la partie qui permet de mesurer l'intensité et ohmmètre la partie qui permet de mesurer la résistance.

== Voltmètre

Pour mesurer la tension aux bornes d'un dipôle, il faut brancher le voltmètre en dérivation du dipôle.

Il faut brancher le $+$ sur la borne $Omega$ et le $-$ sur la borne $C O M$.

#figure(
  image("physics/tp/voltmeter.png", width: 30%)
)

Pour avoir une mesure correcte, il faut que le voltmètre ait une résistance interne très grande devant la résistance du dipôle. (Le voltmètre est modélisé par un interrupteur ouvert.)

Il est aussi possible d'ajuster le _RANGE_ du voltmètre pour avoir une mesure avec différents ordres de grandeur.

== Ampèremètre

Pour mesurer l'intensité qui traverse un dipôle, il faut brancher l'ampèremètre en série avec le dipôle.

Il faut brancher le $+$ sur la borne $m A$ (ou $mu A$) et le $-$ sur la borne $C O M$.

#figure(
  image("physics/tp/amperemeter.png", width: 30%)
)

Pour avoir une mesure correcte, il faut que l'ampèremètre ait une résistance interne très faible devant la résistance du dipôle. (L'ampèremètre est modélisé par un fil.)

Il est aussi possible d'ajuster le _RANGE_ de l'ampèremètre pour avoir une mesure avec différents ordres de grandeur.

#warning([Il est très important de faire attention aux valeurs maximales que peut mesurer l'ampèremètre. Si le courant est trop fort, l'ampèremètre peut être endommagé.])

== Ohmmètre

Pour mesurer la résistance d'un dipôle, il faut brancher l'ohmmètre en série avec le dipôle. Il faut que le dipôle ne soit pas alimenté.

Il faut brancher le $+$ sur la borne $Omega$ et le $-$ sur la borne $C O M$.

#figure(
  image("physics/tp/ohmmeter.png", width: 30%)
)

Il est aussi possible d'ajuster le _RANGE_ de l'ohmmètre pour avoir une mesure avec différents ordres de grandeur.

#warning([Il est primordial de ne pas alimenter le dipôle pour utiliser l'ohmmètre.])

#box(height: 1em)
#heading([Pont de Wheatstone], supplement: [tp])

== Présentation

Le pont de Wheatstone est un montage électrique utilisé pour mesurer une résistance inconnue. Il est composé de quatre résistances, dont une inconnue, et d'une source de tension. Il est utilisé dans de nombreux domaines, notamment en physique pour mesurer la résistance d'un conducteur, ou en médecine pour mesurer la résistance de la peau.

== Principe

Le principe du pont de Wheatstone est de mesurer la valeur de la résistance inconnue en équilibrant le pont. Pour cela, on utilise un voltmètre pour arriver à l'équilibre. On peut alors déterminer la valeur de la résistance inconnue à partir des valeurs des autres résistances.

== Montage

Le montage du pont de Wheatstone est le suivant :

#figure(
  image("physics/tp/wheatstone.png", width: 50%)
)

== Équilibre du pont de Wheatstone

Pour que le pont de Wheatstone soit équilibré, il faut que la tension aux bornes du voltmètre soit nulle. On a alors :

$ frac(R_v,X) = frac(R_1,R_2) $

== Mesure de la résistance inconnue

On peut alors déterminer la valeur de la résistance inconnue à partir des valeurs des autres résistances :

$ X = frac(R_2 R_v, R_1) $

#box(height: 1em)
#heading([Oscilloscope], supplement: [tp])

== Présentation

L'oscilloscope est un appareil de mesure qui permet de visualiser des signaux électriques. Il est composé d'un écran sur lequel on peut voir le signal, de boutons pour régler les paramètres de mesure et de sondes pour connecter l'oscilloscope au circuit à mesurer.

== Montage

=== Schématisation

L'oscilloscope se schématise donc par $arrow.t_1$, $arrow.t_2$ et une masse, chaque flèche représentant une voie de mesure.

Ici sur le schéma, la voie 1 mesure $E$ et la voie 2 mesure $U$ aux bornes du condensateur.

=== Spécificité

Le condensateur étant relié à la Terra, il est important de faire attention aux branchements notamment celui de la masse. C'est pour cette raison qu'on respectera le code couleurs des fils.

== Utilisation

=== Allumage et branchements

Quand on allume l'oscilloscope, les boutons vont clignoter. Il faut alors attendre que l'oscilloscope soit prêt, quand le bouton STOP est en vert.

Il est ensuite possible de braancher 2 voies et de les allumer ou non avec les boutons portant leur numéro.

=== Réglage horizontal

Il est possible d'ajouter un retard à l'oscilloscope en tournat le petit bouton "horizontal"

L'échelle est quand à elle changeable via le grand bouton "horizontal"

=== Réglage vertical

L'échelle verticale (soit celle de l'amplitude des signaux) est réglable avec le bouton au dessus de celui pour activer/désactiver une voie.

De même il est possible de translater une voie avec le bouton en dessous de chaque voie.

=== Seuil

Il y a une molette seuil permettant de changer la valeur seuil, c'est à dire la valeur pour stabiliser l'oscilloscope.

=== Curseurs

Le bouton CURSOR permet d'ajouter des curseurs sur les axes $X$ et $Y$ afin de faire des mesures précises, c'est notamment utile pour trouver une période ou un amplitude

=== Meas

La fonction MEAS permet de traiter directement dans l'oscilloscope, elle permet de trouver un déphasage, une amplitude ou une période sans avoir à s'embêter avec des curseurs.

Cette méthode est plus simple et plus précise.

=== Type d'acquisition

En TP on utilise normalement le mode d'acquision "normal" mais si l'oscilloscope a un comportement étrange il est possible d'utiliser la fonction de moyennage qui permet de lisser le signal.

A noter aussi que si l'oscilloscope est vraiment trop étrange, il est possible de le réinitialiser ou de le brancher sur une source externe (en utilisant un GBF par exemple).

#box(height: 1em)
#heading([Monte-Carlo], supplement: [tp])

== Présentation

En pratique en faisant des manipulations on a des incertitudes sur les mesures. La méthode Monte-Carlo permet de propager les distributions d'incertitudes sur les mesures pour obtenir une incertitude sur une grandeur finale.

== Procédé

=== Étape 1

On détermine au moins une valeur et son incertitude pour chaque grandeur mesurée (plus il y a de valeurs, plus la méthode est précise).

Ainsi pour chaque valeur on va postuler la distribution de probabilité de la valeur mesurée.

=== Étape 2

On génère un grand nombre de valeurs pour chaque grandeur mesurée en utilisant la distribution de probabilité postulée. On calcule alors la valeur de la grandeur finale pour chaque jeu de valeurs.

=== Étape 3

La valeur finale s'obtient donc avec la valeur moyenne des valeurs obtenues et l'incertitude s'obtient avec la largeur de la distribution obtenue.

== Et sur des régressions linéaires?

Pour une régression linéaire, on peut utiliser la méthode Monte-Carlo pour propager les incertitudes sur les valeurs mesurées et obtenir une incertitude sur les coefficients de la droite de régression.

=== Étape 1

Dans un premier temps, on détermine les valeurs et les incertitudes pour chaque grandeur mesurée.

On réalise ensuite une régression linéaire pour obtenir les coefficients de la droite de régression.

=== Étape 2

Par la méthode Monte-Carlo, on génère un grand nombre de valeurs pour chaque grandeur mesurée en utilisant la distribution de probabilité postulée.

De même, on génère un grand nombre de droites de régression en utilisant les valeurs générées pour chaque grandeur mesurée.

Enfin on calcule la valeur moyenne des coefficients de la droite de régression et l'incertitude sur ces coefficients.

C'est gagné!

#pagebreak()

#counter(heading).update(0)

#set heading(numbering: "📝 I.1.a")

#align(center, text([📝 Annexe], weight: 800, size: 24pt))

#box(height: 1em)
#heading([Analyse dimensionnelle], supplement: [annex])

== Système SI

La physique est dotée du système international d'unités qui permet de normaliser les unités utilisées en physique. On a ainsi les unités de base suivantes :

#align(center,
  table(
    columns: (180pt, 100pt, 100pt),
    rows: (18pt),
    align: center,
    [*Grandeur*],
    [*Unités SI*],
    [*Symbole*],
    [Distance],
    [Mètre ($unit("m")$)],
    $L$,
    [Masse],
    [Kilogramme ($unit("kg")$)],
    $M$,
    [Temps],
    [Seconde ($unit("s")$)],
    $T$,
    [Intensité électrique],
    [Ampère ($unit("A")$)],
    $I$,
    [Température],
    [Kelvin ($unit("K")$)],
    $Theta$,
    [Quantité de matière],
    [Mole ($unit("mol")$)],
    $N$,
    [Intensité lumineuse],
    [Candela ($unit("cd")$)],
    $J$,
  ),
)

Ainsi toute grandeur physique peut être décomposée en un produit de puissances de ces unités de base.

== Résoudre une équation de dimension

Avant d'écrire une équation, il est important de vérifier que les dimensions des deux membres de l'équation sont compatibles.

On ne peut pas additionner des grandeurs de dimensions différentes.

#warning([Il est important de vérifier les dimensions des grandeurs physiques pour éviter des erreurs de calcul, notamment à la fin du calcul pour vérifier l'homogénéité])

Mais on peut aussi trouver la dimension d'une grandeur en réalisant une équation de dimension.

Soit une grandeur $X$ dépendant potentiellement de $A$, $B$ et $C$.

On a alors $[X] = A^a B^b C^c$, or on sait que $X$ dépend de $Y$ et $Z$ de dimensions $[Y] = A B C^y$ et $[Z] = A^z B C$ tel que $X = Y/Z$

Ainsi en identifiant les dimensions on a $[X] = A^(1 - z) C^(y - 1)$

== Homogénéité

#align(center,
  table(
    columns: (160pt, 100pt, 100pt,100pt),
    rows: (30pt),
    align: center + horizon,
    [*Unité/Grandeur*],
    [*Unités SI*],
    [*Dimension*],
    [*Relation*],
    [Énergie $cal(E)$],
    [$unit("J")$],
    [$unit("kg m^2 s^-2")$],
    [$ E = m g h $],
    [Puissance $cal(P)$],
    [$unit("W")$],
    [$unit("kg m^2 s^-3")$],
    [$ P = E/t $],
    [Travail $cal(W)$],
    [$unit("J")$],
    [$unit("kg m^2 s^-2")$],
    [$ W = m g h $],
    [Intensité lumineuse $I$],
    [$unit("W/m^2")$],
    [$unit("kg s^-3")$],
    [$ I = P/S $],
    [Charge électrique $q$],
    [$unit("C")$],
    [$unit("A s")$],
    [$ Q = I t $],
    [Tension $U$],
    [$unit("V")$],
    [$unit("kg m^2 s^-3 A^-1")$],
    [$ U = P/I $],
    [Capacité $C$],
    [$unit("F")$],
    [$unit("kg^-1 m^-2 s^4 A^2")$],
    [$ C = Q/U $],
    [Résistance $R$],
    [$unit("Ohm")$],
    [$unit("kg m^2 s^-3 A^-2")$],
    [$ R = U/I $],
    [Inductance $L$],
    [$unit("H")$],
    [$unit("kg m^2 s^-2 A^-2")$],
    [$ L = U/ddt(I) $],
    [Conductivité électrique $sigma$],
    [$unit("S/m")$],
    [$unit("kg^-1 m^-3 s^3 A^2")$],
    [$ sigma = 1/R $],
    [Vecteur d'onde $k$],
    [$unit("m^-1")$],
    [$unit("m^-1")$],
    [$ k = (2 pi)/lambda $],
    [Position $x$],
    [$unit("m")$],
    [$unit("m")$],
    [$ x = x_0 + v t $],
    [Vitesse $v$],
    [$unit("m/s")$],
    [$unit("m/s")$],
    [$ v = ddt(x) $],
    [Accélération $a$],
    [$unit("m/s^2")$],
    [$unit("m/s^2")$],
    [$ a = ddt(v) $],
    [Quantité de mouvement $p$],
    [$unit("kg m/s")$],
    [$unit("kg m/s")$],
    [$ p = m v $],
    [Force $F$],
    [$unit("N")$],
    [$unit("kg m/s^2")$],
    [$ F = m g $],
    [Constante de raideur $k$],
    [$unit("N/m")$],
    [$unit("kg/s^2")$],
    [$ k = F/x $],
    [Constante de gravitation $cal(G)$],
    [$unit("m^3 kg^-1 s^-2")$],
    [$unit("m^3 kg^-1 s^-2")$],
    [$ F = G m M/r^2 $],
    [Permittivité magné. du vide $mu_0$],
    [$unit("H/m")$],
    [$unit("kg m s^-2 A^-2")$],
    [/],
    [Permittivité élec. du vide $epsilon_0$],
    [$unit("F/m")$],
    [$unit("kg^-1 m^-3 s^4 A^2")$],
    [/],
    [Moment cinétique $L$],
    [$unit("N m s")$],
    [$unit("kg m^2/s")$],
    [$ L = m v r $],
    [Moment d'une force $M$],
    [$unit("N m")$],
    [$unit("kg m^2/s^2")$],
    [$ M = r F $],
    [Moment d'inertie $I$],
    [$unit("J")$],
    [$unit("kg m^2")$],
    [$ I = m r^2 $],
    [Couple $Gamma$],
    [$unit("N m")$],
    [$unit("kg m^2/s^2")$],
    [$ Gamma = ddt(L) $],
    [Champ électrique $E$],
    [$unit("V/m")$],
    [$unit("kg m s^-3 A^-1")$],
    [$ E = U/d $],
    [Champ magnétique $B$],
    [$unit("T")$],
    [$unit("kg s^-2 A^-1")$],
    [$ E = mu dot B $],
    [Moment magnétique $mu$],
    [$unit("A m^2")$],
    [$unit("A m^2")$],
    [$ mu = I S $],
    [Constante de Planck $h$],
    [$unit("J s")$],
    [$unit("kg m^2 s^-1")$],
    [$ E = h f $],
    [Pression $P$],
    [$unit("Pa")$],
    [$unit("kg m^-1 s^-2")$],
    [$ P = F/S $],
    [Constante des gaz parfaits $R$],
    [$unit("J/mol/K")$],
    [$unit("kg m^2 s^-2 mol^-1 K^-1")$],
    [$ P V = n R T $],
    [Transfert thermique $Q$],
    [$unit("J")$],
    [$unit("kg m^2 s^-2")$],
    [$ Q = Delta U - W $],
    [Capacité thermique $C$],
    [$unit("J/K")$],
    [$unit("kg m^2 s^-2 K^-1")$],
    [$ Delta U = C Delta T $],
    [Enthalpie $H$],
    [$unit("J")$],
    [$unit("kg m^2 s^-2")$],
    [$ H = U + P V $],
    [Entropie $S$],
    [$unit("J/K")$],
    [$unit("kg m^2 s^-2 K^-1")$],
    [$ S_e = Q/T $],
    [Flux thermique $Phi$],
    [$unit("W")$],
    [$unit("kg m^2 s^-3")$],
    [$ Phi = ddt(Q) $],
    [Résistance thermique $R$],
    [$unit("K/W")$],
    [$unit("K/W")$],
    [$ R = Delta T/Phi $],
    [Conductivité thermique $lambda$],
    [$unit("W/m/K")$],
    [$unit("kg m s^-3 K^-1")$],
    [$ R = e/(lambda S) $],
    [Coefficient de transfert thq $h$],
    [$unit("W/m^2/K")$],
    [$unit("kg s^-3 K^-1")$],
    [$ Phi = h S Delta T $],
    [Enthalpie de chgt d'état $Delta h$],
    [$unit("J/kg")$],
    [$unit("kg m^2 s^-2")$],
    [$ Delta H = m Delta h + ... $],
    [Entropie de chgt d'état $Delta S$],
    [$unit("J/kg/K")$],
    [$unit("kg m^2 s^-2 K^-1")$],
    [$ Delta S = (m Delta h)/T $],
  ),
)

#box(height: 1em)
#heading([Incertitudes], supplement: [annex])

En physique les mesures sont souvent associées à des incertitudes sur ces dernières. Il est important de les propager pour pouvoir vérifier nos résultats et les confronter à la réalité.

On parle de *mesurande* pour la grandeur que l'on souhaite mesurer et de *mesurage* pour le processus de mesure.

Les erreurs peuvent être dues à des erreurs aléatoires (bruit des mesures) ou des erreurs systématiques (une erreur de montage par exemple)

== Incertitude type A

Une incertitude de type A correspond à une multiplication de mesure dans les mêmes conditions, on note $x_1, dots, x_n$ ces mesures

Ensuite on fait la moyenne $expval(x) = 1/N sum_(i=1)^n x_i$

Mais cette moyenne varie d'un échantillon à un autre donc $expval(x)$ possède aussi une incertitude :

#theorem([Incertitude d'une moyenne],[
  On a $ u(expval(x)) = sigma/sqrt(N) $
  l'incertitude sur cette moyenne avec $sigma = sqrt(1/(N - 1) sum (x_i - expval(x))^2)$ l'écart type expérimental 
])

Ainsi plus on réalise de mesures plus elle sera précise au final mais dans la pratique on ne réalise pas souvent des miliers de mesure donc on peut avoir recours à des méthodes de régression linéaires ou Monte Carlo

== Incertitude type B

Dans le cas des incertitudes de type B on détermine l'incertitude à partir des propriétés de l'outil qui servent à réaliser les mesures

Pour une règle on prendra une demi graduation

Pour une horloge qui bat la seconde on prendra $qty("0.5","s")$

De manière plus générale pour avoir l'incertitude d'un outil il est intéressant de prendre la notice

== Composer des incertitudes

On est souvent amenés à avoir plusieurs incertitudes sur une valeur finale ainsi il est intéressant de pouvoir composer des incertitudes

=== Somme d'incertitudes

Supposons que $x = a + b$ (ou $x = a - b$)

On a alors $u(x) = sqrt((u(a))^2 + (u(b))^2)$

=== Produit d'incertitudes

Supposons que $x = a b$ (ou $x = a/b$)

On a alors $u(x)/x = sqrt((u(a)/a)^2 + (u(b)/b)^2)$ souvent réécrite$u(x)= x sqrt((u(a)/a)^2 + (u(b)/b)^2)$

#warning([Il ne faut pas oublier le $x$ dans l'expression sinon on en perd tout son sens])

== Chiffres significatifs

On notera un résultat de mesure par $X = (x plus.minus Delta x)$ unité

On fera notamment attention à garder un nombre cohérent de chiffres significatifs avec les données de l'énoncé : on ne garde que le même nombre de chiffres significatifs que la valeur qui en a le moins dans l'énoncé.

De plus on n'arrondit jamais une incertitude à l'inférieur et on garde au maximum ou deux chiffres significatifs sur l'incertitude

#warning([On ne met jamais plus de chiffres significatifs à l'incertitude qu'à la valeur : ça n'as pas de sens!])

== Écart normalisé

Pour regarder la compatibilité d'une valeur on va regarder les intervalles de confiance et considérér *l'écart normalisé* ou *z-score*

#theorem([Expression de l'écart normalisé],
[On a $ z = abs(x_1 - x_2)/(sqrt(u(x_1)^2 + u(x_2)^2)) $])

Si $abs(z) > 1$ il y a $68%$ de chance que les valeurs soient incompatibles
Si $abs(z) > 2$ il y a $95%$ de chance que les valeurs soient incompatibles
Si $abs(z) > 3$ il y a $99%$ de chance que les valeurs soient incompatibles

Ainsi on comparera souvent cette valeur à $2$ pour avoir un intervalle de confiance à $95%$

#box(height: 1em)
#heading([Équations différentielles], supplement: [annex]) <equa>

En physique on est souvent amené à résoudre des équations différentielles pour modéliser des phénomènes physiques. On peut les résoudre de manière analytique ou numérique.

Une résolution numérique est réalisée avec la méthode d'Euler (voir les fiches TP).

== Équations linéaires d'ordre 1

#theorem([Équation différentielle linéaire d'ordre 1],[
  La forme générale d'une équation différentielle linéaire d'ordre 1 est $ y' + 1/tau y = y_infinity/tau $ avec $y_infinity$ une constante
])

On dit que $tau$ est le *temps caractéristique* du système.

#theorem([Forme générale de la solution],[
  La solution générale de cette équation est $ y(t) = y_infinity + A exp^(-t/tau) $
  avec $A$ obtenu par les conditions initiales
])

== Équations linéaires d'ordre 2

Dans le cadre d'un *oscillateur harmonique* on a :

#theorem([Équation différentielle linéaire d'ordre 2],[
  La forme générale d'une équation différentielle linéaire d'ordre 2 est $ y'' + omega_0^2 y = omega_0^2 y_infinity $ avec $y_infinity$ une constante
])

#warning([On fera attention au $+$ sans quoi l'oscillateur n'est pas harmonique])

On dit que $omega_0$ est la *pulsation propre* du système.

#theorem([Forme générale de la solution],[
  La solution générale de cette équation est $ y(t) = y_infinity + A cos(omega_0 t) + B sin(omega_0 t) $
  avec $A$ et $B$ obtenus par les conditions initiales
])

Dans le cas d'un *oscillateur amorti* on a :

#theorem([Équation différentielle linéaire d'ordre 2 amortie],[
  La forme générale d'une équation différentielle linéaire d'ordre 2 est $ y'' + omega_0/Q y' + omega_0^2 y = omega_0^2 y_infinity $ avec $y_infinity$ une constante
])

On dit que $Q$ est le *facteur de qualité* du système et $omega_0$ la *pulsation propre* du système.

Dans les systèmes avec beaucoup d'oscillations on a $Q$ le nombre d'oscillations avant l'arrêt.

Selon la valeur de $Q$ on a différents régimes :

- Si $Q < 1/2$ on a un *régime apériodique*

- Si $Q = 1/2$ on a un *régime critique*

- Si $Q > 1/2$ on a un *régime pseudo-périodique*

Ces différents régimes sont en fait liés au discriminant du polynôme caractéristique de l'équation différentielle, on retrouve donc le cadre des mathématiques.

=== Régime apériodique

#theorem([Régime apériodique],[
  Pour un régime apériodique on a $ y(t) = y_infinity + A e^(-t/tau_1) + B e^(-t/tau_2) $ avec $A$ et $B$ obtenus par les conditions initiales
])

On trouve $tau_1$ et $tau_2$ en résolvant le polynôme caractéristique de l'équation différentielle avec $tau_1 = -1/r_1$ et $tau_2 = -1/r_2$

=== Régime critique

#theorem([Régime critique],[
  Pour un régime critique on a $ y(t) = y_infinity + (A + B t )e^(-t/tau) $ avec $A$ et $B$ obtenus par les conditions initiales
])

On trouve $tau$ en résolvant le polynôme caractéristique de l'équation différentielle avec $tau = -1/r$

=== Régime pseudo-périodique

#theorem([Régime pseudo-périodique],[
  Pour un régime pseudo-périodique on a $ y(t) = y_infinity + (A cos(omega t) + B sin(omega t)) e^(-t/tau) $ avec $A$ et $B$ obtenus par les conditions initiales
])

On trouve $omega$ et $tau$ en résolvant le polynôme caractéristique de l'équation différentielle avec ses solutions $x = -1/tau plus.minus i omega$

#warning([On ne peut plus trouver $tau$ le temps caractéristique avec les méthodes qui seront développées ensuite, mais avec le décrément logarithmique])

== Résolution avec les complexes

On peut résoudre une équation différentielle en se souvenant que $ddt(underline(i)) = j omega underline(i)$

Ainsi on peut réécrire une équation différentielle sous forme complexe.

On rappelle aussi que $cos(omega t) = e^(j omega t)$ et $sin(omega t) = - omega e^(j omega t)$

Ainsi on peut obtenir l'expression de l'amplitude avec le module de la solution complexe et la phase avec l'argument de la solution complexe.

== Temps caractéristique

Il existe plusieurs manières de trouver le temps caractéristique

=== Méthode des tangentes

#graph(funcs: (
  x => 1 - calc.exp(-x),
  x => if (x < 1) { return x } else {return 1},
), domain: (0, 5), lines: (1, ))

Le point d'intersection de la tangente en $0$ avec la valeur finale donne le temps caractéristique

=== Méthode des 63%

#graph(funcs: (
  x => 1 - calc.exp(-x),
), domain: (0, 5), lines: (0.63, ))

Il est aussi possible de trouver le temps caractéristique en regardant le temps pour atteindre $63%$ de la valeur finale

=== Décrément logarithmique

Dans le cas d'un régime pseudo-périodique on peut aussi trouver le temps caractéristique avec le décrément logarithmique (voir chapitre sur le RSF)

== Autres équations

Si on a une équation qui ne rentre pas dans ce cadre :

- On peut essayer de la linéariser pour la résoudre

- On peut intégrer des deux côtés pour essayer de la résoudre

#box(height: 10pt)

#pagebreak()

#{
  counter(heading).update(0)
  set heading(numbering: none)
  heading([Table des matières])
  box(height: 0pt)
  show heading: none
  columns(2, outline(title: [Table des matières], indent: 10pt, fill: [], depth: 4))
  pagebreak(weak: true)
}