// Import `template_zh.typ` if using Chinese
// or else import `template_en.typ` if using English
#import "resources/template_en.typ": *
#let meta = conf.with(
  class: "",
  serialnumber: "",
  udc: "",
  confidence: "",
  author: "San Zhang",
  studentid: "12010000",
  title: "Undergraduate Thesis Template",
  subtitle: "A Typst One",
  department: "Computer Science and Engineering",
  major: "Some Major",
  supervisor: "Prof. Si Li",
  date: "June 30, 2024",
  cabstract: "本文介绍了 sustech-ug-thesis-typst 文档模板所提供的功能。",
  ckeywords: ("Typst", "模板"),
  eabstract: "This document introduces the features of the sustech-ug-thesis-typst template.",
  ekeywords: ("Typst", "Template"),
  acknowledgements: [感谢 Typst 开发者的辛勤付出。],
  linespacing: 1.5em,
  parspacing: 1.5em,
  outlinedepth: 3,
  blind: false,
)
