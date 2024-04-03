\LoadClass[a4paper, fontset=fandol, punct=CCT]{ctexart}
\RequirePackage[svgnames]{xcolor}
\RequirePackage[skins,most,breakable]{tcolorbox}
\ProvidesClass{SYSUDaily}
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{fontspec}

\RequirePackage{xeCJKfntef}
\RequirePackage{eucal}
\RequirePackage{enumitem}
% \defaultfontfeatures{Mapping=tex-text}
\RequirePackage{fixdif}
\RequirePackage{mathtools}
\RequirePackage{kvoptions}

\SetupKeyvalOptions{
	family = @SYSUdaily,
	prefix = @SYSUdaily@
}
\DeclareBoolOption[false]{unimath}
\ProcessKeyvalOptions*

\if@SYSUdaily@unimath
  \RequirePackage{unicode-math}
  \@input{unim.clo}
  \IfFontExistsTF{方正新书宋_GBK}{
  \setCJKmainfont{方正新书宋_GBK}[
    ItalicFont = 华文楷体,
    BoldFont = 方正粗雅宋_GBK,
  ]
  }{}
  \IfFontExistsTF{苹方黑体-细-简.ttf}{
    \setCJKsansfont{苹方黑体-细-简.ttf}[
      BoldFont = 苹方黑体-细-简.ttf
    ]
  }{}
  \IfFontExistsTF{苹方黑体-细-简.ttf}{
    \setsansfont{苹方黑体-细-简.ttf}[
      BoldFont = 苹方黑体-细-简.ttf
    ]  
  }{}
  \IfFontExistsTF{Resource Han Rounded SC}
  {\setCJKmonofont[Scale = .9, FakeStretch=1.05]{Resource Han Rounded SC}}{}
\else
  \RequirePackage{amsfonts,amssymb}
  \RequirePackage{mathrsfs}
  \RequirePackage{dsfont}
  \RequirePackage{bm}
  \let\mathbb\mathds
  \IfFontExistsTF{Resource Han Rounded SC}{
  \setCJKmonofont[Scale = .9, FakeStretch=1.1]{Resource Han Rounded SC}
  }{}
  \AtBeginDocument{%
    \DeclareFontFamily{U}{msa}{}
    \DeclareFontShape{U}{msa}{m}{n}{%
      <-9>cmbras8%
      <9-10>cmbras9%
      <10->cmbras10%
    }{}
    \DeclareFontFamily{U}{msb}{}
    \DeclareFontShape{U}{msb}{m}{n}{%
      <-9>cmbrbs8%
      <9-10>cmbrbs9%
      <10->cmbrbs10%
    }{}
  }
\fi


\usetikzlibrary {shapes.geometric}
\RequirePackage{xpatch}
\RequirePackage[
	colorlinks,
	anchorcolor = black,
	filecolor = black,
	urlcolor = black,
	citecolor = black,
	hyperfootnotes = true,
	breaklinks = true,
	bookmarks = true
]{hyperref}

\newcounter{SYSUDaily@counter}
\stepcounter{SYSUDaily@counter}

% \definecolor{emptycolor}{RGB}{0,0,0}

\def\SYSUDaily@right{50pt+2mm}
\tcbset{
	mathstyles/.style={
			before={\medskip\par\noindent},
			after = {\vspace*{-3pt}},
			enhanced,
			toprule=3pt,
			fonttitle=\bfseries,
			fontupper=\itshape,
			height from = 45pt to 1000pt,
			enhanced,
			arc=0mm,
      breakable,
			outer arc=0mm,
			before skip balanced=2mm,
			after skip balanced=3mm,
			boxrule=1pt,
			left=3mm,
			right={\SYSUDaily@right},
			top=1mm,
			bottom=1mm,
			lefttitle=0pt,
			righttitle=0pt,
			height from = 6em to 19cm,
			colback=#1color!3,
			colframe=#1color!30,
			coltitle=#1color,
		}
}

\ExplSyntaxOn
\seq_new:N \c_math_styles_seq
\NewDocumentCommand{\Addmathstyles}{mO{}O{0,0,0}}{
\seq_put_right:Nn \c_math_styles_seq { #1 }
\cs_new:cpn { SYSUDaily@#1name } { #2 }
\definecolor{#1color}{RGB}{ #3 }
}
\NewDocumentCommand{\ShowSYSUDaily@name}{m}{\use:c { SYSUDaily@#1name } }
\ExplSyntaxOff

\Addmathstyles{theorem}[定理][12,12,150]
\Addmathstyles{definition}[定义][220,20,60]
\Addmathstyles{proposition}[命题][32,115,54]
\Addmathstyles{lemma}[引理][0,169,153]
\Addmathstyles{corollary}[推论][70,130,180]
\Addmathstyles{fact}[事实][119,136,153]
\Addmathstyles{example}[例子][255,182,193]
\Addmathstyles{think}[思考题][30,144,255]
\Addmathstyles{calculate}[计算题][139,69,19]
\Addmathstyles{brain}[脑筋急转弯][0,127,127]
\Addmathstyles{empty}

\newlength{\tempwaterrightskip}
\setlength{\fboxrule}{0.2pt}

\newcommand{\putstars} [2] {%
	\begin{tcbclipinterior}
		\path [fill=none,draw=none]
		(interior.south west) rectangle node [white]
			{
				\rotatebox{-90}{\small\color{#2color}%
					\ifnum #1>0
						\foreach\i in {1,...,#1}{%
								\makebox[2ex]{\rotatebox{90}{%
										\scalebox{.3}{\tikz{\node[star, star point ratio=2.5, draw, fill=#2color]at (1,1) {};}}}%
								}%
							}%
					\else\fi%
				}%
			}%
		([xshift=4mm]interior.north west);
	\end{tcbclipinterior}
}
\newcommand{\SYSUDaily@watermark} {
	\bfseries \makebox[.79\textwidth][r]{
		\smash{\rule[-8pt]{.8pt}{8pt+\baselineskip+1pt}}\hskip2mm
		\makebox[0pt][l]{ \parbox{60pt}{ \vspace*{-.4ex}笃学笃行，\\[.1ex]不悔不倦。 }}\hspace*{8pt}
	}
}

\newlength{\SYSUDaily@width}
\newlength{\SYSUDaily@height}
\setlength{\SYSUDaily@height}{52pt}
\setlength{\SYSUDaily@width}{0.8\textwidth}
\newsavebox{\SYSUDaily@measurebox}



\ExplSyntaxOn

\newtcolorbox{SYSUDaily@}[4]{%
	mathstyles = #1,%
	title      = {\bfseries\ShowSYSUDaily@name{#1}
  \exp_args:Nf\IfBlankTF{#4}{}{\the\value{SYSUDaily@counter}\stepcounter{SYSUDaily@counter}：#4%
			}\hfill{\ifx#2\empty\else\expandafter\SYSUDaily@Parameter@Date\fi}},%
	watermark~text = {\SYSUDaily@watermark},%
	underlay    = {\putstars{#3}{#1}},%
	fonttitle = {},
}
\newtcolorbox{SYSUDaily@empty}{%
  mathstyles=empty,
  top=1.5ex,
  bottom=1.5ex,
  watermark~text = {\SYSUDaily@watermark},
  fonttitle = {},
}%

\newcommand \SYSUDaily@Parameter@MathStyles { proposition }

\newcommand \SYSUDaily@Parameter@Title {}
% \str@setNn \SYSUDaily@Parameter@Title { proposition }

\newcommand \SYSUDaily@Parameter@Date { \today }

\newcommand \SYSUDaily@Parameter@Difficulty { 0 }

% \newcommand \SYSUDaily@ParameterMathStyles {proposition}
% \newcommand \SYSUDaily@Parameter@Date {\today}
% \newcommand \SYSUDaily@Parameter@Difficulty {0}
% \let\SYSUDaily@Parameter@Title\empty
\NewDocumentCommand{\SYSUDaily@check}{m}{
	\seq_if_in:NnTF \c_math_styles_seq {#1}
	{
    \PackageWarning{SYSUDaily}{MathStyles~check:~#1}
		\cs_set:cpn { SYSUDaily@Parameter@MathStyles } { #1 }
	}
	{
		\regex_match:nnTF { ^[+-]?\d+$ } {#1}
		{
			\PackageWarning{SYSUDaily}{Number~check:~#1}
			\int_compare:nTF {
				#1 > 100
			}
			{
				\SYSUDaily_set_date_format:n {#1}
				% \cs_set:cpn { SYSUDaily@ParameterDate } { #1 } 
			}
			{
				\int_compare:nTF {
					#1 < 5
				}
				{
					\cs_set:cpn { SYSUDaily@Parameter@Difficulty } { #1 }
				}
				{ }
			}
		}
		{
			\cs_set:cpn { SYSUDaily@Parameter@Title } { #1 }
		}
	}
}
\cs_new:Npn \SYSUDaily_set_date_format:n #1 {
	\int_compare:nTF { #1 > 999999 } {
		\SYSUDaily_set_date_format_eight:n  #1
	} {
		\int_compare:nTF { #1 > 9999 } {
			\SYSUDaily_set_date_format_six:n  #1
		} {
			\SYSUDaily_set_date_format_four:n  #1
		}
	}
}
\cs_new:Npn \SYSUDaily_set_leading_zero:n #1#2 {
	\int_compare:nTF { #1 = 0 } { #2 } { #1#2 }
}
\cs_new:Npn \SYSUDaily_set_date_format_eight:n #1#2#3#4#5#6#7#8 {
	\cs_set:cpn { SYSUDaily@Parameter@Date } {
		#1 #2 #3 #4 年\SYSUDaily_set_leading_zero:n {#5}{#6} 月\SYSUDaily_set_leading_zero:n {#7}{#8} 日
	}
}
\cs_new:Npn \SYSUDaily_set_date_format_six:nnnnnn #1#2#3#4#5#6 {
	\cs_set:cpn { SYSUDaily@Parameter@Date } {
		#1 #2 年\SYSUDaily_set_leading_zero:n {#3}{#4} 月\SYSUDaily_set_leading_zero:n {#5}{#6} 日
	}
}
\cs_new:Npn \SYSUDaily_set_date_format_four:nnnn #1#2#3#4 {
	\cs_set:cpn { SYSUDaily@Parameter@Date } {
		\SYSUDaily_set_leading_zero:n {#1}{#2} 月\SYSUDaily_set_leading_zero:n {#3}{#4} 日
	}
}

\NewDocumentEnvironment{daily}{ O{} +b } {
	\seq_set_from_clist:Nn \l_tmpa_seq {#1}
	\seq_reverse:N \l_tmpa_seq
	\seq_map_inline:Nn \l_tmpa_seq {
		% \PackageWarning{SYSUDaily}{check: ##1}
		\SYSUDaily@check {##1}
	}
	\hbox_set:Nn \l_tmpa_box {
		\begin{minipage}{\SYSUDaily@width}
			\itshape #2
		\end{minipage}
	}

	\dim_set:Nn \l_tmpa_dim {\box_ht:N \l_tmpa_box}

	\dim_compare:nTF {\l_tmpa_dim > 26pt} {
		\def\SYSUDaily@watermark{\bfseries 笃学笃行，不悔不倦。}
		\def\SYSUDaily@right{2mm}
	}{}

	\str_if_eq:nnTF {#1} {empty} {
		\begin{SYSUDaily@empty}
      #2
		\end{SYSUDaily@empty}
	} 
  {
    % \exp_args:Ncc
		\begin{SYSUDaily@}
      {\SYSUDaily@Parameter@MathStyles}
			{\SYSUDaily@Parameter@Date}
			{\SYSUDaily@Parameter@Difficulty}
			{\SYSUDaily@Parameter@Title}
			#2
    \end{SYSUDaily@}
	}
}
{}
\ExplSyntaxOff