alias e="gvim -p dawoodiss.tex introduction.tex literature.tex experiments.tex al makefile bmake.sh &"
alias v="make view"
alias x="make xview"
alias xa="make xviewans"
alias p="make dawoodiss.pdf"
alias b="bibtex dawoodiss"
alias pr="make print"
alias sa="more al"
alias wdawoodiss="if [ -d /home/addie/usq/pg/PhD/Dawood/dissertation ]; then cd /home/addie/usq/pg/PhD/Dawood/dissertation; else cd /home/addie/usq/pg/PhD/Dawood; cvs -d  checkout ; cd ; fi; source ./al"
export CVSROOT=/home/addie/usq/pg/PhD/Dawood/CVS
./bmake.sh &
newpaper -upd dawoodiss
