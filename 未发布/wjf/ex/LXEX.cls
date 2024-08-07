% -*- coding: utf-8 -*-
% ----------------------------------------------------------------------------
% Author:  Jianrui Lyu <tolvjr@163.com>
% Website: https://lvjr.bitbucket.io/jnuexam.html
% License: The LaTeX Project Public License 1.3
% ----------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{LXEX}[2019/11/08 v0.7 An exercise class for University of LiXin]

\newif\ifsidebyside \sidebysidefalse % 是否 A3 纸张
\newif\ifreverse    \reversefalse    % 是否逆序出题
\newif\ifanswer     \answertrue      % 是否显示答案
\newif\ifamsfonts   \amsfontsfalse   % 切换数学字体
\newif\ifsourcehan  \sourcehanfalse  % 切换思源字体
\newif\ifdisplay    \displayfalse    % 切换展示公式
\newif\ifcollection \collectionfalse % 用于试卷题库

\DeclareOption{a3paper}{\sidebysidetrue}
\DeclareOption{reverse}{\reversetrue}
\DeclareOption{noanswer}{\answerfalse}
\DeclareOption{amsfonts}{\amsfontstrue}
\DeclareOption{sourcehan}{\sourcehantrue}
\DeclareOption{display}{\displaytrue}
\DeclareOption{collection}{\collectiontrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}} %其它选项

\ProcessOptions %不可省略

% 四号    小四号    五号      小五号
% 14bp    12bp      10.5bp    9bp
\LoadClass[cs4size,UTF8,noindent]{ctexbook}

\ifamsfonts
  \RequirePackage{amssymb}
\else
  \RequirePackage[utopia]{mathdesign} % charter, utopia
  \renewcommand\bfdefault{bx}
  \let\oldoiint\oiint\renewcommand{\oiint}{\oldoiint\nolimits}
  \DeclareTextCommandDefault{\nobreakspace}{\leavevmode\nobreak\ }
\fi

\ifsidebyside
  \RequirePackage[a3paper,landscape,twocolumn,columnsep=40mm,left=50mm,right=30mm,top=25mm,bottom=25mm]{geometry}
\else
  \RequirePackage[a4paper,left=30mm,right=30mm,top=25mm,bottom=25mm]{geometry}
\fi

\RequirePackage{tabularx}
\RequirePackage{lastpage}
\RequirePackage{fancyhdr}
\RequirePackage{xcolor}
\RequirePackage{comment}
\RequirePackage{environ}
\RequirePackage{etoolbox}
\RequirePackage{calc}

\newcolumntype{Y}{>{\centering\arraybackslash}X}
\newcolumntype{n}[1]{>{\centering\arraybackslash}m{#1}}

\setlength{\parindent}{0em}
\setlength{\lineskiplimit}{4pt}
\setlength{\lineskip}{4pt}

%% ---------------------------------------------------------------------------
%% 密封线命令 \mifengxian
%% 草稿纸命令 \caogaozhi
%% 这两个命令仅在 A3 纸张中用到，且需要编译两次才能得到正确结果
%% ---------------------------------------------------------------------------



\ifsidebyside
  \RequirePackage{tikz}
  \RequirePackage{everypage}
  %\AddEverypageHook{\mifengxian}
  % 在 twocolumn 文档中，\newpage 可能是到下一栏，\clearpage 才能保证到下一页
  %\preto{\@enddocumenthook}{\clearpage\pagestyle{empty}\caogaozhi\clearpage\caogaozhi\addtocounter{page}{-2}}
  % 在旧版本 ctex 宏包中不能用 \AtEndDocument 添加含中文的内容，即不能用 \appto 而要用 \preto
  %\AtEndDocument{\clearpage\pagestyle{empty}\caogaozhi\clearpage\caogaozhi\addtocounter{page}{-2}}
  \RequirePackage{pdfpages}
  % 新版本 pdfpages 将 \includepdf 放在文档开头时会有命令未定义的错误
  % 见 https://tex.stackexchange.com/questions/352007/ieeetran-and-pdfpages
  % 另外从 LaTeX release 2018 开始 \@ifundefined 不再将未定义命令定义为 \relax
  % 见 https://www.latex-project.org/news/latex2e-news/ltnews28.pdf
  \@ifundefined{@setmarks}{\let\@setmarks\relax}{}
\fi

%% ---------------------------------------------------------------------------
%% 试卷表头命令 \makehead
%% ---------------------------------------------------------------------------

\newcommand{\niandu}{2016-2017}
\newcommand{\xueqi}{2}
\newcommand{\kecheng}{数学课程}
\newcommand{\zhuanye}{}  % 专业学分
\newcommand{\jiaoshi}{吕荐瑞}
\newcommand{\shijian}{}  % 考试日期
\newcommand{\bixiu}{1}   % 1 为必修，0 为选修
\newcommand{\bijuan}{1}  % 1 为闭卷，0 为开卷
\newcommand{\shijuan}{A} % A 或 B 或 C 卷
\newcommand{\neizhao}{1} % 1 打勾，0 不勾
\newcommand{\waizhao}{1} % 1 打勾，0 不勾

\newcommand{\underspace}[1]{\kern0pt\underline{\hspace{#1}}\kern0pt\relax}
\newcommand{\underbox}[2]{\kern0pt\underline{\makebox[#1]{#2}}\kern0pt\relax}
\newcommand{\underparbox}[2]{\kern0pt\underline{\parbox[b]{#1}{#2}}\kern0pt\relax}

\newcommand{\ischeck}[1]{\ifnum#1>0\,$\checkmark$\,\else\quad\fi}
\newcommand{\isquad}[1]{\ifnum#1=0\,$\checkmark$\,\else\quad\fi}

\newcommand\my@temp@a{A}
\newcommand\my@temp@c{C}
\newcommand\my@empty{}




%% ---------------------------------------------------------------------------
%% 页眉页脚设定
%% ---------------------------------------------------------------------------

%\newcommand{\my@columnbox}[1]{\makebox[\columnwidth]{#1}}
%\newcommand{\my@headleft}{上海立信会计金融学院\kern-0.3em《\kecheng》\kern-0.3em 试卷\,\shijuan}
%\newcommand{\my@headright}{姓名\hspace{6em}学号\hspace{6em}}
%\newcommand{\my@headtext}{\my@headleft\hfill \my@headright}
%\newcommand{\my@foottext}{第~\thepage~页\quad 共~\pageref{LastPage}~页}
%
%\fancypagestyle{plain}{
%  \renewcommand{\headrulewidth}{0pt}%
%  \fancyhf{}
%  \ifsidebyside
%    \rhead{\small\underline{\my@columnbox{\my@headtext\strut}}}
%    \lfoot{\small\my@columnbox{\my@foottext}}
%    \rfoot{\small\my@columnbox{\stepcounter{page}\my@foottext}}
%  \else
%    \cfoot{\small\my@foottext}
%  \fi
%}
%\fancyhf{}
%\pagestyle{fancy}
%\ifsidebyside
%  \renewcommand{\headrulewidth}{0pt}%
%  \lhead{\small\underline{\my@columnbox{\my@headtext}\strut}}
%  \rhead{\small\underline{\my@columnbox{\my@headtext}\strut}}
%  \lfoot{\small\my@columnbox{\my@foottext}}
%  \rfoot{\small\my@columnbox{\stepcounter{page}\my@foottext}}
%\else
%  \lhead{\small\my@headleft}
%  \rhead{\small\my@headright}
%  \cfoot{\small\my@foottext}
%\fi

%% ---------------------------------------------------------------------------
%% 题型命令 \makepart
%% 附录命令 \makedata
%% 题目环境 problem
%% 解答环境 solution
%% 逆序选项 reverse
%% ---------------------------------------------------------------------------

\xdef\allproblems{}
\xdef\lastproblem{}
\newcounter{problem}
\newcommand{\solutionname}{解}
\newcounter{choice} % 后面选择题的 abcd 环境要用到
\newcounter{step}   % 后面解答题的 \step 命令要用到

\newcommand{\printproblems}{\ifreverse\lastproblem\allproblems\fi\xdef\allproblems{}\xdef\lastproblem{}}

\newcommand{\makepart}[2]{%
    \printproblems
    \setcounter{problem}{0}%
    \stepcounter{section}%
    \vspace{1em}%
    \textbf{\Chinese{section}、#1}
%    \noindent\begin{tabularx}{\linewidth}{|n{1.7cm}|n{1.7cm}|X}
%      \cline{1-2}
%      得分 & 评阅人 & \textbf{\Chinese{section}、#1}\\
%      \cline{1-2}
%      &  & (#2) \\
%      \cline{1-2}
%    \end{tabularx}
    \par\vspace{1em}
}

\newcommand{\makedata}[1]{%
  \printproblems\my@stop@reverse
  \centerline{\textbf{附录}\quad #1}\smallskip
}

\preto{\@enddocumenthook}{\printproblems\my@stop@reverse}

\newcommand\ignorepars{\@ifnextchar\par{\expandafter\ignorepars\@gobble}{}}

\newenvironment{problemreal}{%
  \stepcounter{problem}\setcounter{choice}{0}\setcounter{step}{0}%
  \textbf{\textsf{{\color{black}\arabic{problem}}.}}\;\,\ignorespaces
}{\par}
\newenvironment{solutionreal}{%
  \setcounter{step}{0}%
  \textbf{\textsf{{\color{black}\solutionname}.}}\;\,\ignorepars
}{\par}

\let \oldnewpage   = \newpage
\let \oldvfill     = \vfill
\let \oldsmallskip = \smallskip
\let \oldmedskip   = \medskip
\let \oldbigskip   = \bigskip

\ifreverse
  \NewEnviron{problem}{%
    \xdef\allproblems{%
      \unexpanded\expandafter{\lastproblem}%
      \unexpanded\expandafter{\allproblems}%
    }%
    \xdef\lastproblem{%
      \unexpanded{\begin{problemreal}}%
      \unexpanded\expandafter{\BODY}%
      \unexpanded{\end{problemreal}}%
    }%
  }
  \NewEnviron{solution}{%
    \xdef\lastproblem{%
      \unexpanded\expandafter{\lastproblem}%
      \unexpanded{\begin{solutionreal}}%
      \unexpanded\expandafter{\BODY}%
      \unexpanded{\end{solutionreal}}%
    }%
  }
  \renewcommand{\newpage}{\xdef\lastproblem{\noexpand\oldnewpage\unexpanded\expandafter{\lastproblem}}}
  \renewcommand{\vfill}{\xdef\lastproblem{\unexpanded\expandafter{\lastproblem\oldvfill}}}
  \renewcommand{\smallskip}{\xdef\lastproblem{\unexpanded\expandafter{\lastproblem\oldsmallskip}}}
  \renewcommand{\medskip}{\xdef\lastproblem{\unexpanded\expandafter{\lastproblem\oldmedskip}}}
  \renewcommand{\bigskip}{\xdef\lastproblem{\unexpanded\expandafter{\lastproblem\oldbigskip}}}
  \let \newpagea = \relax
  \let \newpageb = \newpage
\else
  \newenvironment{problem}{\problemreal}{\endproblemreal\bigskip}
  \newenvironment{solution}{\solutionreal}{\endsolutionreal}
  \let \newpagea = \newpage
  \let \newpageb = \relax
\fi

\newcommand{\my@stop@reverse}{%
  \ifreverse
    \renewenvironment{problem}{\problemreal}{\endproblemreal\bigskip}%
    \renewenvironment{solution}{\solutionreal}{\endsolutionreal}%
    \let \newpage   = \oldnewpage
    \let \vfill     = \oldvfill
    \let \smallskip = \oldsmallskip
    \let \medskip   = \oldmedskip
    \let \bigskip   = \oldbigskip
  \fi
}

\def\CommentCutFile{\jobname.cut}

\AtBeginDocument{%
  \ifanswer\else
    \excludecomment{solution}
  \fi
}

%% ---------------------------------------------------------------------------
%% 答题栏命令 \answertable
%% ---------------------------------------------------------------------------

\gdef\answer@lines@temp{}%
\newcommand{\answer@lines@add}[1]{%
  \xdef\answer@lines@temp{\answer@lines@temp#1}%
}

\newrobustcmd{\answer@number@hided}[1]{小题} % 在 PDFLaTeX 中需要保护中文
\newrobustcmd{\answer@cell@strut}[1]{\parbox[c][#1][c]{2em}{\hbox{答案}}}

\newcounter{answer@col}
\newcounter{answer@row}
\newcounter{answer@total}

\newcommand{\answer@lines}[3]{%
  % #1 答题栏各栏指定高度
  % #2 答题栏总共答案个数
  % #3 答题栏每行答案个数
  \setcounter{answer@row}{(#2-1)/#3+1}% 除法向下取整，改为向上取整
  \begingroup
  \let\hline=\relax  \let\\=\relax % 禁止展开
  \gdef\answer@lines@temp{}%
  \setcounter{answer@total}{1}%
  \whileboolexpr{
      test{\ifnumgreater{\value{answer@row}}{0}}
  }{%
      \addtocounter{answer@row}{-1}%
      \answer@lines@add{\answer@number@hided}%
      \setcounter{answer@col}{1}%
      \unlessboolexpr{%
          test{\ifnumgreater{\value{answer@col}}{#3}}%
      }{%
          \answer@lines@add{&}%
          \ifnumgreater{\value{answer@total}}{#2}{}{%
            \answer@lines@add{\arabic{answer@total}}%
          }%
          \stepcounter{answer@col}%
          \stepcounter{answer@total}%
      }%
      \answer@lines@add{\\ \hline \answer@cell@strut{#1}}%
      \setcounter{answer@col}{1}%
      \unlessboolexpr{
          test{\ifnumgreater{\value{answer@col}}{#3}}
      }{%
          \answer@lines@add{&}%
          \stepcounter{answer@col}%
      }%
      \answer@lines@add{\\ \hline}%
  }%
  \endgroup
  \answer@lines@temp
}

\newcommand{\answertable}[3][1em]{%
  答题须知：本题答案必须写在如下表格中，否则不给分．\par
  \begin{tabularx}{\linewidth}{|c|*{#3}{Y|}}
    \hline
    \answer@lines{#1}{#2}{#3}
  \end{tabularx}%
  \par\vspace{0.8em}%
}

%% ---------------------------------------------------------------------------
%% 答案切换命令 \answer
%% 判断命令 \true 和 \false
%% 填空命令 \fillin 和 \fillout
%% 选择命令 \pickin 和 \pickout
%% 四个选项排版环境 abcd，根据四个选项的长度自动排成一行、两行或四行
%% ---------------------------------------------------------------------------

\newcommand{\answer}[1]{\ifanswer#1\else\phantom{#1}\fi}

\newcommand{\cdotfill}{\leavevmode\xleaders\hbox to 0.5em{\hss$\cdot$\hss}\hfill\kern0pt\relax}
\newcommand{\true}{\unskip\nobreak\cdotfill(\makebox[1.5em]{\color{blue}\answer{$\checkmark$}})}
\newcommand{\false}{\unskip\nobreak\cdotfill(\makebox[1.5em]{\color{blue}\answer{\sffamily x}})}

\newcommand{\ulinefill}[1]{\xleaders\hbox{\underline{\vphantom{#1}\kern1pt}}\hfill\kern0pt}
\newcommand{\fillout}[1]{\allowbreak\hbox{}\nobreak\ulinefill{#1}\underline{\color{blue}\answer{#1}}\ulinefill{#1}}
\newcommand{\fillin}[1]{\underline{\hspace{1em}\color{blue}\answer{#1}\hspace{1em}}}

\newcommand{\pickout}[1]{\unskip\nobreak\cdotfill(\makebox[1.5em]{\color{blue}\answer{#1}})}
\newcommand{\pickin}[1]{\unskip\nobreak\hspace{0.3em}(\makebox[1.5em]{\color{blue}\answer{#1}})\hspace{0.3em}\ignorespaces}

\newlength{\my@item@len}
\newcommand\my@item@temp{%
  \unskip\cr\stepcounter{choice}(\Alph{choice})\ %
}
\newcommand\my@item@box{%
  \hfill\egroup\hfill\hbox to \my@item@len\bgroup
  \stepcounter{choice}(\Alph{choice})\ \ignorespaces
}
\newcommand\my@item@par{%
  \par\stepcounter{choice}(\Alph{choice})\ \ignorespaces
}
\NewEnviron{abcd}{
  \unskip
  \setlength{\parindent}{0pt}%
  \setlength{\parskip}{0pt}%
  \setcounter{choice}{0}%
  \let\item=\my@item@temp
  \settowidth{\my@item@len}{\vbox{\halign{##\hfil\cr\BODY\crcr}}}%
  \setcounter{choice}{0}%
  \ifdim\my@item@len>0.486\linewidth
    \setlength{\my@item@len}{\linewidth}%
    \let\item=\my@item@par
    \BODY\par
  \else
    \ifdim\my@item@len>.243\linewidth
      \setlength{\my@item@len}{0.5\linewidth}%
    \else
      \setlength{\my@item@len}{0.25\linewidth}%
    \fi
    \let\item=\my@item@box
    \par\bgroup\BODY\hfill\egroup\par
  \fi
}

%% ---------------------------------------------------------------------------
%% 解答题步骤命令 \step
%% ---------------------------------------------------------------------------

\newcommand{\step}{%
  \stepcounter{step}%
  \textsf{(\arabic{step})}\;\,%
}

%% ---------------------------------------------------------------------------
%% 自由对齐命令 \tabpoint, \tabto, \tableft
%% 命令 \tabpoint 记录当前的水平位置，也可以简写为 \?
%% 命令 \tabto 跳到之前记录的位置，也可以简写为 \+
%% 命令 \tableft 跳到之前记录的位置的左侧，也可以简写为 \<
%% 这些自由对齐命令需要编译两次才能生效
%% ---------------------------------------------------------------------------

\usepackage{zref-savepos}

\@ifundefined{zsaveposx}{\let\zsaveposx\zsavepos}{} % 旧版本无 \zsaveposx 命令

\newcounter{saveposcnt}
\newcounter{useposcnt}
\renewcommand*{\thesaveposcnt}{savepos\number\value{saveposcnt}}
\renewcommand*{\theuseposcnt}{usepos\number\value{useposcnt}}

\def\my@alignment@offset{}

\def\my@alignment@list{}
\forcsvlist{\listadd\my@alignment@list}{=,<,>,\le,\ge,\leq,\geq,\approx}

\newlength{\my@alignment@kern}

\newcommand*{\my@alignment@check}[1]{%
  \ifx\my@let@token #1%
    \def\my@alignment@offset{5}%
    \listbreak
  \fi
}

\newcommand{\my@alignment@next}{%
  \ifdefempty{\my@alignment@offset}{%
    \def\my@alignment@offset{0}%
    \forlistloop{\my@alignment@check}{\my@alignment@list}%
  }{}%
  \settowidth{\my@alignment@kern}{$\mkern\my@alignment@offset mu$}%
  \stepcounter{saveposcnt}%
  \rlap{\kern\my@alignment@kern\zsaveposx{\thesaveposcnt}}%
}

\newcommand*{\tabpoint}[1][]{%
  \leavevmode
  \def\my@alignment@offset{#1}%
  \futurelet\my@let@token\my@alignment@next
}
\let \? = \tabpoint

\newcommand*{\tabto}{%
  \stepcounter{useposcnt}%
  \zsaveposx{\theuseposcnt}%
  \noindent
  \hskip\zposx{\thesaveposcnt}sp\relax
  \hskip-\zposx{\theuseposcnt}sp\relax
  \ignorespaces
}
\let \+ = \tabto

\newcommand*{\tableft}{%
  \settowidth{\my@alignment@kern}{$=\mkern5mu$}%
  \stepcounter{useposcnt}%
  \zsaveposx{\theuseposcnt}%
  \noindent
  \hskip\zposx{\thesaveposcnt}sp\relax
  \hskip-\zposx{\theuseposcnt}sp\relax
  \hskip-\my@alignment@kern
  \ignorespaces
}
\let \< = \tableft

%% ---------------------------------------------------------------------------
%% 评分命令 \score
%% ---------------------------------------------------------------------------

\PassOptionsToPackage{tbtags}{amsmath}
\RequirePackage{amsmath}

\newcommand{\myscore}[1]{\textcolor{blue}{#1\kern0.2em 分}}

\newcommand{\scoretext}[1]{\cdotfill\myscore{#1}\par\noindent\ignorespaces}
\newcommand{\scoreeqno}[1]{\eqno{\cdots\cdots\text{\myscore{#1}}}}
\newcommand{\scoretag}[1]{\tag*{$\cdots\cdots$\myscore{#1}}}

\newrobustcmd{\score}[1]{%
  \ifbool{mmode}{%
    \ifdefstrequal{\tag}{\dft@tag}{\scoreeqno{#1}}{\scoretag{#1}}%
  }{%
    \scoretext{#1}%
  }%
}

%% ---------------------------------------------------------------------------
%% 文档选项 display 将全部公式都设为展示公式
%% 命令 \display 将当前环境的公式都设为展示公式
%% ---------------------------------------------------------------------------

\newcommand{\display}{\everymath\expandafter{\the\everymath\displaystyle}}
\ifbool{display}{\display}{}

%% ---------------------------------------------------------------------------
%% 载入个人定制文件 jnuexam.cfg
%% 中文字体切换选项 sourcehan
%% ---------------------------------------------------------------------------

\InputIfFileExists{jnuexam.cfg}{}{}

\newcommand{\my@set@sourcehan}{
  \setCJKmainfont[BoldFont=Source Han Sans SC]{Source Han Serif SC}
  \setCJKsansfont{Source Han Sans SC}
  % 用中文字体名时 LuaTeX 找不到该字体，XeTeX 正常
  %\setCJKmainfont[BoldFont=思源黑体]{思源宋体}
  %\setCJKsansfont{思源黑体}
}

\ifbool{sourcehan}{
  \RequirePackage{iftex}
  % https://sourceforge.net/p/xetex/code/ci/master/tree/source/texk/web2c/xetexdir/NEWS
  \ifbool{XeTeX}{ % TeXLive 2015
    \ifdimless{\the\XeTeXversion\XeTeXrevision pt}{0.99992pt}{}{\my@set@sourcehan}
  }{}
  \ifbool{LuaTeX}{\my@set@sourcehan}{}
}{}

%% ---------------------------------------------------------------------------
%% 试卷题库选项 collection
%% ---------------------------------------------------------------------------

\ifcollection
  \RequirePackage{hyperref}
  \hypersetup{
    pdfstartview={FitH},
    bookmarksnumbered=true,
    unicode=true,
    hidelinks=true
    %colorlinks=true,
    %linkcolor=black
  }
  \appto{\endproblem}{\medskip}
  \appto{\endsolution}{\medskip}
  \preto{\problem}{\ifnum\value{problem}=9 \setcounter{problem}{-1}\fi}
  \pagestyle{plain}
\fi

%% ---------------------------------------------------------------------------
%% 载入常用宏包，定义常用命令
%% ---------------------------------------------------------------------------

\AtBeginDocument{
  \setlength{\abovedisplayskip}{4pt minus 2pt}
  \setlength{\belowdisplayskip}{4pt minus 2pt}
  \setlength{\abovedisplayshortskip}{2pt}
  \setlength{\belowdisplayshortskip}{2pt}
}

\setlength\arraycolsep{4pt}

\RequirePackage{CJKfntef}
\RequirePackage{multirow}
\RequirePackage{diagbox}
\RequirePackage{tabu}

\RequirePackage{relsize}
\newcommand{\Int}{\mathop{\mathlarger{\int}}}

\newcommand{\e}{\mathrm{e}}
\newcommand{\limit}{\lim\limits}
\newcommand{\R}{\mathbb{R}}

\DeclareMathOperator{\Corr}{\rho}
\DeclareMathOperator{\Cov}{Cov}
\DeclareMathOperator{\grad}{grad}
\DeclareMathOperator{\Prj}{Prj}
\DeclareMathOperator{\Var}{Var}

\newcommand{\diff}{\mathop{}\!\mathrm{d}}
\newcommand{\dx}{\diff x}
\newcommand{\dy}{\diff y}
\def\dz{\diff z} % 不确定命令是否已经定义
\newcommand{\du}{\diff u}
\newcommand{\dv}{\diff v}
\newcommand{\dr}{\diff r}
\newcommand{\ds}{\diff s}
\newcommand{\dt}{\diff t}
\newcommand{\dS}{\diff S}
% 有些宏包比如 hyperref 会修改 \d 的定义，所以放在 document 开始处
% 利用 etoolbox 将 \d 定义为健壮命令，以避免在 align 等环境中错误地展开
\AtBeginDocument{%
  \let\oldd=\d
  \renewrobustcmd{\d}{\ifbool{mmode}{\diff}{\oldd}}%
}

% from mathabx package
\DeclareFontFamily{U}{mathx}{\hyphenchar\font45}
\DeclareFontShape{U}{mathx}{m}{n}{<-> mathx10}{}
\DeclareSymbolFont{mathx}{U}{mathx}{m}{n}
\DeclareMathAccent{\widebar}{0}{mathx}{"73}

\newcommand{\va}{\vec{a}}
\newcommand{\vb}{\vec{b}}
\newcommand{\vc}{\vec{c}}
\newcommand{\vd}{\vec{d}}
\newcommand{\ve}{\vec{e}}
\newcommand{\vi}{\vec{i}}
\newcommand{\vj}{\vec{j}}
\newcommand{\vk}{\vec{k}}
\newcommand{\vn}{\vec{n}}
\newcommand{\vs}{\vec{s}}
\newcommand{\vv}{\vec{v}}

\let\ov=\overrightarrow

\let\le=\leqslant
\let\ge=\geqslant

\let\lb=\{
\let\rb=\}

\def\T{\mathrm{T}\kern-.5pt}

\newrobustcmd{\wfrac}[3][2pt]{%
  {\begingroup\hspace{#1}#2\hspace{#1}\endgroup\over\hspace{#1}#3\hspace{#1}}%
}

