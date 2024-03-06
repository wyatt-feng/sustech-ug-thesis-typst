#import "@preview/tablex:0.0.8": tablex, rowspanx, colspanx
#let 字号 = (
  初号: 42pt,
  小初: 36pt,
  一号: 26pt,
  小一: 24pt,
  二号: 22pt,
  小二: 18pt,
  三号: 16pt,
  小三: 15pt,
  四号: 14pt,
  中四: 13pt,
  小四: 12pt,
  五号: 10.5pt,
  小五: 9pt,
  六号: 7.5pt,
  小六: 6.5pt,
  七号: 5.5pt,
  小七: 5pt,
)

#let 字体 = (
  仿宋: ("Times New Roman", "FangSong"),
  宋体: ("Times New Roman", "Source Han Serif"),
  黑体: ("Times New Roman", "Source Han Sans"),
  楷体: ("Times New Roman", "KaiTi"),
  英文: ("Times New Roman"),
  代码: ("New Computer Modern Mono", "Times New Roman", "SimSun"),
)

#let lengthceil(len, unit: 字号.小四) = calc.ceil(len / unit) * unit
#let partcounter = counter("part")
#let chaptercounter = counter("chapter")
#let appendixcounter = counter("appendix")
#let footnotecounter = counter(footnote)
#let rawcounter = counter(figure.where(kind: "code"))
#let imagecounter = counter(figure.where(kind: image))
#let tablecounter = counter(figure.where(kind: table))
#let equationcounter = counter(math.equation)
#let biblio(path) = {
  align(center)[#heading(numbering: none, "参考文献")]
  bibliography(path, title: none, style: "ieee")
}
#let skippedstate = state("skipped", false)

#let thesisnumbering(..nums, location: none) = locate(loc => {
  let actual_loc = if location == none { loc } else { location }
  if appendixcounter.at(actual_loc).first() < 1 {
    numbering("1.1", ..nums)
  } else {
    numbering("A1.1", ..nums)
  }
})

#let figurenumbering(..nums, location: none) = locate(loc => {
  let actual_loc = if location == none { loc } else { location }
  nums.pos().last()
})

#let numberedpar(numbering_scheme: "(1)", ..content) = {
  content.pos().enumerate().map(it => {
    // There is a bug in the upstream code that wouldn't apply first-line-indent
    // in blocks, which affects tables, etc. The bug fix seems to be included in
    // the codebase, but hasn't been released yet.
    // TODO: remove manual indentation after bug fix.

    // Actually, it wouldn't harm anyway.
    par(justify: true, first-line-indent: 0em)[#h(2em)#numbering(numbering_scheme, it.at(0)+1)#h(1em)#it.at(1)]
  }).join()
}

#let chineseunderline(s, width: 300pt, bold: false) = {
  let chars = s.clusters()
  let n = chars.len()
  style(styles => {
    let i = 0
    let now = ""
    let ret = ()

    while i < n {
      let c = chars.at(i)
      let nxt = now + c

      if measure(nxt, styles).width > width or c == "\n" {
        if bold {
          ret.push(strong(now))
        } else {
          ret.push(now)
        }
        ret.push(v(-1em))
        ret.push(line(length: 100%))
        if c == "\n" {
          now = ""
        } else {
          now = c
        }
      } else {
        now = nxt
      }

      i = i + 1
    }

    if now.len() > 0 {
      if bold {
        ret.push(strong(now))
      } else {
        ret.push(now)
      }
      ret.push(v(-0.9em))
      ret.push(line(length: 100%))
    }

    ret.join()
  })
}

#let chineseoutline(title: "目录", depth: none, indent: false) = {
  align(center)[#text(font: 字体.黑体, size: 字号.小二, weight: "bold", title)]
  locate(it => {
    let elements = query(heading.where(outlined: true).after(it), it)

    for el in elements {
      // Skip headings that are too deep
      if depth != none and el.level > depth { continue }

      let maybe_number = if el.numbering != none {
        numbering(el.numbering.with(location: el.location()), ..counter(heading).at(el.location()))
        h(0.5em)
      }

      let line = {
        if maybe_number != none {
          style(styles => {
            let width = measure(maybe_number, styles).width
            box(
              width: lengthceil(width),
              maybe_number
            )
          })
        }

        link(el.location(), if el.level == 1 {
          set text(font: 字体.宋体, size: 字号.四号, weight: "bold")
          el.body
        } else {
          set text(font: 字体.宋体, size: 字号.四号, weight: "regular")
          el.body
        })

        // Filler dots
        box(width: 1fr, h(10pt) + box(width: 1fr, repeat[.]) + h(10pt))

        // Page number
        let footer = query(selector(<__footer__>).after(el.location()), el.location())
        let page_number = if footer == () {
          0
        } else {
          counter(page).at(footer.first().location()).first()
        }
        
        link(el.location(), if el.level == 1 {
          set text(font: 字体.宋体, size: 字号.四号, weight: "bold")
          str(page_number)
        } else {
          str(page_number)
        })

        linebreak()
        v(-0.2em)
      }

      line
    }
  })
}

#let codeblock(raw, caption: none, outline: false) = {
  figure(
    if outline {
      rect(width: 100%)[
        #set align(left)
        #raw
      ]
    } else {
      set align(left)
      raw
    },
    caption: caption, kind: "code", supplement: ""
  )
}

#let appendix() = {
  align(center)[#heading(numbering: none, "附录")]
  appendixcounter.update(10)
  chaptercounter.update(1)
  counter(heading).update(1)
}

#let tbl(tbl, caption: "", source: "") = {
  set text(font: 字体.宋体, size: 字号.五号)
  [
    #figure(
      tbl,
      caption: caption,
      supplement: [表],
      kind: table,
    )
    #if source != "" {
      v(-1em)
      align(left)[数据来源：#source]
    }
  ]
}

#let conf(
  class: "",
  serialnumber: "",
  udc: "",
  confidence: "",
  cauthor: "",
  eauthor: "",
  studentid: "",
  blindid: "",
  cthesisname: "本科生毕业设计（论文）",
  cheader: "",
  ctitle: "",
  csubtitle: "",
  etitle: "",
  esubtitle: "",
  department: "",
  cmajor: "",
  emajor: "",
  csupervisor: "",
  esupervisor: "",
  date: "某某某某年某某月某某日",
  cabstract: [],
  ckeywords: (),
  eabstract: [],
  ekeywords: (),
  acknowledgements: [],
  linespacing: 1.5em,
  parspacing: 1.5em,
  outlinedepth: 3,
  blind: false,
  doc,
) = {
  set page("a4",
    margin: (x: 3.17cm, y: 2.54cm),
    footer: locate(loc => {
      if skippedstate.at(loc) and calc.even(loc.page()) { return }
      [
        #set text(字号.五号)
        #set align(center)
        #let heading_count = query(selector(heading).before(loc), loc).len()
        #if heading_count < 2 {
          // Skip the cover, the abstract, and the toc
          counter(page).update(0)
        } else {
          let current_page = counter(page).at(loc).first()
          [
            #str(current_page)
          ]
        }
        #label("__footer__")
      ]
    }),
  )

  set text(字号.二号, font: 字体.黑体, lang: "zh")
  set align(center + horizon)
  set heading(numbering: thesisnumbering)
  set figure(numbering: figurenumbering)
  set math.equation(numbering: thesisnumbering)
  set list(indent: 2em)
  set enum(indent: 2em)
  set par(leading: linespacing)

  show strong: it => text(font: 字体.黑体, weight: "bold", it.body)
  show emph: it => text(font: 字体.楷体, style: "italic", it.body)
  show par: set block(spacing: linespacing)
  show raw: set text(font: 字体.代码)
  show footnote.entry: it => {
    let loc = it.note.location()
    let superscript_numbering = c => [#super[#c] ]
    numbering(
      superscript_numbering,
      ..counter(footnote).at(loc),
    )
    set text(font: 字体.宋体, size: 字号.小五)
    it.note.body
  }

  show heading: it => [
    // Cancel indentation for headings
    #set par(first-line-indent: 0em)

    #let sizedheading(it, size) = [
      #set text(size)
      #v(2em)
      #if it.numbering != none {
        strong(counter(heading).display())
        h(0.5em)
      }
      #strong(it.body)
      #v(1em)
    ]

    #if it.level == 1 {
      chaptercounter.step()
      footnotecounter.update(())
      rawcounter.update(())

      sizedheading(it, 字号.三号)
    } else {
      if it.level == 2 {
        sizedheading(it, 字号.四号)
      } else if it.level == 3 {
        sizedheading(it, 字号.小四)
      } else {
        sizedheading(it, 字号.小四)
      }
    }
  ]

  show figure: it => [
    #set align(center)
    #if not it.has("kind") {
      it
    } else if it.kind == image {
      it.body
      align(center)[
        #set text(font: 字体.黑体, size: 字号.五号, weight: "bold")
        #it.caption
      ]
    } else if it.kind == table {
      align(center)[
        #set text(font: 字体.黑体, size: 字号.五号, weight: "bold")
        #it.caption
      ]
      it.body
    } else if it.kind == "code" {
      [
        #set text(字号.五号)
        代码#it.caption
      ]
      it.body
    }
  ]

  show ref: it => {
    if it.element == none {
      // Keep citations as is
      it
    } else {
      // Remove prefix spacing
      h(0em, weak: true)

      let el = it.element
      let el_loc = el.location()
      if el.func() == math.equation {
        // Handle equations
        link(el_loc, [
          式
          #figurenumbering(chaptercounter.at(el_loc).first(), equationcounter.at(el_loc).first(), location: el_loc)
        ])
      } else if el.func() == figure {
        // Handle figures
        if el.kind == image {
          link(el_loc, [
            图
            #figurenumbering(chaptercounter.at(el_loc).first(), imagecounter.at(el_loc).first(), location: el_loc)
          ])
        } else if el.kind == table {
          link(el_loc, [
            表
            #figurenumbering(chaptercounter.at(el_loc).first(), tablecounter.at(el_loc).first(), location: el_loc)
          ])
        } else if el.kind == "code" {
          link(el_loc, [
            代码
            #figurenumbering(chaptercounter.at(el_loc).first(), rawcounter.at(el_loc).first(), location: el_loc)
          ])
        }
      } else if el.func() == heading {
        // Handle headings
        if el.level == 1 {
          link(el_loc, thesisnumbering(..counter(heading).at(el_loc), location: el_loc))
        } else {
          link(el_loc, [
            节
            #thesisnumbering(..counter(heading).at(el_loc), location: el_loc)
          ])
        }
      }

      // Remove suffix spacing
      h(0em, weak: true)
    }
  }

  let fieldname(name) = [
    #set align(right + top)
    #text(font: 字体.宋体, weight: "bold", name)
  ]

  let fieldvalue(value) = [
    #set align(center + horizon)
    #set text(font: 字体.宋体, size: 字号.三号, weight: "regular")
    #grid(
      rows: (auto, auto),
      row-gutter: 0.2em,
      value,
      line(length: 100%)
    )
  ]

  let smallfieldname(name) = [
    #text(font: 字体.宋体, size: 字号.小四, weight: "regular", name)
  ]

  let smallfieldvalue(value) = [
    #set align(left + horizon)
    #set text(font: 字体.宋体, size: 字号.小四, weight: "regular")
    #grid(
      rows: (1em, auto),
      row-gutter: 0.2em,
      value,
      line(length: 4em)
    )
  ]

  // Cover page
  grid(
    columns: (2em, 5fr, 2em, 1fr),
    align(left)[#smallfieldname("分类号")],
    align(left)[#smallfieldvalue(class)],
    align(left)[#smallfieldname(text("编") + h(1em) + text("号"))],
    align(left)[#smallfieldvalue(serialnumber)],
  )
  grid(
    columns: (2em, 5fr, 2em, 1fr),
    align(left)[#smallfieldname("ＵＤＣ")],
    align(left)[#smallfieldvalue(udc)],
    align(left)[#smallfieldname(text("密") + h(1em) + text("级"))],
    align(left)[#smallfieldvalue(confidence)],
  )
  box(
    grid(
      columns: (auto, auto),
      gutter: 0.4em,
      image("images/sustech-cn.svg", height: 4.8em, fit: "contain"),
    )
  )
  linebreak()
  v(1em)
  text(font: 字体.宋体, size: 字号.小初, weight: "bold", cthesisname)

  set text(font: 字体.宋体, size: 字号.三号, weight: "bold")
  grid(
    columns: (80pt, 280pt),
    row-gutter: 1.5em,
    fieldname(text("题") + h(2em) + text("目：")),
    chineseunderline(ctitle + "\n" + csubtitle),
    fieldname(text("姓") + h(2em) + text("名：")),
    fieldvalue(cauthor),
    fieldname(text("学") + h(2em) + text("号：")),
    fieldvalue(studentid),
    fieldname(text("院") + h(2em) + text("系：")),
    fieldvalue(department),
    fieldname(text("专") + h(2em) + text("业：")),
    fieldvalue(cmajor),
    fieldname(text("指导教师：")),
    fieldvalue(csupervisor),
  )

  v(1em)
  text(weight: "regular", size: 字号.三号)[#date]

  pagebreak()

  // Honor Pledge
  set align(left + top)
  align(center, text(font: 字体.黑体, weight: "bold", size: 字号.二号, "诚信承诺书"))
  v(3em)
  set text(font: 字体.宋体, weight: "regular", size: 字号.四号)
  numberedpar(numbering_scheme: "1.", "本人郑重承诺所呈交的毕业设计（论文），是在导师的指导下，独立进行研究工作所取得的成果，所有数据、图片资料均真实可靠。",
  "除文中已经注明引用的内容外，本论文不包含任何其他人或集体已经发表或撰写过的作品或成果。对本论文的研究作出重要贡献的个人和集体，均已在文中以明确的方式标明。",
  "本人承诺在毕业论文（设计）选题和研究内容过程中没有抄袭他人研究成果和伪造相关数据等行为。",
  "在毕业论文（设计）中对侵犯任何方面知识产权的行为，由本人承担相应的法律责任。",
  )
  v(3em)
  align(right, text("作者签名：" + h(5em)))
  v(1em)
  align(right, date)

  pagebreak()

  // Chinese abstract
  par(justify: true, first-line-indent: 0em, leading: 25pt)[
    #align(center)[#text(font: 字体.黑体, size: 字号.二号, ctitle)]
    #if csubtitle != "" {
      align(right)[#text(font: 字体.黑体, size: 字号.小二, "——" + csubtitle)]
    }
    #align(center)[#text(font: 字体.宋体, size: 字号.四号, cauthor)]
    #align(center)[#text(font: 字体.楷体, size: 字号.小四, department + h(1em) + "指导教师：" + csupervisor)]
    #text(font: 字体.黑体, size: 字号.三号, "［摘要］：")
    #set text(font: 字体.宋体, size: 字号.四号, weight: "regular")
    #cabstract
    #v(2fr)
    #text(font: 字体.黑体, size: 字号.三号, "［关键词］：")
    #ckeywords.join("；")
    #v(1fr)
  ]

  pagebreak()

  // English abstract
  par(justify: true, first-line-indent: 0em, leading: 25pt)[
    #text(font: 字体.英文, size: 字号.三号, "[Abstract]: ")
    #set text(font: 字体.英文, size: 字号.四号, weight: "regular")
    #eabstract
    #v(1fr)
    #text(font: 字体.英文, size: 字号.三号, "[Keywords]: ")
    #ekeywords.join("; ")
    #v(1fr)
  ]

  pagebreak()
  
  // Table of contents
  chineseoutline(
    title: "目录",
    depth: outlinedepth,
    indent: true,
  )

  pagebreak()

  set align(left + top)
  par(justify: true, first-line-indent: 2em, leading: linespacing)[
    #set text(font: 字体.宋体, size: 字号.小四)
    #show par: set block(spacing: parspacing)
    #doc
  ]

  if not blind {
    pagebreak()
    align(center)[#heading(level: 1, numbering: none, "致谢")]
    par(justify: true, first-line-indent: 2em, leading: linespacing)[
      #acknowledgements
    ]

    partcounter.update(30)
  }
}
