# Supervision Document Class for LaTeX

## Background

> A supervision is part of the way you get taught at the University of Cambridge. They are small (typically 2-3 students) teaching sessions where you go through some work

This is the successor of my [original supervision class][1]. The motivation for the original was to have a single place to put all the code required for my supervision work rather than copy and pasting every single time. Over time this caused the supervision class to become very bloated with lots of things being included that are only relevant for a few courses. I'm now tearing it apart and making it more modular.


The class extends the [exam document class][2] and thus supports most of its features.

## Installation

Git clone or download the package and then symlink it into the appropriate place (different depending on os and laTeX distibution). On osx with TeXlive running the following from the downloaded folder works (you may need to create that folder first).

```shell
ln -s $PWD ~/Library/texmf/tex/latex/local
```

Alternatively, put the `supervision.cls` file next to your document.

## Usage

If the course will have several supervisions then create a `course.sty` (otherwise just put this at the top).

```latex
\ProvidesPackage{course}

\Course{Course Name}
\author{Daniel Chatfield}
```

Then in `supervision-1.tex`:

```latex
\documentclass{supervision}
\usepackage{course}

\Supervision{3}

\begin{document}
  \begin{questions}
    \question[2]
      This is the first question, it is worth 2 marks

      \begin{solution}
        This is the solution
      \end{solution}

    \question
      \begin{parts}
        \part
          This part has no marks
      \end{parts}

    \SetQuestionNumber{4}
    \question
      We have skipped a question by manually setting the question number
  \end{questions}
\end{document}
```

### Minor tweaks

 - Palatino font
 - Remove the "Solution" text from the solution box
 - Show the solutions by default (pass the `hidesolutions` option to hide them)
 - Use "marks" instead of "points" and display in box in right margin


[1]: https://github.com/danielchatfield/latex-stuff/blob/master/supervision/supervision.cls

[2]: http://www-math.mit.edu/~psh/exam/examdoc.pdf
