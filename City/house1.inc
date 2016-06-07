#declare house=
union{

union{

#declare i=0;
#while(i<20)
    box{-1,1 
        scale <0.2,0.0015,0.2>
        translate -i*y*0.05
    }
    #declare i=i+1;
#end 

box{-1,1 scale <0.01,0.01,0.2> translate x*0.19+y*0.01}
box{-1,1 scale <0.01,0.01,0.2> translate x*0.19+y*0.01 rotate y*90}
box{-1,1 scale <0.01,0.01,0.2> translate x*0.19+y*0.01 rotate y*180}
box{-1,1 scale <0.01,0.01,0.2> translate x*0.19+y*0.01 rotate y*270}

box{-1,1 scale <0.01,1,0.01> translate -x*0.19-z*0.19-y}
box{-1,1 scale <0.01,1,0.01> translate -x*0.19+z*0.19-y}
box{-1,1 scale <0.01,1,0.01> translate +x*0.19-z*0.19-y}
box{-1,1 scale <0.01,1,0.01> translate +x*0.19+z*0.19-y}

#declare i=-1;
#while(i<=1.001)
    box{-1,1 scale <0.0015,1,0.0015> translate -x*0.199-z*0.18*i-y}
    box{-1,1 scale <0.0015,1,0.0015> translate -x*0.18*i-z*0.199-y}
    #declare i=i+1/4;
#end 

box{-1,1 scale <0.22,0.2,0.22> translate -y*1.11}

texture{desert pigment{color rgb 0.9}}
/*     
texture{terracotta
 pigment{color rgb <1,0.95,0.9>}
 normal{granite -.1 scale 0.1}
 }*/
}

box{-1,1 scale <0.195,1,0.195> translate -y texture{st pigment{color rgb 0.5}}}
translate y
}
