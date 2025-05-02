reset 
set terminal pngcairo size 1440,900 enhanced crop font 'Helvetica,10'

set size square 1, 1
set colorsequence classic 
set termoption dash

stats 'x-y-z-type-number-Eg.txt' using 1 prefix "xvalue"
stats 'x-y-z-type-number-Eg.txt' using 2 prefix "yvalue"
stats 'x-y-z-type-number-Eg.txt' using 3 prefix "zvalue"
stats 'x-y-z-type-number-Eg.txt' using 6 prefix "Egvalue"

xmin=xvalue_min
xmax=xvalue_max
ymin=yvalue_min
ymax=yvalue_max
zmin=zvalue_min
zmax=zvalue_max
Egmin=Egvalue_min
Egmax=Egvalue_max


# Set stylea
set autoscale                          # scale axes automatically
set xtic auto                          # set xtics automatically
set ytic auto                          # set ytics automatically
set grid
set border linewidth 3
set origin 0.0,0.0
set xrange [0:ymax]
set yrange [0:zmax]
set arrow from graph 0,0.9 to graph 0,1.07 filled
set arrow from graph 0.9,0 to graph 1.07,0 filled
set xzeroaxis lt 1 lc 7 lw 2



set output 'final-structure.png'
set title "{/:Bold Final structure}" font ",18"  
set xlabel '{/: y (Ang)}'
set ylabel '{/: z (Ang)}'
set format y "%.2f"


plot 'x-y-z-type-number-Eg-Mo.txt' u 2:($3-zmin) axis x1y1 w p ls 2 lt 3 pt 7 ps 2 notitle,\
	 'x-y-z-type-number-Eg-S.txt' u 2:($3-zmin) axis x1y1 w p ls 1 lt 8 pt 7 ps 1 notitle





unset output

# Set stylea
set autoscale                          # scale axes automatically
set xtic auto                          # set xtics automatically
set ytic auto                          # set ytics automatically
set grid
set border linewidth 3
set origin 0.0,0.0
set xrange [0:ymax]
set yrange [0:Egmax]
set arrow from graph 0,0.9 to graph 0,1.07 filled
set arrow from graph 0.9,0 to graph 1.07,0 filled
set xzeroaxis lt 1 lc 7 lw 2

set style circle radius graph 0.01 wedge
set style fill solid 1.0 border lc "black"

set output 'Eg-vs-y.png'
set title "{/:Bold Bandgap vs y}" font ",18"  
set xlabel '{/: y (Ang)}'
set ylabel '{/: Eg (eV)}'
set format y "%.2f"

plot 'x-y-z-type-number-Eg-Mo.txt' u 2:6 axis x1y1 w circles fc "blue" notitle,\
	 'y-sorted-Mo-Eg-distance.txt' u 2:6 axis x1y1 w lines lc rgb "blue" notitle,\
	 'x-y-z-type-number-Eg-S.txt' u 2:6 axis x1y1 w circles fc "red" notitle,\
	 'y-sorted-S-Eg-distance.txt' u 2:6 axis x1y1 w lines lc rgb "red" notitle

unset output

# Set stylea
set autoscale                          # scale axes automatically
set xtic auto                          # set xtics automatically
set ytic auto                          # set ytics automatically
set grid
set border linewidth 3
set origin 0.0,0.0
set xrange [0:xmax]
set yrange [0:Egmax]
set arrow from graph 0,0.9 to graph 0,1.07 filled
set arrow from graph 0.9,0 to graph 1.07,0 filled
set xzeroaxis lt 1 lc 7 lw 2

set style circle radius graph 0.01 wedge
set style fill solid 1.0 border lc "black"

set output 'Eg-vs-x.png'
set title "{/:Bold Bandgap vs x}" font ",18"  
set xlabel '{/: x (Ang)}'
set ylabel '{/: Eg (eV)}'
set format y "%.2f"

plot 'x-y-z-type-number-Eg-Mo.txt' u 1:6 axis x1y1 w circles fc "blue" notitle,\
	 'x-sorted-Mo-Eg-distance.txt' u 1:6 axis x1y1 w lines lc rgb "blue" notitle,\
	 'x-y-z-type-number-Eg-S.txt' u 1:6 axis x1y1 w circles fc "red" notitle,\
	 'x-sorted-S-Eg-distance.txt' u 1:6 axis x1y1 w lines lc rgb "red" notitle	 



unset output
# Set stylea
set autoscale                          # scale axes automatically
set xtic auto                          # set xtics automatically
set ytic auto                          # set ytics automatically
set grid
set border linewidth 3
set origin 0.0,0.0
set xrange [0:zmax]
set yrange [0:Egmax]
set arrow from graph 0,0.9 to graph 0,1.07 filled
set arrow from graph 0.9,0 to graph 1.07,0 filled
set xzeroaxis lt 1 lc 7 lw 2

set style circle radius graph 0.01 wedge
set style fill solid 1.0 border lc "black"


set output 'Eg-vs-z.png'
set title "{/:Bold Bandgap vs z}" font ",18"  
set xlabel '{/: z (Ang)}'
set ylabel '{/: Eg (eV)}'
set format y "%.2f"

plot 'x-y-z-type-number-Eg-Mo.txt' u 1:6 axis x1y1 w circles fc "blue" notitle,\
	 'z-sorted-Mo-Eg-distance.txt' u 1:6 axis x1y1 w lines lc rgb "blue" notitle,\
	 'x-y-z-type-number-Eg-S.txt' u 1:6 axis x1y1 w circles fc "red" notitle,\
	 'z-sorted-S-Eg-distance.txt' u 1:6 axis x1y1 w lines lc rgb "red" notitle	 	 
