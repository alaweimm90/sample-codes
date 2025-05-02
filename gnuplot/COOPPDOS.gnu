reset 

set terminal pngcairo size 1440,900 enhanced crop font 'Helvetica,10'
set output 'COOPPDOS.png'
set size square 0.75, 0.75
set colorsequence classic 
set termoption dash

# Set stylea
set autoscale                          # scale axes automatically
set xtic auto                          # set xtics automatically
set ytic auto                          # set ytics automatically
set grid
set border linewidth 3
set origin 0.1,0.5
set arrow from graph 0,0.9 to graph 0,1.07 filled
set arrow from graph 0.9,0 to graph 1.07,0 filled
set xzeroaxis lt 1 lc 7 lw 2
unset log                              # remove any log-scaling
unset label                            # remove any previous labels
myTitle1 = "`head -1 title1.txt`"
set label myTitle1 tc rgb "red" at screen 0.311, 0.91 font ",9" 
myTitle2 = "`head -1 title2.txt`"
set label myTitle2 tc rgb "red" at screen 0.32, 0.9 font ",9" 	

factor=5
stats 'bandsPositive.txt' using 1 prefix "k"
stats 'bandsPositive.txt' using 2 prefix "Epositive"
stats 'bandsNegative.txt' using 2 prefix "Enegative"
set arrow from 0,Epositive_min to factor,Epositive_min nohead ls 1 
set arrow from 0,Enegative_max to factor,Enegative_max nohead ls 1
set object rectangle from 0,Enegative_max to factor,Epositive_min fillcolor rgb 'red' fillstyle transparent solid 0.25 noborder 

# Plot
set size 0.5,0.45
set lmargin at screen 0.275
set title "{/:Bold Projected Density of States}" font ",18"  
set xrange [0:factor]
set yrange [-4.0:4.0]
set xlabel '{/:Bold DOS (1/eV)}'
set ylabel '{/:Bold E-E_F (eV)}'
set format y "%.2f"
plot 'C2-MoS2-PDOS.PDOS_shifted_total.pdos' every 6::0 u 3:1 w lines lc 7 lw 3 title "Total", \
     'C2-MoS2-PDOS.PDOS_Mo_shifted.pdos' every 6::0 u 2:1 w p lc 3 pt 6 ps 0.5 title "Mo", \
     'C2-MoS2-PDOS.PDOS_Mo_shifted.pdos' every 6::0 u 2:1 w p lc 7 pt 6 ps 0.6 notitle, \
     'C2-MoS2-PDOS.PDOS_S_shifted.pdos' every 6::0 u 2:1 w p lc 1 pt 6 ps 0.5 title  "S", \
     'C2-MoS2-PDOS.PDOS_S_shifted.pdos' every 6::0 u 2:1 w p lc 7 pt 6 ps 0.6 notitle, \
     'C2-MoS2-PDOS.PDOS_Mo_4d_shifted.pdos' every 6::0 u 2:1 w line lc 5 lw 2 dt 2 title "Mo (4d)", \
     'C2-MoS2-PDOS.PDOS_S_3p_shifted.pdos' every 6::0 u 2:1 w line lc 8 lw 2 dt 2 title "S (3p)"

unset xlabel
unset ylabel