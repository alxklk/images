#macro p(T)
x*(T+sin(T*25)*0.3)+y*sin(T*10)+z*cos(T*10)
#end

#macro wire(l,r,s1,s2)
#local rs=seed(1234125);
#declare i=0;
#while(i<l)
sphere{p(i),r}
#declare i=i+s1;
#end

#declare i=0;
#while(i<l)
sphere{0,r scale <14,1,1> rotate <0,160*rand(rs),60*rand(rs)> translate p(i)}
sphere{0,r scale <14,1,1> rotate <0,-60*rand(rs),160*rand(rs)> translate p(i)}
sphere{0,r scale <14,1,1> rotate <0,120*rand(rs),-60*rand(rs)> translate p(i)}
sphere{0,r scale <14,1,1> rotate <0,-60*rand(rs),-120*rand(rs)> translate p(i)}
#declare i=i+s2;
#end

#end