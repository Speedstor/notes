# Latex Cheatsheet

### Math Expressions
#### Symbols
- `\sum^{\infty}_{i=0}` -> $\sum^{\infty}_{i=0}$
- `\mathbb{N}` -> $\mathbb{N}$
- `=` & `\neq` -> $=$ & $\neq$

#### Matrixes
```latex
f(x)= 
\left \{
    \begin{matrix}
        x & \text{ if } x\geq0  \\
        -x&\text{ if } x<0
    \end{matrix}
\right.
```
$$
f(x)= \left\{\begin{matrix}x&\text{ if } x\geq0\\-x&\text{ if } x<0\end{matrix}\right.
$$


#### Margins
```latex
\begin{addmargin}[2em]{0em}
    content
\end{addmargin}

or 

\begin{adjustwidth}{2em}{0em}
    content
\end{adjustwidth}
```

#### Commands
```latex
  \addtocounter{enumi}{-1}
```

#### Define Commands
```latex
\def\labelitemi{-}

\definecolor{mygray}{RGB}{79, 79, 79}

\let\oldtexttt\texttt% Store \texttt
\renewcommand{\texttt}[2][black]{\textcolor{#1}{\ttfamily #2}}% \texttt[<color>]{<stuff>}

\setlength{\parskip}{0.05in}
\setlength{\parindent}{15pt}
```

#### Packages
```latex
\documentclass[fleqn]{article}
\usepackage[margin=1in]{geometry}
\usepackage{enumerate, comment}
\usepackage{adjustbox}
\usepackage{amssymb, amsmath, amsthm, verbatim, hyperref, color}
\usepackage{lastpage}
\usepackage{enumerate}
\usepackage{fancyhdr}
\usepackage{mathrsfs}
\usepackage{xcolor}
\usepackage{graphicx}
\usepackage{listings}
\usepackage{hyperref}
\usepackage{scrextend}
\usepackage{changepage}
\usepackage{mathtools}
\usepackage{parskip}
```

#### Ignore chktexs
```latex
% chktex-file 3
% chktex-file 36
```