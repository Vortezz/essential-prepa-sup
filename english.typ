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

#outline(depth:1,indent: 10pt, fill: [], title: "Grammaire :", target: heading.where(supplement: [grammar]))

#outline(depth:1,indent: 10pt, fill: [], title: "Épreuves :", target: heading.where(supplement: [tests]))

#outline(depth:1,indent: 10pt, fill: [], title: "Exemples :", target: heading.where(supplement: [ex]))

#pagebreak()

#counter(heading).update(0)

#set heading(numbering: "📃 I.1.a")

#align(center, text([📃 Grammaire], weight: 800, size: 24pt))

#box(height: 1em)
#heading([Conjugaison], supplement: [grammar],)

== Present simple

En anglais on utilise le _present simple_ pour décrire des actions factuelles, des vérités, pour exprimer des goûts ou pour décrire.

On emploie le _present simple_ avec des adverbes qui marquent la routine :

- _every day_ : chaque jour
- _every month_ : chaque mois
- _always_ : toujours
- _never_ : jamais
- _generally_ : généralement
- _usually_ : habituellement

=== Forme affimative

La forme affirmative se forme avec *sujet + base verbale + complément*, et la base verbale correspond à l'infinitif mais sans la particule _to_

A la troisième personne du singulier, on met un _-s_ ou un _-es_ derrière la base verbale si le verbe finit en _-o_, _-x_, _-s_ ou _-ch_

#example([*to go* devient *he goes*])

Si le verbe finit par un _-y_ on enlève ce _-y_ et on place un _-ies_ à la troisième personne du singulier

#example([*to cry* devient *he cries*])

=== Forme négative

La forme négative se forme avec *sujet + do/does + not + base verbale + complément*. Les particules _do not_ et _does not_ peuvent se contracter en _don't_ et _doesn't_

A noter que c'est le _does_ qui prend la marque de la troisième personne et non la base verbale

#example([*He does not cry*])

=== Forme interrogative

Une phrase interrogative avec le _present simple_ se forme avec *do/does + sujet + base verbale*, ainsi on intervertit le verbe et l'auxiliaire _do_

#example([*to cry* devient *Does he cry?*])

== Prétérit (Past Simple)

Le prétérit renvoie à des évènements finis sans lien avec le présent, on l'utilise pour raconter un récit au passé ou une histoire

On utilise les marqueurs de temps suivant :

- _last year_ : l’année dernière
- _one month ago_ : il y a un mois
- _a long time ago_ : il y a longtemps
- _once upon a time_ : il était une fois

=== Forme affirmative

La forme affirmative du prétérit se forme de la manière suivante *sujet + base verbale -ed + complément*

#example([She work#text[*ed*] hard])

#warning([Beaucoup de verbes comme _to take_ sont irréguliers en anglais, ainsi il est important de les connaître (voir #todo())])

=== Forme négative

La forme négative du prétérit se forme avec *sujet + did not + base verbale + complément*. _Did not_ peut se contracter en _didn't_.

#example([
  He *dit not* answer the phone
])

=== Forme interrogative

La forme interrogative se forme avec *did + sujet + base verbale + complément*

#example([
  *Did* you talk to her yesterday?
])

== Future simple

Le _future simple_ exprime un élément factuel du futur

=== Forme affirmative

La forme affirmative du _future simple_ se forme avec *sujet + will + base verbale + complément*. Le _will_ peut être contracté en _'ll_.

#example([
  I *will* do that later _ou_ I*'ll* do that later
])

=== Forme négative

=== Forme interrogative

== Present perfect

== Past perfect

== Conditionnel

== Impératif

== Modaux

== Concordance des temps

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