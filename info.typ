#set heading(numbering: "I.1.a")
#import "@local/unify:0.6.0": *
#import "@local/physica:0.9.3": *
#import "@local/cetz:0.2.2": *

// http://cdn.sci-phy.org/mp2i/poly_cours.pdf page 43

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
    #block(text(weight: 800, 30pt, "💻 Essentiel d'informatique"))
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

  align(center,image("info/logo.jpg", width: 50%))

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
          fill: if it.lang == "ocaml" or it.lang == "ml" { rgb("#fffcdf") } 
                else if it.lang == "python" or it.lang == "py" { rgb("#fffcdf") }
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
  title: "Essentiel Informatique",
  authors: (
    (name: "Victor Sarrazin", phone: ""),
  ),
  date: "2023/2024",
)

#align([_Bienvenue dans l'essentiel d'informatique de mes cours de prépa. Ce document a pour objectif de contenir l'intégralité des cours d'informatique afin de les condenser et de les adapter._

#align(right, text([_Bonne lecture..._]))])

#pagebreak()

#align(center, text([📋 Sommaire], weight: 800, size: 24pt))

#outline(depth:1,indent: 10pt, fill: [], title: "Introduction aux langages :", target: heading.where(supplement: [intro]))

#outline(depth:1,indent: 10pt, fill: [], title: "Structures de données :", target: heading.where(supplement: [struct]))

#outline(depth:1,indent: 10pt, fill: [], title: "Informatique théorique :", target: heading.where(supplement: [theory]))

#pagebreak()

#counter(heading).update(0)

#set heading(numbering: "👼 I.1.a")

#align(center, text([👼 Introduction], weight: 800, size: 24pt))

#box(height: 1em)
#heading([Introduction au C], supplement: [intro],)

== Variables

Pour définir une variable en C on a la syntaxe suivante : `type nom`

```c
int mango = 0;
```

Il est possible de définir plusieurs variables en même temps :

```c
int banana = apple = 12;
```

== Opérateurs

On a les opérations arithmétiques suivantes : 

#align(center, table(
  columns: (100pt, 140pt),
  align: center,
  [*Opération*],
  [*En C*],
  [Addition],
  [`a + b`],
  [Soustraction],
  [`a - b`],
  [Multiplication],
  [`a * b`],
  [Division],
  [`a / b`],
  [Modulo],
  [`a % b`]
))

On peut utiliser `+=`, `-=`, `*=`, `/=` et `%=` pour faire des opérations arithmétiques et des assignations

De plus on peut utiliser `++` et `--` pour incrémenter/décrémenter

Les comparaisons se font avec `>`, `>=`, `<=`, `<` et `==`.

On a des opérateurs binaires `&&` (et logique), `||` (ou logique) et `!` (négation de l'expression suivante)

#warning([
  Le `&&` est prioritaire sur le `||`
])

== Structures de contrôle

Pour exécuter de manière conditionnelle, on utilise `if (cond) {...} else if (...) {} ... {} else {}`

Ainsi le code suivant est valide :

```c
if (x == 1) {
  // Do code
} else if (x > 12) {
  // Do code bis
} else {
  // Do code ter
}
```

#warning([
  En C un $0$ est considéré comme `false` et toute autre valeur numérique `true`
])

Pour faire une boucle on peut utiliser un `while (cond) {}` qui exécute le code tant que la condition est valide

On peut utiliser `do {} while (cond)` qui exécute une fois puis tant que la condition est vérifiée

Il est aussi possible d'utiliser `for (...) {}`, de la manière suivante :

```c
// De 0 à n - 1
for (int i = 0; i < n; i++) {

}

// De 0 à n - 1 tant que cond
for (int i = 0; i < n && cond; i++) {

}
```

A noter qu'en C il est possible de modifier la valeur de `i` et donc de sortir plus tôt de la boucle

Il est possible de sortir d'une boucle avec `break`, ou de passer à l'itération suivante avec `continue`

== Fonctions

Pour définir une fonction on écrit :

```c
int my_func(int a, int b) {
  // Do code
  return 1;
}
```

Si on ne prend pas d'arguments on écrit `int my_func(void) {}` et si on ne veut rien renvoyer on utilise `void my_func(...) {}`

Ainsi pour appeller une fonction on fait :

```c
int resp = my_func(12, 14);
```

On peut déclarer une fonction avant de donner son code mais juste sa signature avec :

```c
int my_func(int);
```

== Tableaux en C

Le type d'un tableau en C est `type[]` ou `* type`

Pour initialiser un tableau on a les manières suivantes :

```c
int[4] test = {0, 1, 2, 3}; // Initialise un tableau de taille 4 avec 0,1,2,3
int[] test = {0, 1, 2, 3}; // Initialise un tableau avec 0,1,2,3 (avec 4 éléments)
int[4] test = {0}; // Initialise un tableau de taille 4 avec 0,0,0,0
```

Il n'est pas obligé de donner la taille d'un tableau elle sera déterminée au moment de l'exécution

#warning([
  Si on dépasse du tableau C ne prévient pas mais s'autorise à faire n'importe quoi
])

Pour affecter dans une case de tableau on fait :

```c
test[1] = test[2] // On met dans la case 1 la valeur de la case 2
```

#box(height: 1em)
#heading([Introduction au OCaml], supplement: [intro],)

#pagebreak()

#counter(heading).update(0)

#set heading(numbering: "🗂 I.1.a")

#align(center, text([🗂 Structures de données], weight: 800, size: 24pt))

#box(height: 1em)
#heading([Structures de données], supplement: [struct],)

#box(height: 1em)
#heading([Piles, files, dictionnaires], supplement: [struct],)

#box(height: 1em)
#heading([Arbres], supplement: [struct],)

#box(height: 1em)
#heading([Graphes], supplement: [struct],)

#pagebreak()

#counter(heading).update(0)

#set heading(numbering: "🖋 I.1.a")

#align(center, text([🖋 Informatique théorique], weight: 800, size: 24pt))

#box(height: 1em)
#heading([Bases], supplement: [theory],)

== Fonctions

On dit qu'une fonction a des *effets de bord* si son exécution a des conséquences sur d'autres choses que ses variables locales

Une fonction est *déterministe* si le résultat est toujours le même avec les mêmes arguments

Une fonction est dite *pure* lorsqu'elle est déterministe et sans effets de bord

== Algorithmes de tri

#box(height: 1em)
#heading([Récursion], supplement: [theory],)

#box(height: 1em)
#heading([Stratégies algorithmiques], supplement: [theory],)

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