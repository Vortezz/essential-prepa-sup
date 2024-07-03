#set heading(numbering: "I.1.a")
#import "@local/unify:0.6.0": *
#import "@local/physica:0.9.3": *
#import "@local/cetz:0.2.2": *

// http://cdn.sci-phy.org/mp2i/poly_cours.pdf page 43

#let project(title: "", authors: (), date: none, body) = {
  set document(author: authors.map(a => a.name), title: "Essentiel d'anglais")
  
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
    #block(text(weight: 800, 30pt, "🌍 Essentiel d'anglais"))
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

  align(center,image("english/logo.jpg", width: 70%))

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

#let example(t) = box(
  stroke: (
    left: 5pt + gray,
  ),
  box(
    inset: (
      left: 1em,
      top: 4pt,
      bottom: 4pt,
    ),
    align(left, [#text("Exemple :", weight: "bold", luma(56.7%)) \ #text(t, luma(56.7%))])
  ),
)

#let example(t) = box(
    radius: 4pt, 
    fill: luma(56.7%),
    width: 100%,
    align(
      right, 
        block(
          radius: 4pt, 
          fill: luma(95%),
          width: 100%-3pt, 
          inset: 1em,
          stroke: stroke(cap: "round", thickness: 0.5pt, paint: luma(56.7%)),
          align(left, [#text([Exemple :], weight: "bold") \ #t])
          ),
      ),
    );

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
  title: "Essentiel Anglais",
  authors: (
    (name: "Victor Sarrazin", phone: ""),
  ),
  date: "2023/2024",
)

#align([_Bienvenue dans l'essentiel d'anglais de mes cours de prépa. Ce document a pour objectif de contenir des cours d'anglais notamment de grammaire ainsi que des exemples pour les oraux et écrits. Il est rédigé en français pour avoir plus de cohérence avec les autres essentiels._

#align(right, text([_Bonne lecture..._]))])

#pagebreak()

#align(center, text([📋 Sommaire], weight: 800, size: 24pt))

#outline(depth:1,indent: 10pt, fill: [], title: "Conjugaison :", target: heading.where(supplement: [conjug]))

#outline(depth:1,indent: 10pt, fill: [], title: "Grammaire :", target: heading.where(supplement: [grammar]))

#outline(depth:1,indent: 10pt, fill: [], title: "Épreuves :", target: heading.where(supplement: [tests]))

#outline(depth:1,indent: 10pt, fill: [], title: "Exemples :", target: heading.where(supplement: [ex]))

#pagebreak()

#counter(heading).update(0)

#set heading(numbering: "📃 I.1.a")

#align(center, text([📃 Conjugaison], weight: 800, size: 24pt))

#box(height: 1em)
#heading([Temps simples], supplement: [conjug],)

== Present simple

En anglais on utilise le _present simple_ pour décrire des actions factuelles, des vérités, pour exprimer des goûts ou pour décrire.

On emploie le _present simple_ avec des adverbes qui marquent la routine :

- _every day_ : chaque jour
- _every month_ : chaque mois
- _always_ : toujours
- _never_ : jamais
- _generally_ : généralement
- _usually_ : habituellement

La forme affirmative se forme avec *sujet + base verbale + complément*, et la base verbale correspond à l'infinitif mais sans la particule _to_

A la troisième personne du singulier, on met un _-s_ ou un _-es_ derrière la base verbale si le verbe finit en _-o_, _-x_, _-s_ ou _-ch_

#example([*to go* devient *he goes*])

Si le verbe finit par un _-y_ on enlève ce _-y_ et on place un _-ies_ à la troisième personne du singulier

#example([*to cry* devient *he cries*])

La forme négative se forme avec *sujet + do/does + not + base verbale + complément*. Les particules _do not_ et _does not_ peuvent se contracter en _don't_ et _doesn't_

A noter que c'est le _does_ qui prend la marque de la troisième personne et non la base verbale

#example([*He does not cry*])

Une phrase interrogative avec le _present simple_ se forme avec *do/does + sujet + base verbale*, ainsi on intervertit le verbe et l'auxiliaire _do_

#example([*to cry* devient *Does he cry?*])

== Prétérit (Past Simple)

Le prétérit renvoie à des évènements finis sans lien avec le présent, on l'utilise pour raconter un récit au passé ou une histoire

On utilise les marqueurs de temps suivant :

- _last year_ : l’année dernière
- _one month ago_ : il y a un mois
- _a long time ago_ : il y a longtemps
- _once upon a time_ : il était une fois

La forme affirmative du prétérit se forme de la manière suivante *sujet + base verbale -ed + complément*

#example([She work#text[*ed*] hard])

#warning([Beaucoup de verbes comme _to take_ sont irréguliers en anglais, ainsi il est important de les connaître (voir #todo())])

La forme négative du prétérit se forme avec *sujet + did not + base verbale + complément*. _Did not_ peut se contracter en _didn't_.

#example([
  He *did not* answer the phone
])

La forme interrogative se forme avec *did + sujet + base verbale + complément*

#example([
  *Did* you talk with her yesterday?
])

== Future simple

Le _future simple_ exprime un élément factuel du futur

La forme affirmative du _future simple_ se forme avec *sujet + will + base verbale + complément*. Le _will_ peut être contracté en _'ll_.

#example([
  I *will* do that later _ou_ I*'ll* do that later
])

La forme négative du _future simple_ se forme avec *sujet + will + not + base verbale + complément*. Le _will not_ peut être contracté en _wont_.

#example([
  I *will not* do that later _ou_ I *wont* do that later
])

La forme interrogative se forme avec *will + sujet + base verbale + complément*

#example([
  *Will* you walk tomorrow?
])

#box(height: 1em)
#heading([Temps continuous], supplement: [conjug],)

Les temps _continuous_ sont utilisés pour exprimer des actions au cours de déroulement au cours de l'énonciation

Dans les temps continuous on utilisera l'auxiliaire _be_

Le participe présent est la forme en *-ing* d'un verbe

Si le verbe finit par un couple voyelle-consonne, on double la consonne puis ont ajoute _-ing_.

#example([
  *to swim* devient *swimming*
])

De manière générale les verbes d'états et de perception ne se mettent pas à la forme continue

== Present continuous

On utilise le _present continuous_ pour des actions en cours de déroulement dans le présent

Sa forme affirmative se forme de la manière suivante *sujet + be* (au présent) *+ base verbale -ing + complément*

#example([
  I *am* walk#text([*ing*])
])

Sa forme négative se forme de la manière suivante *sujet + be* (au présent) *not + base verbale -ing + complément*

#example([
  I *am not* walk#text([*ing*])
])

Sa forme interrogative se forme de la manière suivante *be* (au présent) *sujet + base verbale -ing + complément*

#example([
  *Am* I walk#text([*ing*])?
])

== Past continuous

On utilise le _past continuous_ pour des actions en cours de déroulement dans le passé

Sa forme affirmative se forme de la manière suivante *sujet + be* (au passé) *+ base verbale -ing + complément*

#example([
  He *was* walk#text([*ing*])
])

Sa forme négative se forme de la manière suivante *sujet + be* (au passé) *not + base verbale -ing + complément*

#example([
  Here *was not* walk#text([*ing*])
])

Sa forme interrogative se forme de la manière suivante *be* (au passé) *+ sujet + base verbale -ing + complément*

#example([
  *Was* he walk#text([*ing*])?
])

== Future continuous

On utilise le _future continuous_ pour des actions en cours de déroulement dans le futur

Sa forme affirmative se forme de la manière suivante *sujet + will be + base verbale -ing + complément*

#example([
  He *will be* walk#text([*ing*])
])

Sa forme négative se forme de la manière suivante *sujet + will not be + base verbale -ing + complément*

#example([
  He *will not be* walk#text([*ing*])
])

Sa forme interrogative se forme de la manière suivante *will + sujet + be + base verbale -ing + complément*

#example([
  *Will* he *be* walk#text([*ing*])?
])

#box(height: 1em)
#heading([Temps perfect], supplement: [conjug],)

Les temps _perfect_ créent une connexion entre le moment de l'énonciation

Ainsi la principale différence entre les temps _perfect  continuous_ et les temps _perfect simple_ sont que l'action est toujours au cours durant les 

== Present perfect simple

On utilise le *present perfect simple* pour des actions qui ont commencé dans le passé et qui ont un lien avec le présent

Sa forme affirmative se forme de la manière suivante *sujet + have/has + participe passé + complément*

#example([
  I *have* walk#text([*ed*])
])

Sa forme négative se forme de la manière suivante *sujet + have/has + not + participe passé + complément*

#example([
  I *have not* walk#text([*ed*])
])

Sa forme interrogative se forme de la manière suivante *have/has + sujet + participe passé + complément*

#example([
  *Have* I walk#text([*ed*])?
])

== Present perfect contineous

On utilise le *present perfect continuous* pour des actions qui ont commencé dans le passé et qui sont toujours en cours

Sa forme affirmative se forme de la manière suivante *sujet + have/has + been + base verbale -ing + complément*

#example([
  I *have been* walk#text([*ing*])
])

Sa forme négative se forme de la manière suivante *sujet + have/has + not + been + base verbale -ing + complément*

#example([
  I *have not been* walk#text([*ing*])
])

Sa forme interrogative se forme de la manière suivante *have/has + sujet + been + base verbale -ing + complément*

#example([
  *Have* I been walk#text([*ing*])?
])

== Past perfect simple

On utilise le *past perfect simple* pour une action qui a eu lieu avant une autre action dans le passé

Sa forme affirmative se forme de la manière suivante *sujet + had + participe passé + complément*

#example([
  I *had* walk#text([*ed*])
])

Sa forme négative se forme de la manière suivante *sujet + had + not + participe passé + complément*

#example([
  I *had not* walk#text([*ed*])
])

Sa forme interrogative se forme de la manière suivante *had + sujet + participe passé + complément*

#example([
  *Had* I walk#text([*ed*])?
])

== Past perfect contineous

On utilise le *past perfect continuous* pour une action qui a eu lieu avant une autre action dans le passé et qui est toujours en cours

Sa forme affirmative se forme de la manière suivante *sujet + had + been + base verbale -ing + complément*

#example([
  I *had been* walk#text([*ing*])
])

Sa forme négative se forme de la manière suivante *sujet + had + not + been + base verbale -ing + complément*

#example([
  I *had not been* walk#text([*ing*])
])

Sa forme interrogative se forme de la manière suivante *had + sujet + been + base verbale -ing + complément*

#example([
  *Had* I been walk#text([*ing*])?
])

== Future perfect simple

On utilise le *future perfect simple* pour une action future antérieure à une autre action future

Sa forme affirmative se forme de la manière suivante *sujet + will + have + participe passé + complément*

#example([
  I *will have* walk#text([*ed*])
])

Sa forme négative se forme de la manière suivante *sujet + will + not + have + participe passé + complément*

#example([
  I *will not have* walk#text([*ed*])
])

Sa forme interrogative se forme de la manière suivante *will + sujet + have + participe passé + complément*

#example([
  *Will* I have walk#text([*ed*])?
])

== Future perfect contineous

On utilise le *future perfect continuous* pour une action future antérieure à une autre action future et qui est toujours en cours

Sa forme affirmative se forme de la manière suivante *sujet + will + have + been + base verbale -ing + complément*

#example([
  I *will have been* walk#text([*ing*])
])

Sa forme négative se forme de la manière suivante *sujet + will + not + have + been + base verbale -ing + complément*

#example([
  I *will not have been* walk#text([*ing*])
])

Sa forme interrogative se forme de la manière suivante *will + sujet + have + been + base verbale -ing + complément*

#example([
  *Will* I have been walk#text([*ing*])?
])

#box(height: 1em)
#heading([Autres temps], supplement: [conjug],)

== Conditionnel

Il existe 4 niveaux de conditionnel en anglais selon la probabilité de réalisation de l'action

- _Zero conditional_ : pour exprimer une vérité générale (si $A$ se passe, alors $B$ se passe)

  Sa forme affirmative se forme de la manière suivante *if present simple/present simple*

  #example([
    *If* you heat ice, it *melts*
  ])

- _First conditional_ : pour exprimer une action probable (si $A$ se passe, alors $B$ se passera)

  Sa forme affirmative se forme de la manière suivante *if present simple/will*

  #example([
    *If* you study, you *will* pass
  ])

- _Second conditional_ : pour exprimer une action improbable (si $A$ se passait, alors $B$ se passerait)

  Sa forme affirmative se forme de la manière suivante *if past simple/would + base verbale*

  #example([
    *If* you studied, you *would* pass
  ])

- _Third conditional_ : pour exprimer une action impossible (si $A$ s'était passé, alors $B$ se serait passé)

  Sa forme affirmative se forme de la manière suivante *if past perfect/would have + participe passé*

  #example([
    *If* you had studied, you *would have* passed
  ])

== Impératif

L'impératif est utilisé pour donner un ordre, un conseil ou une recommandation

On a deux formes d'impératif, une pour les ordres et une pour les conseils

La forme affirmative pour les ordres se forme de la manière suivante *base verbale + complément*

#example([
  *Go* to the store
])

La forme affirmative pour les conseils se forme de la manière suivante *let's + base verbale + complément*

#example([
  *Let's go* to the store
])

La forme négative pour les ordres se forme de la manière suivante *do not + base verbale + complément*

#example([
  *Do not go* to the store
])

La forme négative pour les conseils se forme de la manière suivante *let's not + base verbale + complément*

#example([
  *Let's not go* to the store
])


On peut utiliser _shall_ pour donner une suggestion

#example([
  *Shall we go* to the store?
])

== Modaux

#todo(text: [(A faire)])

== Concordance des temps

#todo(text: [(A faire)])

#pagebreak()

#counter(heading).update(0)

#set heading(numbering: "📖 I.1.a")

#align(center, text([📖 Grammaire], weight: 800, size: 24pt))

#pagebreak()

#counter(heading).update(0)

#set heading(numbering: "📃 I.1.a")

#align(center, text([📃 Épreuves], weight: 800, size: 24pt))

#pagebreak()

#counter(heading).update(0)

#set heading(numbering: "🫂 I.1.a")

#align(center, text([🫂 Exemples], weight: 800, size: 24pt))

#box(height: 1em)
#heading([Environnement], supplement: [ex],)

#box(height: 1em)
#heading([Droit des femmes], supplement: [ex],)

*Roe v. Wade* \ 
Roe v. Wade is a landmark decision of the U.S. Supreme Court in which the Court ruled that the Constitution of the United States *protects a pregnant woman's liberty to choose to have an abortion* without excessive government restriction. This decision was made in *1973*. \
But in *2022*, the Supreme Court of the United States *overturned the Roe v. Wade decision*, which was a major setback (backlash) for women rights.
As a result, many states have passed laws that restrict access to abortion. \

*Suffragettes* \
The suffragettes movement was a political movement in the late 19th and early 20th centuries that fought for women's right to vote, mainly in the UK and the US. \
The movement was successful in many countries, as women got the right to vote in the UK in *1918* (only if they were over 30 years old, and all women got the right to vote in *1928*), in the US in *1920*, in France in *1944*, in New Zealand in *1893* (the first country)

*Women of color* \
In some countries, not all women were allowed to vote at the same time. For example, in the US, the 19th amendment was passed in *1920* but in some states afro-americans were still not allowed to vote until the 1960s. \
They were also discriminated against in other ways, for example, in the US, the Civil Rights Act was passed in *1964* to protect people from discrimination \
Finally in *1965*, the Voting Rights Act was passed to protect the right to vote of all citizens, regardless of their physical appearance or origin

#box(height: 1em)
#heading([IA/Nouvelles technologies], supplement: [ex],)

#box(height: 1em)
#heading([États Unis], supplement: [ex],)

== Politique

== Armes

#box(height: 1em)
#heading([Royaume Uni], supplement: [ex],)

== Famille royale/Commonwealth

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