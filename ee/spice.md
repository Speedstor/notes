# Spice Cheatsheet

```spice
# Capacitors
c[name] [node1] [node2] [value] ic=[initial voltage]
c1 12 33 10u ic=3.5

# Inductors
l[name] [node1] [node2] [value] ic=[initial current]
l1 12 33 133m ic=12.5m

# inductor Coupling (transformers)
k[name] l[name] l[name] [coupling factor]
k1 l1 l2 0.999

# Resistors
r[name] [node1] [node2] [value]
rload 23 15 3.3k

# Diodes
d[name] [anode] [cathode] [model]
d1 1 2 mod1
# Define Diode models
.model [modelname] d [parmtr1=x] [marmtr2=x]
.model mod1 d vj=0.65 rs=1.3

# Transistors
q[name] [collector [base] [emitter] [model]
q1 2 3 0 mod1
# BJT transistor models
.model [modelname] [npn or pnp] [parmtr1=x]
.model mod1 pnp bf=75 is=1e-12

# JFET, junction field-effect transistor
j[name] [drain] [gate] [source] [model]
j1 2 3 0 mod1
# JFET transistor models
.model [modelname] [njf or pjf] [parmtr1=x]
.model mod1 pjf lambda=1e-5 pb=0.75

# MOSFET, transistor
m[name] [drain] [gate] [source] [substrate] [model]
m1 2 3 0 0 mod1
# MOSFET transistor models
.model [modelname] [nmos or pmos] [parmtr1=x]
.model mod1 nmos level=2 phi=0.65 rd=1.5 vto=-1
```

###$ Sources
```spice
# AC Sinewave voltage source (when using .ac card to specify frequency)
v[name] [+node] [-node] ac [voltage [phase] sin
v1 1 0 ac 12 240 sin
# different frequencies
v[name] [+node] [-node] sin([offset] [voltage] + [freq] [delay] [damping factor])
v1 1 0 sin( 0 12 60 0 0)

# DC sources (w/ .dc card)
v[name] [+node] [-node] dc
v1 1 0 dc
# w/out .dc
v[name] [+node] [-node] dc [voltage]
v1 1 0 dc 12
# pulse voltage sources
v[name] [+node] [-node] pulse ([i] [p] [td] [tr] + [tf] [pw] [pd])
v1 1 0 pulse (-3 3 0 0 0 10m 20m)

```

#### Common Electrical Components
```spice
# 2N2222 transistor
.model m2n2222 npn is=19f bf=150 vaf=100 ikf=.18 +
ise=50p ne=2.5 br=7.5  var=6.4 ikr=12m +
isc=8.7p nc=1.2 rb=50 re=0.4 rc=0.4 cje=26p +
tc=0.5n cjc=11p tr=7n xtb=1.5 kf=0.032f af=1

# SN2907
.model m2n2907 pnp is=1.1p bf=200 nf=1.2 vaf=50 +
ikf=0.1 ise=13p ne=1.9 br=6 rc=0.6 cje=23p + 
vje=0.85 mje=1.25 tf=0.5n cjc=19p vjc=0.5 + 
mjc=0.2 tr=34n xtb=1.5 
```
