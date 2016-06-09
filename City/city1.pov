#version 3.7;

global_settings
{
	assumed_gamma 2.2
	noise_generator 3
	//max_intersections 18
	//max_trace_level 18
}

#include "functions.inc"
#include "desert_tex.inc"
#include "textures.inc"
#include "env.inc"
#include "terracotta.inc"

#declare area=0; 
#declare areacount=6;
#declare areadacount=2;
#declare areasize=5;
#declare mul=.76;
#declare le=10;
#declare l0=true;
#declare l1=true;
#declare l2=true;


#include "lights.inc"

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


box{-1,1 scale y*0.1 translate -y*0.1
texture{
  pigment{
   granite scale 3
   pigment_map{
    [.1,color rgb <.3,.65,.2>]
    [.3,bozo scale .025
     color_map{
      [0.1, color rgb <.3,.6,.3>]
      [0.5, color rgb <.35,.65,.2>]
     }
    ]
   }
  }
  finish{diffuse .8 ambient .15}
  normal{granite scale 3
   normal_map{
    [0.15,average normal_map{[1,bozo 5 scale .05][bozo 5 scale .01][bozo 5 scale .005][bozo 5 scale .0025][bozo 5 scale .001]}scale .4]
//    [0.2,average normal_map{[1,bozo 5 scale .001][bozo 5 scale .002][granite 3]}]
    [.25,average normal_map{[1,bozo 5 scale .025][bozo 5 scale .01][bozo 5 scale .0025][bozo 5 scale .001][bozo 5 scale .0005]}]
   }
  }
 }
}

#macro win(wx,wz,d,f,l)
 union{
	box{<-wx,0,-wz>,<wx,d,wz>}
	box{-1,1 scale <wx+f,d*2,f> translate  z*wz}
	box{-1,1 scale <wx+f,d*2,f> translate -z*wz}
	box{-1,1 scale <f,d*2,wz+f> translate  x*wx}
	box{-1,1 scale <f,d*2,wz+f> translate -x*wx}
	box{-1,1 scale <wx+f,d*2,f>}
	box{-1,1 scale <f,d*2,wz+f> translate -x*(l*2-1)*wx}
 }
#end 

#macro ho1(wx,wz,h,hr,rd,vv)
 union{
	box{<-wx,0,-wz>,<wx,h,wz>}
	box{-1,1 rotate x*45 scale (z+y)/sqrt(2) scale x*wx+y*hr+z*wz translate y*h}
	box{-1,1 rotate x*45 scale <wx+rd,rd*2,rd*2> translate y*(h+hr)}	
	#local s=1/10;
	#local i=s/2;
	#while(i<1+s)
		box{-1,1 scale <wx+vv,rd,s> rotate x*(-5+degrees(atan2(hr,wz))) translate y*(h+hr) translate z*i*wz-y*hr*i}	
		box{-1,1 scale <wx+vv,rd,s> rotate x*(-5+degrees(atan2(hr,wz))) translate y*(h+hr) translate z*i*wz-y*hr*i scale -z}	
		#declare i=i+1/10;
	#end
 }
#end 

union{
union{ho1(3,1,2,1,0.01,0.1) rotate y*90}
union{ho1(1,1,2,1,0.01,0.1) translate -x*1.1}
union{ho1(0.4,0.7,1,1,0.01,0.1) translate -z*2+y*0.8-x*0.5}
union{ho1(0.4,0.7,1,1,0.01,0.1) translate z*2+y*0.8-x*0.5}

union{win(2,1.5,0.03,0.15,0.55) rotate -z*90 scale 0.05 
	translate -x*2-z*2
	}
	scale 0.1
	texture{sten}
}