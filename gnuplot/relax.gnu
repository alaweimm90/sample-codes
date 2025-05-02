reset 

set terminal pngcairo size 1440,900 enhanced crop font 'Helvetica,10'
set output 'relaxation.png'

stats 'E_KS.out' using 1 nooutput name 'EKS_'
stats 'E_F.out' using 1 nooutput name 'EF_'
stats 'FmaxAtom.out' using 1 nooutput name 'FMAX_'
# set size square 1, 1
# set origin 0, 0
# set colorsequence classic 
set size 2.5, 1  
set autoscale                        # scale axes automatically
set xtic auto                          # set xtics automatically
set ytic auto                          # set ytics automatically
set xtics format "{/:Bold {/=14 %h}}"
set ytics format "{/:Bold {/=14 %h}}"
set y2tics format "{/:Bold {/=14 %h}}"
set border linewidth 3
set grid
set samples 21

set multiplot layout 1,2 title "{/:Bold Variables vs CG steps}" font ",16"

    myTitle = "`head -1 title.gnuplot`"
    set label myTitle tc "red" at screen 0.43, 0.95 font ",12" 
    myEnergyTitle = "`head -2 energyTitle.gnuplot`"
    set label myEnergyTitle tc rgb "black" at screen 0.425, 0.92 font ",14"
    set key at screen 0.35, screen 0.8 horizontal maxrows 1
    set lmargin 15
    set tmargin 6
    set bmargin 8
    set rmargin 20   
    set xlabel "{/:Bold CG steps}"
    set ylabel "{/:Bold E_{KS} (eV)}" offset 0,-0.5 tc "black"
    set title "{/:Bold Energies and forces}" font ",14"

    set yrange [EKS_min-0.1: EKS_max+0.1]
    set y2label "{/:Bold E_{F} (eV)}" offset -6,0.75 tc "orange"
    set y2range [EF_min-0.1: EF_max+0.1]
    set y2tics nomirror
    set grid xtics, ytics
    
    # data for first and second y-axes
    plot 'E_KS.out' w lp pt 7 ps 1 lw 2 lc "black" axes x1y1 title "E_{KS}",\
         'E_F.out' w lp pt 7 ps 1 lw 2 lc "orange" axes x1y2 title "E_{F}",\
         NaN w lp pt 7 ps 1 lw 2 lc "blue" axes x1y2 title "F_{max}"

    # data for third y-axis
    set size 0.5, 1   
    unset title
    unset tics
    unset xlabel
    unset ylabel
    unset y2label
    set multiplot previous
    set y2range[0: FMAX_max+0.01]
    plot 'FmaxAtom.out' w lp pt 7 ps 1 lw 2 lc "blue" axes x1y2 notitle

    # just to get 3rd y-axis
    set border 8
    set rmargin 7
    unset xtics
    set y2label "{/:Bold F_{max} (eV/Ang)})" offset -9,0 tc "blue"
    set y2tics
    set multiplot previous
    Ftol0 = "`head -1 Ftol.out`"
    Ftol=Ftol0+0.0
    plot Ftol w lines lc "blue" lw 3 dt "-" notitle axis x1y2
    reset
    set size 0.5, 1
    set origin 0.5, 0
    unset y2label
    unset y2tics
    unset xlabel
    unset ylabel 
    unset title

    set key at screen 0.875, screen 0.8 horizontal maxrows 1
    set lmargin 15
    set tmargin 8
    set bmargin 8
    set rmargin 20   
    set autoscale                        # scale axes automatically
    set xtic auto                          # set xtics automatically
    set ytic auto                          # set ytics automatically
    set xtics format "{/:Bold {/=14 %h}}"
    set ytics format "{/:Bold {/=14 %h}}"
    set border linewidth 3
    set grid

    set xlabel '{/:Bold CG steps}'
    set ylabel '{/:Bold S (kBar), P (kBar)}'
    set title "{/:Bold Stresses and pressure}" font ",14"

    plot 'S.out' using 0:1 w lp pt 7 ps 1 lw 2 lc "red" title "S_x", \
         'S.out' using 0:2 w lp pt 7 ps 1 lw 2 lc "green" title "S_y", \
         'S.out' using 0:3 w lp pt 7 ps 1 lw 2 lc "blue" title "S_z", \
         'P.out' w lp pt 7 ps 1 lw 2 lc "cyan" title "P", \
          0 w lines lw 4 lc "black" notitle         

unset multiplot
### end of code