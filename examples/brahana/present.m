BrahanaList := function (p)

Labels := ["#0","#1","#2","#3","#4","#5","#6","#7","#8","#9","#9'",
"#10","#11","#12","#13","#14","#15","#16","#17","#18","#19", 
"#20","#20'","#20\"","#21","#21'",
"#22","#23","#24","#25","#26","#27","#28","#29",
"#30","#31","#32","#33","#34","#35","#36","#37","#38","#39", 
"#40","#41","#42","#43","#44","#45","#46","#47","#48","#49", 
"#50","#51","#52","#53","#54", "#55"];

V := [
// #0 Brahana p.660
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,1,0,0,0,0,0,0,0],
[0,0,0,1,0,0,0,0,0,0]
],
// #1 p.661
[
[1,0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,1,0,0],
[0,0,1,0,0,0,0,0,0,0],
[0,0,0,0,1,0,0,0,0,0]
],
// #2
[
[1,0,0,0,0,0,0,1,0,0],
[0,1,0,0,0,R(p),0,0,0,0],
[0,0,1,0,0,0,0,0,0,0],
[0,0,0,0,1,0,0,0,0,0]
],
// #3
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,1,0,0,0,0],
[0,0,0,0,0,0,0,1,0,0],
[0,0,1,0,0,0,0,0,0,0]
],
// #4
[
[0,0,0,0,1,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,1],
[0,0,0,0,0,1,0,0,1,0],
[1,1,0,0,0,0,0,0,0,0]
],
// #5
[
[1,0,0,0,0,0,0,1,0,0],
[0,1,0,0,0,0,1,0,0,0],
[0,0,1,0,0,0,0,0,0,0],
[0,1,0,0,1,1,0,1,0,0]
],
// #6
[
[0,0,0,0,1,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,1],
[0,0,0,0,0,1,0,0,1,0],
[1,0,0,0,0,0,0,1,0,0]
],
// #7 p.665
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,1,0,0,0,0,0,0,0],
[0,0,0,0,1,0,0,0,0,0]
],
// #8
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,1,0,0,0,0,0,0,0],
[0,0,0,0,0,0,1,0,0,0]
],
// #9
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,1,0,0,0,0,0,0,0],
[0,0,0,0,1,0,0,0,0,1]
],
// #9'
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,1,0,0,0,0,0,0,0],
[0,0,0,1,1,0,0,0,0,0]
],
// #10
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,0,0,1,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,1]
],
// #11
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,0,0,1,0,0,0,0,0],
[0,0,0,0,0,1,0,0,1,0]
],
// #12 p. 667
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,0,0,0,1,0,0,0,0],
[0,0,0,0,0,0,0,0,0,1]
],
// #13
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,0,0,0,1,0,0,0,0],
[0,0,0,1,0,0,1,0,0,0]
],
// #14
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,0,0,0,1,0,0,0,0],
[0,0,0,0,0,0,0,0,1,1]
],
// #15
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,0,0,0,1,0,0,0,0],
[0,0,0,1,0,0,0,1,0,0]
],
// #16
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,0,0,0,1,0,0,0,0],
[0,0,0,1,0,0,1,1,0,0]
],
// #17
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,0,0,0,1,0,0,0,0],
[0,0,0,0,1,0,0,0,0,1]
],
// #18
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,0,0,0,1,0,0,0,0],
[0,0,0,1,1,0,0,0,0,0]
],
// #19 p. 670 - slightly different order for vectors for this batch
[
[1,0,0,0,0,0,0,0,0,0],
[0,0,0,1,0,0,0,0,1,0],
[0,0,0,0,0,0,1,0,0,1],
[0,0,0,0,0,0,0,1,0,0]
],
// #20
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,0,0,0,1,0,0,1,0],
[0,0,0,0,0,0,0,0,0,1]
],
// #20'
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,0,1,1,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0,1]
],
// #20" 
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,0,1,1,1,0,0,0,0],
[0,0,0,0,0,0,0,0,0,1]
],
// #21
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,1,0,0,0,1,0,0,0],
[0,0,0,1,0,R(p),0,0,0,0]
],
// #21'
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,1,0,1,0,0,0,0,0],
[0,0,0,1,0,1,0,0,0,0]
],
// #22
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,0,0,0,1,0,0,R(p),0],
[0,0,0,0,0,0,1,1,0,0]
],
// #23
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,1,0,1,0,0,0,0,0],
[0,0,0,0,0,0,1,1,0,0]
],
// #24
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,0,0,1,0,0,0,0,-R(p)],
[0,0,0,0,0,0,1,1,0,0]
],
// #25
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,1,0,0,0,0,0,1,0],
[0,0,0,0,1,0,0,0,0,1]
],
// #26
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,1,0,0,0,0,0,1,0],
[0,0,0,0,0,0,1,1,0,0]
],
// #27
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0,0],
[0,0,1,0,0,0,1,0,0,0],
[0,0,0,1,0,0,0,1,0,0]
] ,
// #28 p. 680
[
[1,1,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,1,0,0,0],
[0,0,0,0,0,0,0,1,0,0],
[1,0,0,0,0,1,0,0,1,0]
],
// #29
[
[1,1,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,1,0,0,0],
[0,0,0,0,0,0,0,1,0,0],
[0,0,1,-1,-1,0,0,0,0,1]
],
// #30
[
[1,1,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,1,0,0,0],
[0,0,0,0,0,0,0,1,0,0],
[0,0,1,-1,0,0,0,0,0,1]
],
// #31
[
[1,1,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,1,0,0,0],
[0,0,0,0,0,0,0,1,0,0],
[0,0,1,1,0,0,0,1,1,1]
],
// #32
[
[1,1,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,1,0,0,0],
[0,0,0,0,0,0,0,1,0,0],
[0,0,1,-1,-R(p),0,0,0,0,1]
],
// #33
[
[1,1,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,1,0,0,0],
[0,0,0,0,0,0,0,1,0,0],
[0,0,0,1,1,0,0,0,0,1]
],
// #34
[
[1,1,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,1,0,0,0],
[0,0,0,0,0,0,0,1,0,0],
[0,0,0,1,0,1,0,0,0,0]
],
// #35
[
[1,1,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,1,0,0,0],
[0,0,0,0,0,0,0,1,0,0],
[0,0,1,1,1,1,0,0,0,1]
],
// #36  p. 684
[
[1,0,0,0,0,0,0,1,0,0],
[0,1,0,0,0,0,1,0,0,0],
[0,0,0,0,0,1,0,S(p),1,0],
[1,0,1,0,0,0,0,0,0,0]
],
// #37
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,1,0,0,0],
[0,0,0,0,0,0,0,1,0,0],
[0,0,0,R(p),1,0,0,0,0,1]
],
// #38
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,1,0,0,0],
[0,0,0,0,0,0,0,1,0,0],
[0,0,0,0,1,0,0,0,0,1]
],
// #39 
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,1,0,0,0],
[0,0,0,0,0,0,0,1,0,0],
[0,0,0,1,R(p),0,0,0,0,0] 
],
// #40
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,1,0,0,0],
[0,0,0,0,0,0,0,1,0,0],
[0,0,0,1,0,1,0,0,1,0]
],
// #41
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,1,0,0,0],
[0,0,0,0,0,0,0,1,0,0],
[0,0,1,1,-1,0,0,0,0,0]
],
// #42
[
[1,0,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,1,0,0,0],
[0,0,0,0,0,0,0,1,0,0],
[0,0,1,1,-R(p),0,0,0,0,0]
],
[ 
// #43 p. 690
  [1,0,0,0,0,0,0,1,0,0],
  [0,1,0,0,0,0,1,0,0,0],
  [0,0,0,0,0,1,0,S(p),1,0],
  [0,0,0,0,1,0,0,0,0,0]
],

[ 
// #44
  [1,0,0,0,0,0,0,1,0,0],
  [0,1,0,0,0,0,1,0,0,0],
  [0,0,0,0,1,0,0,0,0,0],
  [0,0,0,1,0,1,0,0,0,0]
],

[ 
// #45
  [1,0,0,0,0,0,0,1,0,0],
  [0,1,0,0,0,0,1,0,0,0],
  [0,0,0,0,0,1,0,0,0,0],
  [0,0,1,0,-R(p),0,0,0,0,0]
],

[ 
// #46
  [1,0,0,0,0,0,0,1,0,0],
  [0,1,0,0,0,0,1,0,0,0],
  [0,0,0,0,0,1,0,0,0,0],
  [0,0,0,R(p),1,0,0,0,0,0]
],

[ 
// #47
  [1,0,0,0,0,0,0,1,0,0],
  [0,1,0,0,0,0,1,0,0,0],
  [0,0,0,0,0,1,0,0,0,0],
  [0,0,1,0,0,0,0,0,1,0]
],

[ 
// #48 
  [1,0,0,0,0,0,0,1,0,0],
  [0,1,0,0,0,0,1,0,0,0],
  [0,0,1,0,0,0,0,0,0,0],
  [1,0,0,0,0,T(p),0,0,1,0]
],

[ 
// #49
  [1,0,0,0,0,0,0,1,0,0],
  [0,1,0,0,0,0,1,0,0,0],
  [0,0,0,0,0,1,-R(p),0,0,0],
  [0,0,1,0,0,0,0,0,1,0]
],

[ 
// #50
  [1,0,0,0,0,0,0,1,0,0],
  [0,1,0,0,0,0,1,0,0,0],
  [0,0,0,0,0,1,-R(p),0,0,0],
  [0,0,0,R(p),1,0,0,0,0,0]
],

[ 
// #51
  [1,0,0,0,0,0,0,1,0,0],
  [0,1,0,0,0,0,1,0,0,0],
  [0,0,0,0,0,0,0,0,0,1],
  [0,0,1,-R(p),1,0,0,0,0,0]
],

[ 
// #52 
  [1,0,0,0,0,0,0,1,0,0],
  [0,1,0,0,0,0,1,0,0,0],
  [0,0,0,0,0,0,0,0,0,1],
  [0,0,1,R(p),1,U(p),0,0,0,0]
],

[ 
// #53 p. 697
  [1,0,0,0,0,0,0,1,0,0],
  [0,1,0,0,0,0,1,0,0,0],
  [0,0,1,0,-R(p),0,0,0,0,0],
  [0,0,0,0,0,1,0,S(p),1,0]
],

[ 
// #54 
  [1,0,0,0,0,0,0,1,0,0],
  [0,1,0,0,0,0,1,0,0,0],
  [0,0,0,0,1,0,0,0,0,1],
  [0,0,0,1,-W(p),1,0,0,0,0]
],
// #55 new rep 
[
[1,0,0,0,0,0,0,1,0,0],
[0,0,0,0,0,0,1,0,0,0],
[0,0,0,0,0,0,0,0,1,0],
[0,1,0,1,0,R(p),0,0,0,0]
]      
];

P := [Presentation(p, V[i]): i in [1..#V]];
return P, V;

end function;
