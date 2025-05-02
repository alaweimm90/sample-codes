reset 

set terminal pngcairo size 1440,900 enhanced crop font 'Helvetica,10'
set output 'fatbands.png'
set colorsequence classic 
set termoption dash

ColorNames = "white black dark-grey red web-green web-blue dark-magenta dark-cyan dark-orange dark-yellow royalblue goldenrod dark-spring-green purple steelblue dark-red dark-chartreuse orchid aquamarine brown yellow turquoise grey0 grey10 grey20 grey30 grey40 grey50 grey60 grey70 grey grey80 grey90 grey100 light-red light-green light-blue light-magenta light-cyan light-goldenrod light-pink light-turquoise gold green dark-green spring-green forest-green sea-green blue dark-blue midnight-blue navy medium-blue skyblue cyan magenta dark-turquoise dark-pink coral light-coral orange-red salmon dark-salmon khaki dark-khaki dark-goldenrod beige olive orange violet dark-violet plum dark-plum dark-olivegreen orangered4 brown4 sienna4 orchid4 mediumpurple3 slateblue1 yellow4 sienna1 tan1 sandybrown light-salmon pink khaki1 lemonchiffon bisque honeydew slategrey seagreen antiquewhite chartreuse greenyellow gray light-gray light-grey dark-gray slategray gray0 gray10 gray20 gray30 gray40 gray50 gray60 gray70 gray80 gray90 gray100"

ColorValues = "0xffffff 0x000000 0xa0a0a0 0xff0000 0x00c000 0x0080ff 0xc000ff 0x00eeee 0xc04000 0xc8c800 0x4169e1 0xffc020 0x008040 0xc080ff 0x306080 0x8b0000 0x408000 0xff80ff 0x7fffd4 0xa52a2a 0xffff00 0x40e0d0 0x000000 0x1a1a1a 0x333333 0x4d4d4d 0x666666 0x7f7f7f 0x999999 0xb3b3b3 0xc0c0c0 0xcccccc 0xe5e5e5 0xffffff 0xf03232 0x90ee90 0xadd8e6 0xf055f0 0xe0ffff 0xeedd82 0xffb6c1 0xafeeee 0xffd700 0x00ff00 0x006400 0x00ff7f 0x228b22 0x2e8b57 0x0000ff 0x00008b 0x191970 0x000080 0x0000cd 0x87ceeb 0x00ffff 0xff00ff 0x00ced1 0xff1493 0xff7f50 0xf08080 0xff4500 0xfa8072 0xe9967a 0xf0e68c 0xbdb76b 0xb8860b 0xf5f5dc 0xa08020 0xffa500 0xee82ee 0x9400d3 0xdda0dd 0x905040 0x556b2f 0x801400 0x801414 0x804014 0x804080 0x8060c0 0x8060ff 0x808000 0xff8040 0xffa040 0xffa060 0xffa070 0xffc0c0 0xffff80 0xffffc0 0xcdb79e 0xf0fff0 0xa0b6cd 0xc1ffc1 0xcdc0b0 0x7cff40 0xa0ff20 0xbebebe 0xd3d3d3 0xd3d3d3 0xa0a0a0 0xa0b6cd 0x000000 0x1a1a1a 0x333333 0x4d4d4d 0x666666 0x7f7f7f 0x999999 0xb3b3b3 0xcccccc 0xe5e5e5 0xffffff"

myColor(c) = (idx=NaN, sum [i=1:words(ColorNames)] \
(c eq word(ColorNames,i) ? idx=i : idx), word(ColorValues,idx))

# add transparency (500) a=0 to 255 or 0x00 to 0xff
myTColor(c,a) = sprintf("0x%x%s",a, myColor(c)[3:])

# Set stylea
set autoscale                          # scale axes automatically
set xtic auto                          # set xtics automatically
set ytic auto                          # set ytics automatically
set grid
set border linewidth 3
# set arrow from graph 0,0.9 to graph 0,1.07 filled
# set arrow from graph 0.9,0 to graph 1.07,0 filled
set xzeroaxis lt 1 lc 7 lw 2
unset log                              # remove any log-scaling
unset label                            # remove any previous labels
# myTitle1 = "`head -1 title1.tmp`"
# set label myTitle1 tc rgb "red" at screen 0.311, 0.91 font ",9" 
# myTitle2 = "`head -1 title2.tmp`"
# set label myTitle2 tc rgb "red" at screen 0.32, 0.9 font ",9" 

gamma1Point = system("awk 'NR == 1 {print $1}' bandsPositive.txt")
MPoint = system("awk 'NR == (1+1*500) {print $1}' bandsPositive.txt")
KPoint = system("awk 'NR == (1+2*500) {print $1}' bandsPositive.txt")
gamma2Point = system("awk 'NR == (1+3*500) {print $1}' bandsPositive.txt")

set style line 100 lt 1 lc rgb "black" lw 1.5
set arrow from MPoint, graph 0 to MPoint, graph 1 nohead ls 100 dashtype 3
set arrow from KPoint, graph 0 to KPoint, graph 1 nohead ls 100 dashtype 3 

BohrToAng=1.889727

stats 'bandsPositive.txt' using 1 prefix "k"
stats 'bandsPositive.txt' using 2 prefix "Epositive"
stats 'bandsNegative.txt' using 2 prefix "Enegative"
set arrow from k_min,Epositive_min to k_max,Epositive_min nohead ls 1 
set arrow from k_min,Enegative_max to k_max,Enegative_max nohead ls 1
# set arrow from k_max/2,Enegative_max to k_max/2,Epositive_min heads
set object rectangle from k_min,Enegative_max to k_max,Epositive_min fillcolor rgb "red" fillstyle transparent solid 0.1 noborder 
# Eg=Epositive_min-Enegative_max


set xtics ("{/Symbol G}" gamma1Point, "M" MPoint, "K" KPoint, "{/Symbol G}" gamma2Point)

# set label sprintf("{/:Bold Eg = %3.4g eV}",Eg) offset 1,1.5

set size square 1,1

# Plot
set multiplot layout 2,3 columnsfirst scale 0.93,0.95

# PLOT 1
set origin 0,0.5
set key horizontal font "Helvetica, 10" at graph 0.825, graph 1.1
set xrange [0:k_max]
set yrange [-3.0:3.0]
set xlabel '{/:Bold k (1/Ang)}'
set ylabel '{/:Bold E-E_F (eV)}'
set format y "%.2f"

plot 'bands.txt' u 1:2 w p lc rgb "black" pt 7 ps 0.5 notitle
     
unset xlabel
unset ylabel
unset key


# PLOT 2
set origin 0.3,0.5
set key horizontal font "Helvetica, 10" at graph 0.68, graph 1.075
set xrange [0:k_max]
set yrange [-3.0:3.0]
set xlabel '{/:Bold k (1/Ang)}'
set ylabel '{/:Bold E-E_F (eV)}'
set format y "%.2f"

plot 'bands.txt' u 1:2 w p lc rgb "black" pt 7 ps 0.5 notitle, \
     'Mo-shifted-bands.txt' u ($1*BohrToAng):2:(2.5*$3) w p lc rgb myTColor("blue",0xcc) pt 7 ps variable title '{/:Bold Mo}', \
     'S-shifted-bands.txt' u ($1*BohrToAng):2:(2.5*$3) w p lc rgb myTColor("red",0xcc) pt 7 ps variable title '{/:Bold S}'

unset xlabel
unset ylabel
unset key

# PLOT 3
set origin 0.6,0.5
set key horizontal font "Helvetica, 10" at graph 0.85, graph 1.075
set xrange [0:k_max]
set yrange [-3.0:3.0]
set xlabel '{/:Bold k (1/Ang)}'
set ylabel '{/:Bold E-E_F (eV)}'
set format y "%.2f"

plot 'bands.txt' u 1:2 w p lc rgb "black" pt 7 ps 0.5 notitle, \
     'Mo_4d-shifted-bands.txt' u ($1*BohrToAng):2:(2.5*$3) w p lc rgb myTColor("dark-violet",0xcc) pt 7 ps variable title '{/:Bold Mo (4d)}', \
     'Mo_5s-shifted-bands.txt' u ($1*BohrToAng):2:(2.5*$3) w p lc rgb myTColor("green",0xcc) pt 7 ps variable title '{/:Bold Mo (5s)}'

unset xlabel
unset ylabel
unset key


# PLOT 4
set origin 0,0
set key horizontal font "Helvetica, 10" at graph 0.85, graph 1.075
set xrange [0:k_max]
set yrange [-3.0:3.0]
set xlabel '{/:Bold k (1/Ang)}'
set ylabel '{/:Bold E-E_F (eV)}'
set format y "%.2f"

plot 'bands.txt' u 1:2 w p lc rgb "black" pt 7 ps 0.5 notitle, \
     'S_3p-shifted-bands.txt' u ($1*BohrToAng):2:(2.5*$3) w p lc rgb myTColor("orange",0xcc) pt 7 ps variable title '{/:Bold Mo (4d)}', \
     'S_3s-shifted-bands.txt' u ($1*BohrToAng):2:(2.5*$3) w p lc rgb myTColor("green",0xcc) pt 7 ps variable title '{/:Bold Mo (5s)}'

unset xlabel
unset ylabel
unset key

# PLOT 5
set origin 0.3,0
set key horizontal font "Helvetica, 10" at graph 0.85, graph 1.075
set xrange [0:k_max]
set yrange [-3.0:3.0]
set xlabel '{/:Bold k (1/Ang)}'
set ylabel '{/:Bold E-E_F (eV)}'
set format y "%.2f"

plot 'bands.txt' u 1:2 w p lc rgb "black" pt 7 ps 0.5 notitle, \
     'Mo_4d-shifted-bands.txt' u ($1*BohrToAng):2:(2.5*$3) w p lc rgb myTColor("purple",0xcc) pt 7 ps variable title '{/:Bold Mo (4d)}', \
     'Mo_5s-shifted-bands.txt' u ($1*BohrToAng):2:(2.5*$3) w p lc rgb myTColor("green",0xcc) pt 7 ps variable title '{/:Bold Mo (5s)}'

unset xlabel
unset ylabel
unset key

# PLOT 6
set origin 0.6,0
set key horizontal font "Helvetica, 10" at graph 0.85, graph 1.075
set xrange [0:k_max]
set yrange [-3.0:3.0]
set xlabel '{/:Bold k (1/Ang)}'
set ylabel '{/:Bold E-E_F (eV)}'
set format y "%.2f"

plot 'bands.txt' u 1:2 w p lc rgb "black" pt 7 ps 0.5 notitle, \
     'Mo_4d-shifted-bands.txt' u ($1*BohrToAng):2:(2.5*$3) w p lc rgb myTColor("purple",0xcc) pt 7 ps variable title '{/:Bold Mo (4d)}', \
     'Mo_5s-shifted-bands.txt' u ($1*BohrToAng):2:(2.5*$3) w p lc rgb myTColor("green",0xcc) pt 7 ps variable title '{/:Bold Mo (5s)}'

unset xlabel
unset ylabel
unset key

unset multiplot          
reset 

set terminal pngcairo size 1440,900 enhanced crop font 'Helvetica,10'
set output 'fatbands.png'
set colorsequence classic 
set termoption dash

ColorNames = "white black dark-grey red web-green web-blue dark-magenta dark-cyan dark-orange dark-yellow royalblue goldenrod dark-spring-green purple steelblue dark-red dark-chartreuse orchid aquamarine brown yellow turquoise grey0 grey10 grey20 grey30 grey40 grey50 grey60 grey70 grey grey80 grey90 grey100 light-red light-green light-blue light-magenta light-cyan light-goldenrod light-pink light-turquoise gold green dark-green spring-green forest-green sea-green blue dark-blue midnight-blue navy medium-blue skyblue cyan magenta dark-turquoise dark-pink coral light-coral orange-red salmon dark-salmon khaki dark-khaki dark-goldenrod beige olive orange violet dark-violet plum dark-plum dark-olivegreen orangered4 brown4 sienna4 orchid4 mediumpurple3 slateblue1 yellow4 sienna1 tan1 sandybrown light-salmon pink khaki1 lemonchiffon bisque honeydew slategrey seagreen antiquewhite chartreuse greenyellow gray light-gray light-grey dark-gray slategray gray0 gray10 gray20 gray30 gray40 gray50 gray60 gray70 gray80 gray90 gray100"

ColorValues = "0xffffff 0x000000 0xa0a0a0 0xff0000 0x00c000 0x0080ff 0xc000ff 0x00eeee 0xc04000 0xc8c800 0x4169e1 0xffc020 0x008040 0xc080ff 0x306080 0x8b0000 0x408000 0xff80ff 0x7fffd4 0xa52a2a 0xffff00 0x40e0d0 0x000000 0x1a1a1a 0x333333 0x4d4d4d 0x666666 0x7f7f7f 0x999999 0xb3b3b3 0xc0c0c0 0xcccccc 0xe5e5e5 0xffffff 0xf03232 0x90ee90 0xadd8e6 0xf055f0 0xe0ffff 0xeedd82 0xffb6c1 0xafeeee 0xffd700 0x00ff00 0x006400 0x00ff7f 0x228b22 0x2e8b57 0x0000ff 0x00008b 0x191970 0x000080 0x0000cd 0x87ceeb 0x00ffff 0xff00ff 0x00ced1 0xff1493 0xff7f50 0xf08080 0xff4500 0xfa8072 0xe9967a 0xf0e68c 0xbdb76b 0xb8860b 0xf5f5dc 0xa08020 0xffa500 0xee82ee 0x9400d3 0xdda0dd 0x905040 0x556b2f 0x801400 0x801414 0x804014 0x804080 0x8060c0 0x8060ff 0x808000 0xff8040 0xffa040 0xffa060 0xffa070 0xffc0c0 0xffff80 0xffffc0 0xcdb79e 0xf0fff0 0xa0b6cd 0xc1ffc1 0xcdc0b0 0x7cff40 0xa0ff20 0xbebebe 0xd3d3d3 0xd3d3d3 0xa0a0a0 0xa0b6cd 0x000000 0x1a1a1a 0x333333 0x4d4d4d 0x666666 0x7f7f7f 0x999999 0xb3b3b3 0xcccccc 0xe5e5e5 0xffffff"

myColor(c) = (idx=NaN, sum [i=1:words(ColorNames)] \
(c eq word(ColorNames,i) ? idx=i : idx), word(ColorValues,idx))

# add transparency (500) a=0 to 255 or 0x00 to 0xff
myTColor(c,a) = sprintf("0x%x%s",a, myColor(c)[3:])

# Set stylea
set autoscale                          # scale axes automatically
set xtic auto                          # set xtics automatically
set ytic auto                          # set ytics automatically
set grid
set border linewidth 3
# set arrow from graph 0,0.9 to graph 0,1.07 filled
# set arrow from graph 0.9,0 to graph 1.07,0 filled
set xzeroaxis lt 1 lc 7 lw 2
unset log                              # remove any log-scaling
unset label                            # remove any previous labels
# myTitle1 = "`head -1 title1.tmp`"
# set label myTitle1 tc rgb "red" at screen 0.311, 0.91 font ",9" 
# myTitle2 = "`head -1 title2.tmp`"
# set label myTitle2 tc rgb "red" at screen 0.32, 0.9 font ",9" 


gamma1Point = system("awk 'NR == 1 {print $1}' bandsPositive.txt")
MPoint = system("awk 'NR == (1+1*500) {print $1}' bandsPositive.txt")
KPoint = system("awk 'NR == (1+2*500) {print $1}' bandsPositive.txt")
gamma2Point = system("awk 'NR == (1+3*500) {print $1}' bandsPositive.txt")

set style line 100 lt 1 lc rgb "black" lw 1.5
set arrow from MPoint, graph 0 to MPoint, graph 1 nohead ls 100 dashtype 3
set arrow from KPoint, graph 0 to KPoint, graph 1 nohead ls 100 dashtype 3 

stats 'bandsPositive.txt' using 1 prefix "k"
stats 'bandsPositive.txt' using 2 prefix "Epositive"
stats 'bandsNegative.txt' using 2 prefix "Enegative"
set arrow from k_min,Epositive_min to k_max,Epositive_min nohead ls 1 
set arrow from k_min,Enegative_max to k_max,Enegative_max nohead ls 1
# set arrow from k_max/2,Enegative_max to k_max/2,Epositive_min heads
set object rectangle from k_min,Enegative_max to k_max,Epositive_min fillcolor rgb "red" fillstyle transparent solid 0.1 noborder 
# Eg=Epositive_min-Enegative_max


set xtics ("{/Symbol G}" gamma1Point, "M" MPoint, "K" KPoint, "{/Symbol G}" gamma2Point)

# set label sprintf("{/:Bold Eg = %3.4g eV}",Eg) offset 1,1.5

set size square 1,1

# Plot
set multiplot layout 2,3 columnsfirst scale 0.93,0.93

# PLOT 1
set origin 0,0.5
set key horizontal font "Helvetica, 10" at graph 0.825, graph 1.1
set xrange [0:k_max]
set yrange [-3.0:3.0]
set xlabel '{/:Bold k (1/Ang)}'
set ylabel '{/:Bold E-E_F (eV)}'
set format y "%.2f"

plot 'bands.txt' u 1:2 w p lc rgb "black" pt 7 ps 1 notitle
     
unset xlabel
unset ylabel
unset key


# PLOT 2
set origin 0.3,0.5
set key horizontal font "Helvetica, 10" at graph 0.68, graph 1.075
set xrange [0:k_max]
set yrange [-3.0:3.0]
set xlabel '{/:Bold k (1/Ang)}'
set ylabel '{/:Bold E-E_F (eV)}'
set format y "%.2f"

plot 'bands.txt' u 1:2 w p lc rgb "black" pt 7 ps 0.25 notitle, \
     'Mo-shifted-bands.txt' u ($1*BohrToAng):2:(2.5*$3) w p lc rgb myTColor("blue",175) pt 7 ps variable title '{/:Bold Mo}', \
     'S-shifted-bands.txt' u ($1*BohrToAng):2:(2.5*$3) w p lc rgb myTColor("red",175) pt 7 ps variable title '{/:Bold S}'

unset xlabel
unset ylabel
unset key

# PLOT 3
set origin 0.6,0.5
set key horizontal font "Helvetica, 10" at graph 0.85, graph 1.075
set xrange [0:k_max]
set yrange [-3.0:3.0]
set xlabel '{/:Bold k (1/Ang)}'
set ylabel '{/:Bold E-E_F (eV)}'
set format y "%.2f"

plot 'bands.txt' u 1:2 w p lc rgb "black" pt 7 ps 0.25 notitle, \
     'Mo_4d-shifted-bands.txt' u ($1*BohrToAng):2:(2.5*$3) w p lc rgb myTColor("blue",175) pt 7 ps variable title '{/:Bold Mo (4d)}', \
     'Mo_5s-shifted-bands.txt' u ($1*BohrToAng):2:(2.5*$3) w p lc rgb myTColor("cyan",175) pt 7 ps variable title '{/:Bold Mo (5s)}'

unset xlabel
unset ylabel
unset key


# PLOT 4
set origin 0,0
set key horizontal font "Helvetica, 10" at graph 0.85, graph 1.075
set xrange [0:k_max]
set yrange [-3.0:3.0]
set xlabel '{/:Bold k (1/Ang)}'
set ylabel '{/:Bold E-E_F (eV)}'
set format y "%.2f"

plot 'bands.txt' u 1:2 w p lc rgb "black" pt 7 ps 0.25 notitle, \
     'S_3p-shifted-bands.txt' u ($1*BohrToAng):2:(2.5*$3) w p lc rgb myTColor("red",175) pt 7 ps variable title '{/:Bold S (3p)}', \
     'S_3s-shifted-bands.txt' u ($1*BohrToAng):2:(2.5*$3) w p lc rgb myTColor("orange",175) pt 7 ps variable title '{/:Bold S (3s)}'

unset xlabel
unset ylabel
unset key

# PLOT 5
set origin 0.3,0
set key horizontal font "Helvetica, 10" at graph 1.1, graph 1.12
set xrange [0:k_max]
set yrange [-3.0:3.0]
set xlabel '{/:Bold k (1/Ang)}'
set ylabel '{/:Bold E-E_F (eV)}'
set format y "%.2f"

plot 'bands.txt' u 1:2 w p lc rgb "black" pt 7 ps 0.25 notitle, \
     'Mo_4dxy-shifted-bands.txt' u ($1*BohrToAng):2:(2.5*$3) w p lc rgb myTColor("green",175) pt 7 ps variable title '{/:Bold Mo (4d_{xy})}', \
     'Mo_4dz2-shifted-bands.txt' u ($1*BohrToAng):2:(2.5*$3) w p lc rgb myTColor("blue",175) pt 7 ps variable title '{/:Bold Mo (4d_{z^2})}', \
     'Mo_4dyz-shifted-bands.txt' u ($1*BohrToAng):2:(2.5*$3) w p lc rgb myTColor("dark-violet",175) pt 7 ps variable title '{/:Bold Mo (4d_{yz})}', \
     'Mo_4dx2-y2-shifted-bands.txt' u ($1*BohrToAng):2:(2.5*$3) w p lc rgb myTColor("cyan",175) pt 7 ps variable title '{/:Bold Mo (4d_{x^2-y^2})}', \
     'Mo_4dxz-shifted-bands.txt' u ($1*BohrToAng):2:(2.5*$3) w p lc rgb myTColor("gold",175) pt 7 ps variable title '{/:Bold Mo (4d_{xz})}'
 
unset xlabel
unset ylabel
unset key

# PLOT 6
set origin 0.6,0
set key horizontal font "Helvetica, 10" at graph 0.85, graph 1.075
set xrange [0:k_max]
set yrange [-3.0:3.0]
set xlabel '{/:Bold k (1/Ang)}'
set ylabel '{/:Bold E-E_F (eV)}'
set format y "%.2f"

plot 'bands.txt' u 1:2 w p lc rgb "black" pt 7 ps 0.25 notitle, \
     'S_3px-shifted-bands.txt' u ($1*BohrToAng):2:(2.5*$3) w p lc rgb myTColor("orange",175) pt 7 ps variable title '{/:Bold S (3p_x)}', \
     'S_3py-shifted-bands.txt' u ($1*BohrToAng):2:(2.5*$3) w p lc rgb myTColor("dark-pink",175) pt 7 ps variable title '{/:Bold S (3p_y)}', \
     'S_3pz-shifted-bands.txt' u ($1*BohrToAng):2:(2.5*$3) w p lc rgb myTColor("red",175) pt 7 ps variable title '{/:Bold S (3p_z)}'     

unset xlabel
unset ylabel
unset key

unset multiplot          
