% pet-final-report.cls - 2024/05/09
%
% Styling used for writing final reports in a sleeker way than provided
% templates by the department. Should adhere to required title page information
%
% Jacqueline W., Licensed under CC0

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pet-final-report}[2024/05/09 Class for University of York School
of PET Engineering Final Reports.]
\LoadClass[a4paper, twoside, 12pt]{report} % based on the report class

% packages for class only
\RequirePackage{graphicx}       % required for titlepage
\RequirePackage{tikz}           % required for titlepage
\RequirePackage{fancyhdr}       % header and footer customization
\RequirePackage{titlesec}       % chapter, section title customization
\RequirePackage{xcolor}         % chapter, section title customization
\RequirePackage[a4paper,inner=3cm,outer=2cm,top=2cm,bottom=2cm]{geometry}
                                % adhere to 2cm margin specified by department
                                % w/ 1cm extra for inner binding
\RequirePackage{setspace}       % modify lineheight for titlepage
\RequirePackage[sc]{mathpazo}
\RequirePackage[T1]{fontenc}    % eb garamond font default
\renewcommand*\ttdefault{txtt}
%\RequirePackage[none]{hyphenat} % no hyphenation across lines
\RequirePackage[labelfont=bf,textfont=it]{caption}
                                % subfigure support
\RequirePackage{subcaption}
\RequirePackage[most]{tcolorbox}% bg for custom verb
\RequirePackage{mdframed}
\RequirePackage{listings}
\RequirePackage[style=ieee]{biblatex}

% add paths for bibliography and graphics
\graphicspath{ {./assets/} }
\addbibresource{references.bib}


% defaults for lengths
\setlength{\parskip}{1ex}
\setlength{\parindent}{0pt}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footnoterule}{}
\addtolength{\skip\footins}{2pc plus 5pt minus 1pt}
\linespread{1.1}
\setlength{\headheight}{14.49998pt}

% Custom commands for titlepage fields
\newcommand*{\project}[1]{\gdef\@project{#1}} % project title
\newcommand*{\module}[1]{\gdef\@module{#1}} % module code
\newcommand*{\acyear}[1]{\gdef\@acyear{#1}} % academic year
\newcommand*{\supervisor}[1]{\gdef\@supervisor{#1}} % supervisors
\newcommand*{\college}[1]{\gdef\@college{#1}} % student college

% custom titlepage
\makeatletter
\newcommand\HUGE{\@setfontsize\Huge{38}{47}} % huger 
\renewcommand*{\maketitle}{%
\begin{titlepage}
        \newgeometry{margin=2cm} % ignore twoside for this page
        \noindent
        \begin{tikzpicture}[remember picture,overlay]
                % top right uoy logo
                \node[anchor=north east,yshift=-1.8cm,xshift=-1.8cm]%
                at (current page.north east)
                {\includegraphics[height=25mm]{logo.pdf}};
                % line under uoy logo
                \draw (10.6, -2.2) -- (17.1, -2.2); 
                % shield gradient background
                \node[anchor=north west, yshift=-4cm, xshift=-9cm]%
                at (current page.north west)
                {\includegraphics[height=220mm]{logo_shield.pdf}};
        \end{tikzpicture}
        % left hand column
        \begin{minipage}[t]{0.4\textwidth}
                \doublespacing
                {\Huge\textsc{\textbf{\MakeUppercase{\@project}}}}\\
                {\Large\textit{BEng Project Final Report}}\\
                {\Large\textit{\@acyear}}\\
                {\large\textit{\@module}}
        \end{minipage}
        % right hand column
        \begin{minipage}[t]{0.6\textwidth}
                \raggedleft
                \vspace{24mm} % dont intersect with top right logo
                \setstretch{1.1}
                {\Large\textit{School of Physics,}}\\
                {\Large\textit{Engineering and}}\\
                {\Large\textit{Technology}}\\
        \end{minipage}
        
        % center page student info
        \begin{center}
                \vfill{}
                {\HUGE\@author}\\
                {\large\textit{\@college}}\\
                \vspace{4cm}
                {\Large\textbf{Supervisors}}\\
                {\Large\textit{\@supervisor}}\\
                \vspace{2cm}
                {\tiny\textit{Document compiled \@date}}
        \end{center}
        \restoregeometry
\end{titlepage}}
\makeatother

% custom header and footers
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\pagestyle{fancy}
\fancyhf{}

\makeatletter
\fancyhead[RO]{\leftmark}
\fancyhead[LE]{\textbf{\MakeUppercase{\@project}}}
\fancyhead[RE]{\textit{Final Report}}
\fancyfoot[C]{\thepage}
\makeatother

% custom chapter section subsec titles
\renewcommand{\chaptername}{}
\titleformat{\chapter}[hang]{\Huge\bfseries}{\textcolor{darkgray}%
{\thechapter \textbar }}{0pt}{}
\titleformat{name=\chapter,numberless}[hang]{\Huge\bfseries\centering}{}{0pt}{}
\titleformat{\section}[hang]{\Large\bfseries}{\textcolor{darkgray}%
{\thesection \textbar }}{0pt}{}
\titleformat{\subsection}[hang]{\large\bfseries}{\textcolor{darkgray}%
{\thesubsection \textbar }}{0pt}{}

% custom environments
\newenvironment{fracknowledgements}{\chapter*{Acknowledgements}\begin{center}}
    {\end{center}}

\newenvironment{frabstract}
    {\chapter*{Abstract}
    \addcontentsline{toc}{chapter}{Abstract}
    \begin{center}\begin{minipage}{0.8\linewidth}
    }
    {\end{minipage}\end{center}}

\newenvironment{frethics}
{\vfill{\let\clearpage\relax \chapter*{Statement of Ethics}}\begin{center}}
{\end{center}}

% custom command for verbatim w/ background
\definecolor{palegray}{gray}{0.90}
\tcbset{on line, 
        boxsep=2pt, left=0pt,right=0pt,top=0pt,bottom=0pt,
        colframe=white,colback=palegray,  
        highlight math style={enhanced}}
\newcommand*{\FRverb}[1]{\tcbox{\texttt{\detokenize{#1}}}}

\newcommand{\frcodelst}[1]
    {\begin{mdframed}{\scriptsize\setstretch{0.8}\texttt{\lstinputlisting{#1}}}%
    \end{mdframed}}

\newcommand{\frrisk}[2]
    {\begin{mdframed}\textbf{Risk: }#1 \vspace{6pt}\\ 
    \textbf{Mitigation: }#2\end{mdframed}}
