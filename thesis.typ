#import "metadata.typ": *
#show: doc => meta(doc)

= 基本功能 <intro>

== 标题

Typst 中的标题使用 `=` 表示，其后跟着标题的内容。`=` 的数量对应于标题的级别。

除了这一简略方式，也可以通过 `heading` 函数自定义标题的更多属性。具体可以参考#link("https://typst.app/docs/reference/meta/heading/", [文档中的有关内容])。

下面是一个示例：

#tbl(
  tablex(
    columns: (1fr, 1fr),
    [
      #set align(center)
      代码
    ],
    [
      #set align(center)
      渲染结果
    ],
    ```typ
  #heading(level: 2, numbering: none, outlined: false, "二级标题")
  #heading(level: 3, numbering: none, outlined: false, "三级标题")
  #heading(level: 4, numbering: none, outlined: false, "四级标题")
  #heading(level: 5, numbering: none, outlined: false, "五级标题")
    ```,
    [
      #heading(level: 2, numbering: none, outlined: false, "二级标题")
      #heading(level: 3, numbering: none, outlined: false, "三级标题")
      #heading(level: 4, numbering: none, outlined: false, "四级标题")
      #heading(level: 5, numbering: none, outlined: false, "五级标题")
    ]
  ),
  caption: "这是表序"
)\


=== 三级标题

==== 四级标题

本模板目录的默认最大深度为 3，即只有前三级标题会出现在目录中。如果需要更深的目录，可以更改 `outlinedepth` 设置。

== 粗体与斜体

与 Markdown 类似，在 Typst 中，使用 `*...*` 表示粗体，使用 `_..._` 表示斜体。下面是一个示例：

#tbl(
  tablex(
    auto-vlines: false,
    repeat-header: true,
    columns: (1fr, 1fr),
    [
      #set align(center)
      代码
    ],
    [
      #set align(center)
      渲染结果
    ],
    ```typ
  *bold* and _italic_ are very simple.
    ```,
    [
  *bold* and _italic_ are very simple.
    ]
  ),
  caption: "这是一个三线表样例"
) <booktab> \

由于绝大部分中文字体只有单一字形，这里遵循 `PKUTHSS` 的惯例，使用#strong[黑体]表示粗体，#emph[楷体]表示斜体。但需要注意的是，由于语法解析的问题， `*...*` 和 `_..._` 的前后可能需要空格分隔，而这有时会导致不必要的空白。 如果不希望出现这一空白，可以直接采用 `#strong` 或 `#emph`。

#tbl(
tablex(
  columns: (1fr, 1fr),
  [
    #set align(center)
    代码
  ],
  [
    #set align(center)
    渲染结果
  ],
  ```typ
对于中文情形，*使用 \* 加粗* 会导致额外的空白，#strong[使用 \#strong 加粗]则不会。
  ```,
  [
对于中文情形，*使用 \* 加粗* 会导致额外的空白，#strong[使用 \#strong 加粗]则不会。
  ]
), caption: "表序")\

== 脚注

从 v0.4 版本开始，Typst 原生支持了脚注功能。本模板中，默认每一章节的脚注编号从 1 开始。

#tbl(tablex(
  columns: (1fr, 1fr),
  [
    #set align(center)
    代码
  ],
  [
    #set align(center)
    渲染结果
  ],
  ```typ
  Typst 支持添加脚注#footnote[这是一个脚注。]。
```,
[
  Typst 支持添加脚注#footnote[这是一个脚注。]。
]
))\

== 图片

在 Typst 中插入图片的默认方式是 `image` 函数。如果需要给图片增加标题，或者在文章中引用图片，则需要将其放置在 `figure` 中，就像下面这样：

#tbl(tablex(
  columns: (1fr, 1fr),
  [
    #set align(center)
    代码
  ],
  [
    #set align(center)
    渲染结果
  ],
  ```typ
#figure(
  image("resources/images/1-writing-app.png", width: 100%),
  caption: "Typst 网页版界面",
) <web>
```,
[
  #figure(
  image("resources/images/1-writing-app.png", width: 100%),
  caption: "Typst 网页版界面",
) <web>
]
))\

@web 展示了 Typst 网页版的界面。更多有关内容，可以参考 @about。代码中的 `<web>` 是这一图片的标签，可以在文中通过 `@web` 来引用。

== 表格

在 Typst 中，定义表格的默认方式是 `table` 函数。但如果需要给表格增加标题，或者在文章中引用表格，则可以将其放置在 `tbl` 中。
需要注意的是下文表格中使用的`tablex`函数是第三方包，用来实现更灵活的表格如三线表等。它的语法和自带的`table`一样，如果
不需要高级功能的话可以互相替换。`tbl`函数的签名是`tbl(table, caption: "", source: "")`，其中`table`是要展示的表格，可以是`table`
或`tablex`的返回值，第二个参数是表序，可以省略，第三个参数是数据来源，可以省略。

#tbl(
  tablex(
    columns: (1fr, 1fr),
    [
      #set align(center)
      代码
    ],
    [
      #set align(center)
      渲染结果
    ],
    codeblock(
    ```typ
  #tbl(
    tablex(
      columns: (auto, auto, auto, auto),
      inset: 10pt,
      align: horizon,
        [*姓名*],[*职称*],[*工作单位*],[*职责*],
        [李四],[教授],[北京大学],[主席],
        [王五],[教授],[北京大学],[成员],
        [赵六],[教授],[北京大学],[成员],
        [钱七],[教授],[北京大学],[成员],
        [孙八],[教授],[北京大学],[成员],
    ),
    caption: "答辩委员会名单",
    source: "这是数据来源",
  ) <tablex>
  ```,
      caption: "默认表格",
    ),
    [
      #tbl(
        tablex(
          columns: (auto, auto, auto, auto),
          inset: 10pt,
          align: horizon,
            [*姓名*],[*职称*],[*工作单位*],[*职责*],
            [李四],[教授],[北京大学],[主席],
            [王五],[教授],[北京大学],[成员],
            [赵六],[教授],[北京大学],[成员],
            [钱七],[教授],[北京大学],[成员],
            [孙八],[教授],[北京大学],[成员],
        ),
        caption: "答辩委员会名单",
        source: "这是数据来源",
      ) <tablex>
    ]
  ),
  caption: "这是表序",
)

对应的渲染结果如 @tablex 所示。代码中的 `<tablex>` 是这一表格的标签，可以在文中通过 `@tablex` 来引用。
如果需要三线表，可以在`tablex`中传入参数`auto-vlines: false`，如同 @booktab 的代码所示。

== 公式

@eq 是一个公式。代码中的 `<eq>` 是这一公式的标签，可以在文中通过 `@eq` 来引用。

#tbl(tablex(
  columns: (1fr, 1fr),
  [
    #set align(center)
    代码
  ],
  [
    #set align(center)
    渲染结果
  ],
  ```typ
$ E = m c^2 $ <eq>
  ```,
  [
    $ E = m c^2 $ <eq>
  ]
))\

@eq2 是一个多行公式。

#tbl(tablex(
  columns: (1fr, 1fr),
  [
    #set align(center)
    代码
  ],
  [
    #set align(center)
    渲染结果
  ],
  ```typ
$ sum_(k=0)^n k
    &= 1 + ... + n \
    &= (n(n+1)) / 2 $ <eq2>  ```,
  [
$ sum_(k=0)^n k
    &= 1 + ... + n \
    &= (n(n+1)) / 2 $ <eq2>
  ]
))\

@eq3 到 @eq6 中给出了更多的示例。

#tbl(tablex(
  columns: (1fr, 1fr),
  [
    #set align(center)
    代码
  ],
  [
    #set align(center)
    渲染结果
  ],
  ```typ
$ frac(a^2, 2) $ <eq3>
$ vec(1, 2, delim: "[") $
$ mat(1, 2; 3, 4) $
$ lim_x =
    op("lim", limits: #true)_x $ <eq6>
  ```,
  [
$ frac(a^2, 2) $ <eq3>
$ vec(1, 2, delim: "[") $
$ mat(1, 2; 3, 4) $
$ lim_x =
    op("lim", limits: #true)_x $ <eq6>
  ]
))

== 代码块

像 Markdown 一样，我们可以在文档中插入代码块：

#tbl(
  tablex(
    columns: (1fr, 1fr),
    [
      #set align(center)
      代码
    ],
    [
      #set align(center)
      渲染结果
    ],
    ````typ
    ```c
    int main() {
      printf("Hello, world!");
      return 0;
    }
    ```
    ````,
    [
      ```c
        int main() {
          printf("Hello, world!");
          return 0;
        }
      ```
    ]
  ),
  caption: "代码"
)\

如果想要给代码块加上标题，并在文章中引用代码块，可以使用本模板中定义的 `codeblock` 命令。其中，`caption` 参数用于指定代码块的标题，`outline` 参数用于指定代码块显示时是否使用边框。下面给出的 @code 是一个简单的 Python 程序。其中的 `<code>` 是这一代码块的标签，意味着这一代码块可以在文档中通过 `@code` 来引用。

#tbl(tablex(
  columns: (1fr, 1fr),
  [
    #set align(center)
    代码
  ],
  [
    #set align(center)
    渲染结果
  ],
  ````typ
#codeblock(
  ```python
  def main():
      print("Hello, world!")
  ```,
  caption: "一个简单的 Python 程序",
  outline: true,
) <code>
  ````,
  [
    #codeblock(
      ```python
      def main():
          print("Hello, world!")
      ```,
      caption: "一个简单的 Python 程序",
      outline: true,
    ) <code>
  ]
))\

@codeblock_definition 中给出了本模板中定义的 `codeblock` 命令的实现。

#codeblock(
  ```typ
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
  ```,
  caption: [`codeblock` 命令的实现],
) <codeblock_definition>

== 有序段落

对于内容较长的列表，每项条目的宽度均和列表的第一行相等，即每一行都会缩进。
有时如果需要对段落进行标号而不想让整段内容缩进的话，可以使用`numberedpar`命令实现。

#tbl(tablex(
  columns: (1fr, 1fr),
  [
    #set align(center)
    有序段落
  ],
  [
    #set align(center)
    渲染结果
  ],
  ````typ
    #numberedpar(
      [本人郑重承诺所呈交的毕业设计（论文），是在导师的指导下],
      [独立进行研究工作所取得的成果，所有数据、图片资料均真实可靠],
    )
  ````,
  align(left)[
  #numberedpar(
    [本人郑重承诺所呈交的毕业设计（论文），是在导师的指导下],
    [独立进行研究工作所取得的成果，所有数据、图片资料均真实可靠],
  )
  ]
))\
== 参考文献

Typst 支持 BibLaTeX 格式的 `.bib` 文件，同时也新定义了一种基于 YAML 的文献引用格式。要想在文档中引用参考文献，需要在文档中通过调用 `bibliography` 函数来引用参考文献文件。下面是一个示例：

#tbl(tablex(
  columns: (1fr, 1fr),
  [
    #set align(center)
    代码
  ],
  [
    #set align(center)
    渲染结果
  ],
  ```typ
可以像这样引用参考文献： @wang2010guide 和 @kopka2004guide。

#biblio("ref.bib")
  ```,
  [
    可以像这样引用参考文献： @wang2010guide 和 @kopka2004guide。
  ]
))

注意代码中的 `"ref.bib"` 也可以是一个数组，比如 `("ref1.bib", "ref2.bib")`。

= 理论

== 理论一 <theory1>

让我们首先回顾一下 @intro 中的部分公式：

$ frac(a^2, 2) $ <first_eq_ch2>
$ vec(1, 2, delim: "[") $
$ mat(1, 2; 3, 4) $
$ lim_x =
    op("lim", limits: #true)_x $

如@first_eq_ch2 所示，它是一个公式

#pagebreak()
#biblio("ref.bib")

#pagebreak()

#appendix()

== 关于 Typst <about>

=== 在附录中插入图片和公式等

附录中也支持脚注#footnote[这是一个附录中的脚注。]。

附录中也可以插入图片，如 @web1。

#figure(
  image("resources/images/1-writing-app.png", width: 100%),
  caption: "Typst 网页版界面",
) <web1>

附录中也可以插入公式，如 @appendix-eq。

#tbl(tablex(
  columns: (1fr, 1fr),
  [
    #set align(center)
    代码
  ],
  [
    #set align(center)
    渲染结果
  ],
  ```typ
$ S = pi r^2 $ <appendix-eq>
$ mat(
  1, 2, ..., 10;
  2, 4, ..., 20;
  3, 6, ..., 30;
  dots.v, dots.v, dots.down, dots.v;
  10, 20, ..., 100
) $
$ cal(A) < bb(B) < frak(C) < mono(D) < sans(E) < serif(F) $
$ bold(alpha < beta < gamma < delta < epsilon) $
$ upright(zeta < eta < theta < iota < kappa) $
$ lambda < mu < nu < xi < omicron $
$ bold(Sigma < Tau) < italic(Upsilon < Phi) < Chi < Psi < Omega $
  ```,
  [
$ S = pi r^2 $ <appendix-eq>
$ mat(
  1, 2, ..., 10;
  2, 4, ..., 20;
  3, 6, ..., 30;
  dots.v, dots.v, dots.down, dots.v;
  10, 20, ..., 100
) $
$ cal(A) < bb(B) < frak(C) < mono(D) < sans(E) < serif(F) $
$ bold(alpha < beta < gamma < delta < epsilon) $
$ upright(zeta < eta < theta < iota < kappa) $
$ lambda < mu < nu < xi < omicron $
$ bold(Sigma < Tau) < italic(Upsilon < Phi) < Chi < Psi < Omega $
  ]
))\

@complex 是一个非常复杂的公式的例子：

#tbl(tablex(
  columns: (1fr, 1fr),
  [
    #set align(center)
    代码
  ],
  [
    #set align(center)
    渲染结果
  ],
  ```typ
$ vec(overline(underbracket(underline(1 + 2) + overbrace(3 + dots.c + 10, "large numbers"), underbrace(x + norm(y), y^(w^u) - root(t, z)))), dots.v, u)^(frac(x + 3, y - 2)) $ <complex>
  ```,
  [
    $ vec(overline(underbracket(underline(1 + 2) + overbrace(3 + dots.c + 10, "large numbers"), underbrace(x + norm(y), y^(w^u) - root(t, z)))), dots.v, u)^(frac(x + 3, y - 2)) $ <complex>
  ]
))\

附录中也可以插入代码块，如 @appendix-code。

#codeblock(
  ```rust
  fn main() {
      println!("Hello, world!");
  }
  ```,
  caption: "一个简单的 Rust 程序",
  outline: true,
) <appendix-code>


