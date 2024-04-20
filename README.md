# Typst Template for SUSTech UG Thesis<br/>南科大本科生毕业设计Typst模版

![sustech-ug-thesis-typst](./resources/images/cover.png)

The full PDF file is available [here](./resources/sample.pdf), which includes the basic syntax of Typst.

## Usage

The templates in both languages are crafted based on the 
[official template](https://tao.sustech.edu.cn/studentService/graduation_project.html), but discrepancies exist between 
this template and the formal guideline, and this template hasn't been test out, because I haven't graduated yet. 
**Use at your own risk.** If you come across a problem, please raise an issue or consider fixing it and raising a pull request.

- Install the latest version of [Typst](https://github.com/typst/typst). It's way easier and faster than Latex!
- Download and extract the entire project
- Modify `metadata.typ` and `thesis.typ`
- Run `typst compile thesis.typ --font-path resources/fonts` to compile the thesis
- Alternatively, you can run `typst watch thesis.typ --font-path resources/fonts` to preview the result as you type

Do **NOT** use it in the official Typst web app because it will take forever to load every time you open the document.

## TODO

- ~Tables and images, including captions~
- ~Footnotes~
- ~Bibliography~
- ~English version~
- Upload to the official template repo

## Acknowledgement

This template is based on lucifer1004's *excellent* project [pkuthss-typst](https://github.com/lucifer1004/pkuthss-typst). It did most of the dirty job and helped me understand Typst and templates.
