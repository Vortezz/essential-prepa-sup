#set heading(numbering: "I.1.a")
#import "@local/unify:0.6.0": *
#import "@local/physica:0.9.3": *
#import "@local/cetz:0.2.2": *

// http://cdn.sci-phy.org/mp2i/poly_cours.pdf page 43

#let project(title: "", authors: (), date: none, body) = {
  set document(author: authors.map(a => a.name), title: "Essentiel de français")
  
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
    #block(text(weight: 800, 30pt, "📖 Essentiel de français"))
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

  align(center,image("french/logo.jpg", width: 70%))

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
  title: "Essentiel de français",
  authors: (
    (name: "Victor Sarrazin", phone: ""),
  ),
  date: "2023/2024",
)

#align([_Bienvenue dans l'essentiel de français de mes cours de prépa. Ce document a pour objectif de contenir mes cours de français ainsi que des citations personnelles ou des références supplémentaires._

#align(right, text([_Bonne lecture..._]))])

#pagebreak()

#align(center, text([📋 Sommaire], weight: 800, size: 24pt))

#outline(depth:1,indent: 10pt, fill: [], title: "Livres :", target: heading.where(supplement: [book]))

#outline(depth:1,indent: 10pt, fill: [], title: "Citations :", target: heading.where(supplement: [quotes]))

#pagebreak()

#counter(heading).update(0)

#set heading(numbering: "📖 I.1.a")

#align(center, text([📖 Livres], weight: 800, size: 24pt))

#box(height: 1em)
#heading([Les Suppliantes et Les sept contre Thèbes], supplement: [book],)

== L'auteur : Eschyle

== Résumé

== Analyse

#box(height: 1em)
#heading([Traité théologico-politique], supplement: [book],)

== L'auteur : Baruch Spinoza

== Résumé

== Analyse

#box(height: 1em)
#heading([Le temps de l'innocence], supplement: [book],)

== L'auteur : Edith Wharton

== Personnages

La filiation étant compliquée dans le temps de l'innocence, on redonne une carte mentale :

#pagebreak()

#box(height: 220pt)

#rotate(90deg,align(center + horizon,figure(image("french/inno_gen.png", width: 150%), caption: [Arbre généalogique des personnages principaux])))

#pagebreak()

Nous allons maintenant détailler les personnages principaux du roman :

=== Newland Archer

Newland Archer est le personnage principal du roman. Il est fiancé à May Welland, mais a une relation amoureuse extraconjugale avec Ellen Olenska, qui ne s'étendra pas au-delà de la simple relation amoureuse. Il est un avocat new-yorkais de la haute société, et est proche de la famille van der Luyden, qui est une famille influente de la haute société new-yorkaise.

=== May Welland

May Welland est la fiancée de Newland Archer. Elle est la cousine d'Ellen Olenska. Elle est une jeune femme de la haute société new-yorkaise, qui a depuis son enfance été élevée dans le respect des conventions sociales, et gardera, à l'image de sa mère, une attitude innocente et naïve auprès de son mari tout au long du roman, même si elle est consciente de la relation entre Newland et Ellen.

=== Ellen Olenska

Ellen Olenska est la cousine de May Welland. Elle est mariée au comte Olenski, un comte polonais, mais elle est en instance de divorce. Elle est une femme libre, qui a vécu en Europe, et qui est revenue à New York pour échapper à son mari. Elle est une femme indépendante, qui ne se soucie pas des conventions sociales, et qui est en quête de liberté. Elle est l'amante de Newland Archer, mais elle ne veut pas être la cause de la rupture de son mariage avec May, et partira donc pour l'Europe afin de ne pas être un obstacle à leur mariage.

=== Mrs Manson Mingott

Mrs Manson Mingott est la grand-mère de May Welland et Ellen Olenska. Elle est une femme influente de la haute société new-yorkaise, qui a une grande influence sur la famille Mingott. Malgré son age avancé elle reste très active et est très respectée par la haute société new-yorkaise, même si elle ne se déplace plus en public, et qu'elle est connue pour être un peu radine.

=== Mrs Augusta Welland

Mrs Augusta Welland est la mère de May Welland. Elle est une femme de la haute société new-yorkaise, qui est très attachée aux conventions sociales, et qui a élevé sa fille dans le respect des conventions sociales. Elle joue un role important sur le recul de la date du mariage.

== Résumé

== Analyse

#pagebreak()

#counter(heading).update(0)

#set heading(numbering: "🗿 I.1.a")

#align(center, text([🗿 Citations], weight: 800, size: 24pt))

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