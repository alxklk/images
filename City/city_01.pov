// Alex Kluchikov, 2004
// mailto: klkspa[at]ukr.net, aklk[at]mail.ru
// Feel free to modify/use in any form

#version 3.7

#include "functions.inc"
#include "desert_tex.inc"

global_settings
{
assumed_gamma 2.2
noise_generator 3
//max_intersections 18
//max_trace_level 18
}

sphere{0,1000 
 texture{
  pigment{
   gradient y color_map{ 
    [0,color rgb <0.8,0.83,1>]
    [1,color rgb <0.4,0.7,1>]
    }scale 2 translate -y}finish{ambient .4 diffuse .8}scale 1000}

texture{
 pigment{average pigment_map{
 #declare gr=.75;
 #declare ge=3/(1+gr+gr);
 #declare t1=.2;
 #declare t2=.9;
 #declare tr1=-.2;
 #declare tr2=.2;
  [1,bozo translate 1*y color_map{
   [t1,color rgbt < 1,gr,gr,tr1>*ge]
   [t2,color rgbt < 0, 0, 0,tr2>*ge]
  }]
  [1,bozo translate 1*z color_map{
   [t1,color rgbt < gr, 1,gr,tr1>*ge/.85]
   [t2,color rgbt <  0, 0, 0,tr2>*ge]
  }]
  [1,bozo translate 1*x color_map{
   [t1,color rgbt < gr,gr, 1,tr1>*ge/.7]
   [t2,color rgbt <  0, 0, 0,tr2>*ge]
  }]
   
 }}scale 0.25 finish{ambient .4 diffuse .8}scale 2500}

 no_shadow
 no_image 
 //no_reflection
 hollow double_illuminate scale 100}

#declare st=texture{pigment{color rgb<0.83,0.82,0.84>*1.2}
  finish{diffuse 0.85 ambient 0 specular 0.8 roughness 0.03 phong 1.0 brilliance 7.3 phong_size 80  metallic .5 
   reflection{0.6,1.0 metallic}}
  }

#declare pla=texture{
   pigment{color rgb 1}
   finish{diffuse 1. phong 1. phong_size 80 
    reflection{.1,.3}
   }
   //normal{bozo .3 scale .01}
  }

#declare sten=texture{
 finish{diffuse .9 phong 1.8 phong_size 80 reflection{.1,.3}}
 pigment{
  slope y color_map{
   [0,color rgb <.8,.85,1>]
   [1,color rgb <.9,.5,.3>]
   }
  }
 normal{
  average normal_map{
  [1,bozo .4 rotate 60 scale .025 noise_generator 3 slope_map{[0,<3,-18>][1,<0,0>]}]
  [1,bozo .7 rotate 60 scale .025 noise_generator 3]
  }
 } 
  
  }


#declare sten1=
texture{
// finish{diffuse 1 phong .2}
 st
 normal{
  average normal_map{
  [1,bozo rotate -60 scale .01 noise_generator 3 slope_map{[0,<-8,24>][.8,<0,0>]}]
  [1,bozo rotate 60 scale .006 noise_generator 3 slope_map{[0,<8,-24>][.8,<0,0>]}]
  }scale 2
 } 
// pigment{
//   bozo rotate -60 scale 1 noise_generator 3 color_map{[0,color rgb <.9,.8,.8>][1,color rgb <1,.8,.8>]}
//   } 
  }
/*texture{
 finish{diffuse .5 phong 1.8 metallic .25 reflection{.3,.5 metallic}}
 normal{
  average normal_map{
  [1,bozo .3 rotate 20 scale .03 noise_generator 3 slope_map{[0,<3,-8>][1,<0,0>]}]
  [1,bozo 3.5 rotate 60 scale 1.5 noise_generator 3]
  }
 } 
 pigment{
   color rgbt <.6,.75,1,0>
   }
  }*/

#declare sten2=
texture{
 finish{diffuse 1.5 phong .2}
// normal{bozo 2 rotate 60 scale .006 noise_generator 3}
 normal{
  average normal_map{
  [1,bozo .5 rotate 60 scale .02 noise_generator 3 slope_map{[0,<5,-10>][.5,<0,0>]}]
  [1,bozo 4 rotate 60 scale .006 noise_generator 3]
  }scale .75
 }
 pigment{
   color rgb <.5,.7,1>
   } 
  }
texture{
 finish{diffuse .15 phong 1.8 reflection{.15,.3}}
 normal{
  average normal_map{
  [1,bozo .05 rotate 60 scale .15 noise_generator 3 slope_map{[0,<3,-8>][1,<0,0>]}]
//  [1,bozo 3.5 rotate 60 scale 1.5 noise_generator 3]
  }
 } 
 pigment{
   color rgbt <.6,.75,1,.85>
   }
  }


#declare terracotta=texture{
 finish{diffuse 1.3 phong .1}
 normal{
  average normal_map{
  [1,bozo .5 rotate 60 scale .02 noise_generator 3 slope_map{[0,<5,-10>][.5,<0,0>]}]
  [1,bozo .5 rotate 60 scale .015 noise_generator 3 slope_map{[0,<5,-10>][.5,<0,0>]}]
  [1,bozo 2 rotate 60 scale .006 noise_generator 3]
  } scale .75
  }
 pigment{
//   color rgb <.5,.7,1>
   color rgb <.9,.75,.68>
   } 
  }

 
#declare area=0; 
#declare areacount=6;
#declare areadacount=2;
#declare areasize=5;
#declare mul=.76;
#declare le=10;

union{

//#declare l0=
light_source{        
 -le*z, color rgb <1.0,0.8,0.6>*0.75*mul
#if(area)           
 area_light x*areasize,y*areasize,areacount,areacount jitter adaptive areadacount circular orient 
#else
 parallel
#end
 rotate x*45 rotate -y*60
 }

//#declare l1=
light_source{
 -le*z, color rgb <0.6,0.8,1>*0.45*mul
#if(area) 
 area_light x*areasize,y*areasize,areacount,areacount jitter adaptive areadacount circular orient 
#else
 parallel
#end
 rotate x*60 rotate y*-120
 }

#declare l2=
light_source{
 -le*z, color rgb 0.25*mul
#if(area) 
 area_light x*areasize,y*areasize,areacount,areacount jitter adaptive areadacount circular orient 
#else
 parallel
#end
 rotate x*30 rotate y*105
 }
 rotate y*120
// rotate x*-30
}
camera{
// orthographic
// spherical
 location -15*z
 look_at 0
 up image_height*y/image_width
 right image_width*x/image_width
 angle 15
// translate -y*0.5
 rotate x*35
 rotate y*45
 
 }          

//disc{0,-y,10 texture{terracotta pigment{color rgb <.4,.45,.5>}}}

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

#include "tree.inc"

#macro create() 
#local ix=-1;
#while(ix<1.001)
 #local jx=-1;
 #while(jx<1.001)
 #warning concat("ix=",str(ix,0,3)," iy=",str(jx,0,3))

union{
 tree(0,-0.1*y,y*0.5,1)
// sphere{0,1 texture{st}}
 scale .25
 rotate y*30
 translate -x*jx*0.5-z*ix*0.5
} 
 #local jx=jx+0.5;
#end
 #local ix=ix+0.5;
#end
#end

//create()

/*
blob{
 #declare maxnest=5;
 tree(true,true,false, 0,-0.1*y,y*0.5)
 threshold 0.7
 rotate y*30
 translate -x*0.4
} 
*/
blob{
 #declare maxnest=5;
 tree(true,true,true, 0,-0.1*y,y*0.5)
 threshold 0.7
 rotate y*30
 translate -x*0.4
} 



object{house translate -y*0.}

//#declare tree1=union{tree(0,-0.2*y,y*0.5,1)}
//#declare tree2=union{tree(0,-0.2*y,y*0.5,1)}
/*
#local i=0;
#while(i<15)
 object{tree1 scale 0.2+rand(r)*.4 rotate y*rand(r)*560 translate 1.5*x*(rand(r)-0.5)+1.5*z*(rand(r)-0.5)}  
 object{tree2 scale 0.2+rand(r)*.4 rotate y*rand(r)*560 translate 1.5*x*(rand(r)-0.5)+1.5*z*(rand(r)-0.5)}  
 #local i=i+1;
#end
*/
