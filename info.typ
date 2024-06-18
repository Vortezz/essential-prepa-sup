#set heading(numbering: "I.1.a")
#import "@local/unify:0.6.0": *
#import "@local/physica:0.9.3": *
#import "@local/cetz:0.2.2": *

// http://cdn.sci-phy.org/mp2i/Cours-A4.pdf 66

#let project(title: "", authors: (), date: none, body) = {
  set document(author: authors.map(a => a.name), title: "Essentiel d'informatique")
  
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
                else if it.lang == "sql" { rgb("#fcf7e8") } 
                else { luma(246) }, 
          width: 100%-3pt, 
          inset: 1em,
          stroke: stroke(cap: "round", thickness: 0.5pt),
          align(
            left, 
            stack(
              place(
                dx: 100%-9pt,
                dy: -3pt,
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

#let algos = state("algos", ())

#let algo(title, code) = {
  context {
    let value = here().position()
    algos.update(s => s + ((title, code.lang, value),))
  }
  code
}

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
  title: "Essentiel d'informatique",
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

#warning([
  Les variables sont copiées lors de l'appel de fonction
])

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
int[4] test = {0, 1}; // Initialise un tableau de taille 4 avec 0,1,0,0 (les autres valeurs sont à 0)
```

Il n'est pas obligé de donner la taille d'un tableau elle sera déterminée au moment de l'exécution

#warning([
  Si on dépasse du tableau C ne prévient pas mais s'autorise à faire n'importe quoi
])

Pour affecter dans une case de tableau on fait :

```c
test[1] = test[2] // On met dans la case 1 la valeur de la case 2
```

Pour faire des tableaux de tableaux on fait :

```c
int[4][4] test = {{0, 1, 2, 3}, {4, 5, 6, 7}, {8, 9, 10, 11}, {12, 13, 14, 15}}; // Initialise un tableau de taille 4x4 avec les valeurs
int[4][4] test ={ {0} }; // Initialise un tableau de taille 4x4 avec des 0
int [][4] test = { {0, 1, 2, 3}, {4, 5, 6, 7}, {8, 9, 10, 11} }; // Initialise un tableau de taille 3x4 avec les valeurs
```

Comme pour les tableaux on peut initialiser partiellement un tableau de tableaux

== Pointeurs

Toute variable en C est une adresse mémoire, on peut donc récupérer cette adresse avec `&` :

```c
int a = 12;
// b est l'adresse mémoire de a
int * b = &a;
```

Il est possible de récupérer la valeur d'une adresse mémoire avec `*` (*déréférencement*) :	

```c
int a = 12;
int * b = &a;
// c est la valeur de a
int c = *b;
```

On remarque donc que un pointeur a un type `type * var`

Il est aussi possible de prendre l'adresse d'un pointeur, ainsi on aura un `type ** var` (généralisable...)

Si on ne connaît pas l'adresse d'un pointeur on peut le déclarer avec `type * var = NULL`

#warning([
  Il ne faut SURTOUT PAS déréférencer un pointeur `NULL`, ou on aura une erreur de segmentation (segmentation fault)
])

Il est possible d'allouer de la mémoire avec `malloc` :

```c
int * a = malloc(sizeof(int));

int * tab = malloc(4 * sizeof(int)); // Alloue un tableau de 4 éléments

int * tab2 = malloc(4 * sizeof(*tab2)); // Alloue un tableau de 4 éléments
```

L'appel à `malloc` renvoie un pointeur, et un pointeur `NULL` si il n'y a pas assez de mémoire (il peut donc être judicieux de vérifier si le pointeur est `NULL` sur des grosses allocations)

L'appel à `sizeof` renvoie la taille en octets de l'élément passé en argument, on peut passer un type ou une variable.

Après utilisation de `malloc` il est important de libérer la mémoire avec `free` quand on a fini d'utiliser la mémoire :

```c
int * a = malloc(sizeof(int));

// Do code

free(a);
```

#warning([
  Il est important de libérer la mémoire après utilisation pour éviter les fuites mémoires (memory leaks) ou on finit avec un bluescreen
])

Il est ainsi possible de créer un tableau avec un malloc en modifiant la taille du tableau :

```c
int * tab = malloc(4 * sizeof(int)); // Alloue un tableau de 4 éléments
```

On pourra donc utiliser `tab[0]`, `tab[1]`, `tab[2]` et `tab[3]`...

Quand on passe un tableau à une fonction on passe un pointeur, ainsi on peut modifier le tableau dans la fonction

#warning([
  Ainsi une fonction NE PEUT renvoyer un tableau créé normalement, il faut ABSOLUMENT renvoyer un tableau qui a été alloué avec `malloc`
])

Les tableaux, et notamment les cases des tableaux étant des pointeurs, on peut récupérer l'adresse d'une case de tableau avec `&` :

```c
int tab[4] = {0, 1, 2, 3};

int * a = &tab[2]; // a est l'adresse de la case 2
```

Il est intéressant de noter que `tab[2]` est équivalent à `*(tab + 2)` mais que l'arithmétique des pointeurs n'est pas au programme et qu'elle permet d'avoir des erreurs plus facilement

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

== Recherche de plus cours chemin

=== Graphes avec poids négatifs

// DO Floyd Marchall et Djikstra rapidement

Dans un graphe on dit que l'arc $u triangle v$ est en *tension* si $delta(v) > delta(u) + w(u,v)$

L'approche de Ford est donc d'éliminer les arcs en tension

Tant qu'il existe des arcs en tension, on traite tous les arcs de $E$ et on traite ceux en tension, on a donc une complexité $O(n times p)$

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

== Complexité

On dit qu'un algorithme est en $O (f(n))$ *pire cas* si il existe une constante $k$ telle que pour tout $n$ assez grand, le nombre d'opérations est inférieur à $k f(n)$

On dit qu'un algorithme est en $Omega(f(n))$ *meilleur cas* si il existe une constante $k$ telle que pour tout $n$ assez grand, le nombre d'opérations est supérieur à $k f(n)$

On dit qu'un algorithme est en $Theta(f(n))$ *cas moyen* si il est en $O(f(n))$ et en $Omega(f(n))$

On parle alors :

- $O(1)$ pour une complexité *constante*

- $O(log(n))$ pour une complexité *logarithmique*
- $O(n)$ pour une complexité *linéaire*
- $O(n log(n))$ pour une complexité *quasi-linéaire*
- $O(n^2)$ pour une complexité *quadratique*
- $O(k^n)$ pour une complexité *exponentielle*

== Algorithmes de tri

En informatique on a souvent besoin de trier des listes, on a plusieurs algorithmes pour cela

#theorem([Tri stable],[
  Un tri est dit *stable* si l'ordre des éléments égaux est conservé
])

=== Tri par sélection

Le par sélection est l'algorithme le plus simple de tri, on prend le minimum et on le met en tête de liste.

Ainsi on a un invariant de boucle : la liste est triée jusqu'à l'indice $i$

Pour l'implémenter en C on fait :

#algo([Tri par sélection],
```c
void selection_sort(int arr[], int n) {
  for (int i = 0; i < n; i++) {
    // Les i premiers éléments sont bien triés
    int min_i = i;

    for (int j = i+1; j<n; j++) {
      if (arr[j] < arr(min_i)) {
        min_i = j;
      }
    }

    // On échange les éléments en i et min_i
    int tmp = arr[i];
    arr[i] = arr[min_i];
    arr[min_i] = tmp;
  }
}
```)

Le tri par sélection est en $O(n^2)$, on a $n$ comparaisons pour le premier élément, $n-1$ pour le second, etc.

Le tri par sélection a donc comme inconvéniant d'avoir une complexité quadratique et de ne pas être stable

=== Tri bulle

Le tri bulle est un algorithme de tri simple, on compare les éléments deux à deux et on les échange si ils ne sont pas dans le bon ordre, comme des bulles qui remontent à la surface

On peut réaliser un tri pierre en descendant les éléments au lieu de les monter

Pour l'implémenter en C on fait :

#algo([Tri bulle],```c
let bubble_sort(int arr[], int n) {
  for (int i = 0; i < n; i++) {
    // Les i premiers éléments sont bien passés
    int k_last_perm = n-1;
    int smallest = arr[n-1];

    for (int j = n-1; j > i; j--) {
      if (arr[j-1] <= smallest) {
        // On change de bulle
        arr[j] = smallest;
        smallest = arr[j-1];
      } else {
        // On fait descendre la bulle
        arr[j] = arr[j-1];
        k_last_perm = j - 1;
      }
    }

    arr[i] = smallest;
    // On n'a pas besoin de regarder les éléments entre i+1 et k_last_perm car on n'a fait aucune modification
    i = k_last_perm + 1;
  }
}
```)

Le tri bulle a une complexité en $O(n^2)$, on a $n$ comparaisons pour le premier élément, $n-1$ pour le second, etc, mais cette complexité est rarement atteinte. De plus le tri bulle est stable

=== Tri par insertion

Le tri par insertion est un algorithme de tri qui consiste à insérer un élément à sa place dans une liste triée (les éléments précédents sont déjà triés mais pas forcément à leur place définitive)

Pour l'implémenter en C on fait :

#algo([Tri par insertion],```c
int insertion_sort(int arr[], int n) {
  for (int i = 0; i < n; i++) {
    // Les i premiers éléments sont bien triés
    int j = i;
    int elem = arr[i];

    for (; j>0 && elem < arr[j-1]; j--) {
      arr[j] = arr[j-1];
    }

    arr[j] = elem;
  }
}
```)

Le tri par insertion a une complexité en $O(n^2)$, on a $n$ comparaisons pour le premier élément, $n-1$ pour le second, etc, mais cette complexité est rarement atteinte. De plus le tri par insertion est stable

=== Tri rapide

Le tri rapide est un algorithme de tri qui consiste à choisir un pivot et à partitionner la liste en deux parties, les éléments plus petits que le pivot et les éléments plus grands que le pivot, on réitère sur les deux listes

Pour l'implémenter en C on fait :

#algo([Tri rapide],```c
void quick_sort(int * arr, int n) {
  if (n <= 1) { // Déjà trié
    return;
  }

  int pivot = partition(arr, n);
  quick_sort(arr, pivot);
  quick_sort(&arr[pivot+1], n-pivot-1);
}
```)

Tout l'intérêt du tri rapide est dans la fonction `partition` qui permet de partitionner la liste en deux parties

#todo(text: [(Écrire la fonction partition)])

== Algorithmes classiques

=== Dichotomie

La dichotomie est un algorithme de recherche efficace : on prend le milieu de la liste et on regarde si l'élément est plus grand ou plus petit, on réitère sur la moitié de la liste etc...

Pour l'implémenter en C on fait de manière récursive :

#algo([Dichotomie (Récursive)],```c
let index(int * arr, int n, int elem) {
  if (n == 0) {
    return -1; // On ne peut pas trouver
  }

  int m = n/2;

  if (arr[m] == elem) { // On a trouvé!
    return m;
  } else if (arr[m] > m) { // L'élément se situe peut être dans la partie gauche
    return index(arr, m, elem);
  } else { // L'élément se situe peut être dans la partie droite
    int idx = index(&arr[m+1], n-m-1, elem);

    if (idx != -1) {
      idx += m+1;
    }

    return idx;
  }
}
```)

On peut aussi faire de manière itérative :

#algo([Dichotomie (Impérative)],```c
let index(int * arr, int n, int elem) {
  int l = 0, r = n;

  while (l < r) { // On recherche dans le tableau avec deux compteurs
    int m = (l+r)/2;

    if (arr[m] == val) { // On a trouvé!
      return m;
    } else if (arr[m] > m) { // L'élément se situe peut être dans la partie gauche
      r = m;
    } else { // L'élément se situe peut être dans la partie droite
      l = m + 1;
    }
  }

  return -1; // Pas trouvé!
}
```)

L'avantage de la dichotomie est qu'elle a une complexité en $O(log(n))$ : elle permet donc une recherche efficace

#box(height: 1em)
#heading([Récursion], supplement: [theory],)

#box(height: 1em)
#heading([Stratégies algorithmiques], supplement: [theory],)

== Algorithmes gloutons

== Diviser pour régner

Le *tri fusion* est un tri en $Theta (n log(n))$, on sépare les listes puis on les trie en interne et on fusionne les deux listes triées

Pour l'implémenter en OCaml on fait :

#algo([Tri fusion],
```ml
let rec partition = function
  | h1::h2::t -> let l,r = partition t in h1::l, h2::r
  | lst -> lst, [];;

let rec merge l1 l2 = match l1,l2 with
  | (h1::t1), (h2::t2) when h1 <= h2 -> h1::(merge t1 l2)
  | (h1::t1), (h2::t2) -> h2::(merge l1 t2)
  | l1, [] -> l1;; 

let rec fusion_sort lst = match split lst with
  | lst, [] -> lst
  | l1, l2 -> merge (fusion_sort l1) (fusion_sort l2)
```)

Analysons l'algorithme du tri fusion, en regardant le nombre de comparaisons on retrouve une complexité en $Theta (n log(n))$ pour ces étapes

Plus mathématiquement on a pour $n >= 2$, $u_floor(n/2) + u_ceil(n/2) + n/2 <= u_n <= u_floor(n/2) + u_ceil(n/2) + n$ d'où on a $u_n = u_floor(n/2) + u_ceil(n/2) + Theta (n)$

#todo(text: [(Suites récurrentes d'ordre 1)])

#theorem([Suites "diviser pour régner"],[
  Soit $a_1, a_2$ deux réels positifs vérifiant $a_1 + a_2 >= 1$ et $(b_n)_(n in NN)$ une suite positive et croissante et $(u_n)_(n in NN)$ une suite vérifiant :

  $ u_n = a_1 u_floor(n/2) + a_2 u_ceil(n/2) + b_n $

  Ainsi en posant $alpha = log_2 (a_1 + a_2)$, on a :

  - Si $(b_n) = Theta (n^alpha)$, alors $(u_n) = Theta(n^alpha log(n))$
  - Si $(b_n) = Theta (n^beta)$ avec $beta$ < $alpha$, alors $(u_n) = Theta(n^alpha)$
  - Si $(b_n) = Theta (n^beta)$ avec $beta$ > $alpha$, alors $(u_n) = Theta(n^beta)$
])

#warning([A savoir que si on retombe sur une relation de récurrence connue on peut donner directement la complexité])

Pour l'implémenter en C on fait de la manière suivante :

#todo(text: [(Réecrire)])

#algo([Tri fusion],```c
```)

#box(height: 1em)
#heading([SQL], supplement: [theory],)

== Généralités

En SQL on stocke des entités avec des attributs et à chaque attribut on lui associe un type

On peut définir des relations entre les différentes entités

On stocke ces entités dans des tables : dans chaque table on stocke une entité

Il est possible de garder une case vide en plaçant un `NULL` dans la case

== Requêtes

Pour récupérer des données (projections) dans une table on a :

```sql
# Seulement les colonnes spécifiées
SELECT col1, ..., coln FROM table

# Toutes les colonnes
SELECT * FROM table

# Toutes les colonnes mais sans doublon
SELECT DISTINCT * FROM table
```

Ainsi on récupère toutes les lignes de la table avec ces projections

On peut aussi faire une sélection sur un critère :

```sql
SELECT * FROM table WHERE bool
```

Les opérations booléennes sont les suivantes :

- `col > a`/`col < a`/`col = a` pour faire des comparaisons
- `col IN (a, b, c)` pour savoir si la cellule est dans un ensemble de valeur
- `col IS NULL`/`IS NOT NULL` pour savoir si la cellule est nulle ou non
- `col LIKE '% Text %'` pour regarder si `Text` est dans la chaine de caractère de la cellule

On peut combiner les critères avec `AND`/`OR`/`NOT`

Il est possible de sélectionner un attribut non projeté

Pour ordonner les résultats on ordonne en utilisant

```sql
# Triés par valeur croissante
SELECT * FROM table ORDER BY col

# Triés par valeur décroissante
SELECT * FROM table ORDER BY col DESC
```

Pour limiter le nombre de valeurs on utilise

```sql
# On prend au maximum 3 éléments
SELECT * FROM table LIMIT 3

# On prend au maximum 3 éléments mais sans les 2 premiers
SELECT * FROM table LIMIT 3 OFFSET 2
```
== Fonctions

On peut compter le nombre d'entités qui vont être renvoyées

```sql
# Nombre d'éléments dans la table
SELECT COUNT(*) FROM table
```

On peut compter sur une colonne spécifique avec `COUNT(col1, ..., col2)`, les cases ne sont pas comptées si `NULL`, 

Il est aussi possible de compter le nombre de valeur distinctes pour une colonne :

```sql
SELECT COUNT(DISTINCT col) FROM table
```

On peut utiliser `MAX`, `MIN`, `SUM` et `AVG` pour avoir du préprocessing, il est aussi possible d'avoir la moyenne en faisant `SUM(col)/COUNT(*)`

#warning([On ne peut mélanger une colonne et une fonction dans la projection])

Il est possible de grouper les valeurs

```sql
# Renvoie des groupes des valeurs de col
SELECT col FROM table GROUP BY col
```

#warning([Il n'est pas possible d'utiliser `GROUP BY` sur des colonnes non groupées])

Par contre les fonctions agissent sur chaque groupe, ainsi il est possible d'écrire 

```sql
# Renvoie des groupes des valeurs de col avec le nombre d'occurence de cette valeur dans la table
SELECT col, COUNT(*) FROM table GROUP BY col
```

Pour sélectionner des groupes on peut utiliser :

```sql
# Renvoie des groupes des valeurs de col si la valeur minimale du groupe dans la colonne col2 est supérieure à x avec la valeur minimale de col2 de ce groupe dans la table
SELECT col1, MIN(col2) FROM table GROUP BY col1 HAVING MIN(col2) > x
```

Les opérations sont executées dans cet ordre :

- `WHERE`
- `GROUP BY`
- `HAVING`
- `ORDER BY`
- `LIMIT`/`OFFSET`
- `SELECT` à la fin bien qu'on le mette en tête de la requête

Ainsi une clause valide est

```sql
SELECT * WHERE cond GROUP BY col HAVING cond2 ORDER BY col2 LIMIT 3 OFFSET 2
```

== Sous requêtes

Il est possible d'écrire une sous requête :

```sql
# Ici on sélectionne seulement les éléments donc la valeur col est supérieure à la valeur moyenne de col
SELECT * FROM table WHERE col > (SELECT AVG(col) FROM table)
```

Il est donc aussi possible d'utiliser cette syntaxe avec des `IN`

```sql
# Ici on va sélectionner seulement les lignes dont la valeur de col correspond à la condition cond
SELECT * FROM table WHERE col IN (SELECT DISTINCT col FROM * WHERE cond)
```

Le `col AS nameBis` permet de renommer une colonne

Si on reçoit un tableau, on peut sélectionner dans les réponses

```sql
# Ainsi on renvoie la moyenne d'une colonne col2 telle que ses éléments vérifient la condition
SELECT AVG(resp.colName) FROM (SELECT col1, col2 AS colName FROM table WHERE cond) AS resp
```

== Combiner les tables

Il est possible de combiner des tables

```sql
# Sélectionne dans le produit cartésien des deux tables
SELECT * FROM table1, table2
```

Mais en faisant ça on va avoir plein de lignes qui n'ont pas de sens, ainsi si on veut garder seulement les lignes qui nous intéressent

```sql
# Sélectionne dans le produit cartésien des deux tables seulement les éléments donc la col1 de la table 1 est le même que celui de la col 2 de la table 2
SELECT * FROM table1, table2 WHERE table1.col1 = table2.col2
```

Mais pour éviter ça on peut aussi de manière équivalente écrire :

```sql
# On sélectionne les éléments de la table1 en ajoutant la table2 si la condition est vérifiée, le ON est donc un WHERE
SELECT * FROM table1 JOIN table2 ON table1.col1 = table2.col2
```

Le produit cartésien n'est donc qu'une manière de jointure

On peut aussi utiliser le `LEFT JOIN` qui permet de garder un élément de la première table même si il n'a pas d'équivalent dans la seconde table

```sql
# On sélectionne les éléments de la table1 en concaténant les éléments dont la condition est vérifiée, et rien si il n'y a pas d'équivalent
SELECT * FROM table1 LEFT JOIN table2 ON table1.col1 = table2.col2
```

On peut faire l'union de deux requêtes

```sql
# On a les éléments qui vérifient la cond1 ou cond2
SELECT * FROM table WHERE cond1 UNION SELECT * FROM table WHERE cond2
```

#warning([Pour utiliser l'union il faut juste que les types sont compatibles mais pas les noms de colonne])

On peut aussi faire l'intersection de deux requêtes

```sql
# On a les éléments qui vérifient la cond1 et cond2
SELECT * FROM table WHERE cond1 INTERSECT SELECT * FROM table WHERE cond2
```

On peut faire des différences ensemblistes avec `MINUS` ou `EXCEPT`

== Créer une BDD

Pour créer une base de données on utilisera 

```sql
CREATE TABLE IF NOT EXISTS table (
  col1 TYPE1,
  col2 TYPE2,
  col3 TYPE3
)
```

Si on veut limiter le nombre de caractères, on peut le préciser entre parenthèses, par exemple `VARCHAR(6)` pour avoir des chaînes d'au plus 6 caractères

On peut définir une *clé primaire* qui ne peut avoir 2 fois la même valeur, on indiquera `PRIMARY KEY` après le type :

```sql
CREATE TABLE IF NOT EXISTS table (
  col1 TYPE1 PRIMARY KEY,
  ...
)
```

Les autres attibuts seront dépendant de la clé primaire : si on connaît la clé primaire on peut connaître les autres valeurs associées à la liste

Si on a une clé primaire dans un GROUP BY autorise à projeter sur tous les éléments (pas comme précédemment)

Il y a au plus une clé primaire par table, et une valeur `NULL` ne peut être une valeur pour cette case

On peut définir un clé étrangère qui vont être des liens entre les différentes tables

```sql
CREATE TABLE IF NOT EXISTS table (
  ...,
  FOREIGN KEY (col) REFERENCES table(col)
)
```

Il est aussi possible de modifier une table en utilisant `ALTER TABLE`

Pour insérer dans une table on utilise :

```sql
INSERT INTO table (col1, col2, col3) VALUES (value1, value2, value3)
```

On peut modifier un élement :

```sql
UPDATE table SET col1 = value WHERE cond
```

On peut aussi supprimer un élement :

```sql
DELETE FROM table WHERE cond
```

== Type entités

Les types entités sont liées par des types associations

#todo(text:[(Cardinalité)])

On précise les cardinalités :

- $1,1$ en liaison avec une et une seule entité

- $1,n$ en liaison avec au moins une autre entité

- $0,1$ en liaison avec au plus une autre entité

- $0,n$ en liaison avec un nombre quelconque d'entités

#counter(heading).update(0)
#set heading(numbering: none)

#pagebreak()

#context {
  heading([Liste d'algorithmes])
  columns(2, 
    for a in algos.final() {
      link(a.at(2), 
        box(
          grid(columns: 4, 
            align(left, 
              box(width: 100%, 
                grid(columns: 3, 
                  a.at(0), 
                  box(width: 4pt), 
                  image("global/languages/" + a.at(1) + ".svg", width: 10pt)
                )
              ) 
            ), 
            box(width: 0%), 
            align(right, [#a.at(2).page])
          ), 
        width: 100%))
    } 
  )
}

#pagebreak()

#{
  heading([Table des matières])
  box(height: 0pt)
  show heading: none
  columns(2, outline(title: [Table des matières], indent: 10pt, fill: [], depth: 4,target: heading.where(bookmarked: auto)))
  pagebreak(weak: true)
}