\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{supervision}
    [2015/11/14 Supervision work class (Daniel Chatfield)]

\RequirePackage{etoolbox} % Provides lots of useful commands, needs to be at
                          % the top as we use several commands


%% We want to be able to set the question or part number without fiddling with counters, to be able to do this we need to keep track of which environment we are in

\newtoggle{InQuestions}
\newtoggle{InParts}
\newtoggle{InSubParts}

\AtBeginEnvironment{questions}{\toggletrue{InQuestions}}
\AtBeginEnvironment{parts}{\toggletrue{InParts}}
\AtBeginEnvironment{subparts}{\toggletrue{InSubParts}}

%% Use these for typesetting the heading

\newtoggle{CourseSet}
\newtoggle{TopicsSet}
\newtoggle{SupervisionSet}
\newtoggle{AuthorSet}


%% The exam class defaults to hiding solutions, we want it to default to showing them but still have a way to override it
\newtoggle{ShowSolutions}
\toggletrue{ShowSolutions}

%% Our custom options
\DeclareOption{hidesolutions}{
    \togglefalse{ShowSolutions}
}
\DeclareOption{answers}{
    % This is the exam class option but we have overridden its behaviour so display a warning
    \ClassWarning{supervision}{Ignoring option 'answers', use `HideSolutions`
    instead}
}

%% Pass any other options to the exam class
\DeclareOption*{
    \PassOptionsToClass{\CurrentOption}{exam}
}

%% Default options
\ExecuteOptions{12pt}

%% Process passed options
\ProcessOptions\relax

%% Check whether we should show the answers
\iftoggle{ShowSolutions}{%
    \PassOptionsToClass{answers}{exam}
}


%% Load exam class
\LoadClass[a4paper,12pt]{exam}

%% Load additional packages
\RequirePackage[margin=3cm]{geometry}
\RequirePackage{graphicx}
\RequirePackage{parskip} % Adds spacing between paragraphs
\RequirePackage{titling}
\RequirePackage[sc]{mathpazo} % Set the font to Palatino
\RequirePackage[T1]{fontenc} % http://tex.stackexchange.com/a/677

%% Setup document
\pagestyle{headandfoot}
\runningheader{\theauthor}{\Course \ supervision \Supervision}{\thedate}
\footer{}{Page \thepage}{}
\marksnotpoints
\bracketedpoints
\pointsdroppedatright
\pointsinrightmargin
\linespread{1.05}         % Palatino needs more leading (space between lines)


% Add support for loading graphics from `figure` folder
% TODO should this be in a separate package?
\graphicspath{ {./figure/} }

% Set the date to today
\date{\today}

% Remove 'solution' from solution box
\renewcommand{\solutiontitle}{\noindent}


%% Command to set question number
\newcommand{\SetQuestionNumber}[1]{
    % Check if in part environment
    \iftoggle{InSubParts}{
        \setcounter{subpart}{#1}
        \addtocounter{subpart}{-1}
    } {
        \iftoggle{InParts}{
            \setcounter{partno}{#1}
            \addtocounter{partno}{-1}
        } {
            \iftoggle{InQuestions}{
                \setcounter{question}{#1}
                \addtocounter{question}{-1}
            } {
                \ClassError{supervision}{Cannot use '\\setquestionnumber' outside questions environment}
            }
        }
    }
}

\newcommand{\@Course}{}
\newcommand{\Course}[1]{
    \ifstrempty{#1}{
        \togglefalse{CourseSet}
    } {
        \toggletrue{CourseSet}
    }
    \renewcommand{\@Course}{#1}
}

\newcommand{\@Topics}{}
\newcommand{\Topics}[1]{
    \ifstrempty{#1}{
        \togglefalse{TopicsSet}
    } {
        \toggletrue{TopicsSet}
    }
    \renewcommand{\@Topics}{#1}
}

\newcommand{\@Supervision}{}
\newcommand{\Supervision}[1]{
    \ifstrempty{#1}{
        \togglefalse{SupervisionSet}
    } {
        \toggletrue{SupervisionSet}
    }
    \renewcommand{\@Supervision}{#1}
}

\AtBeginDocument{
    \renewcommand{\Course}{\@Course}
    \renewcommand{\Topics}{\@Topics}
    \renewcommand{\Supervision}{\@Supervision}

    \iftoggle{TopicsSet} {
        \title{\@Topics}
    } {
        \iftoggle{SupervisionSet} {
            \title{\@Course: \ Supervision \@Supervision}
        }{
            \title{\@Course}
        }
    }

    \maketitle
    \thispagestyle{headandfoot}
}



\endinput
