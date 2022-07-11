let tmo=1
let tcount=1
while true
do if [[  ! ( -f "dawoodiss.pdf" )  || ( "dawoodiss.tex" -nt "dawoodiss.pdf" ) || ( "introduction.tex" -nt "dawoodiss.pdf" ) || ( "literature.tex" -nt "dawoodiss.pdf" ) || ( "cybersecuritydesign.tex" -nt "dawoodiss.pdf" ) || ( "stakeholderanalysis.tex" -nt "dawoodiss.pdf" ) || ( "conclusion.tex" -nt "dawoodiss.pdf" ) || ( "methodology.tex" -nt "dawoodiss.pdf" ) || ( "socialcontract.tex" -nt "dawoodiss.pdf" ) ]]
   then    make
       let tmo=1
       let tcount=1
   else let tcount=$tcount+1
       if [[ $tcount -lt 480 ]]
       then let tcount=$tcount+1
       else let tmo=2*$tmo
	    let tcount=1
       fi
   fi
   if [[ $tmo -gt 60 ]]
   then echo "Quitting bmake.sh due to inactivity.
"
        exit
   else sleep $tmo
   fi
done
