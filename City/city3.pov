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

fog{fog_type 2 distance 3.0 color rgb <0.8,0.95,1>*1.2
	fog_offset 0.1
	fog_alt 0.2
	}

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

//#declare ground=
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

#declare pnts=array[100][4];

#declare ai=0;
#declare ac=<0,0>;
#macro moveTo(p)#declare ac=p;#end
#macro lineTo(p)
	#declare ac=p;
#end

/*
prism{
	linear_sweep
	linear_spline
	0,1
	5,<0,0><0,1><1,1><1,0><0,0>
	texture{st}
}
*/

#declare rnd=seed(234124);

#macro block0(p,a,l,h,c)
//#debug c
	union{
	#if(c=" ")
	#elseif(c=".")
		cylinder{0,h*y,0.1 texture{wall}}
	#elseif(c="a")
		box{-0.1*z,<l,h,0.1> texture{st}}
	#elseif(c="1")
		box{-0.1*z,<l,h,0.1> texture{wall}}
	#elseif(c="2")
		difference
		{
			box{-0.1*z,<l,h,0.1>}
			box{<0.5,1.0,-0.11>,<l-0.5,h-0.5,0.11>}
			texture{wall}
		}
		union{win0(l-0.5+0.125,h-1.5,1,1.8,0.05,0.1,0.55) rotate -x*90 translate <l-1,h-1.5> scale 0.5 translate y*1+x*0.5+z*0.1}
	#elseif(c="3")
		difference
		{
			box{-0.1*z,<l,h,0.1>}
			box{<0.5,1.0,-0.11>,<l-0.5,h-0.5,0.11>}
			box{<0.5,0.0,-0.11>,<1.25,h-0.5,0.11>}
			texture{wall}
		}
		union{win0(l-1.75,h-1.5,1,3,0.05,0.1,0.55) rotate -x*90 translate <l-1.75,h-1.5> scale 0.5 translate y*1+x*1.25+z*0.1}
		union{win0(0.75,h-0.5,1,1,0.05,0.1,0.55) rotate -x*90 translate <0.75,h-0.5> scale 0.5 translate x*0.5+z*0.1}
		difference
		{
			box{0,<l,h/2,-h/2>}
			box{<0.1,0.1,-h/2+0.1>,<l-0.1,h*2+0.1,0.1>}
			texture{balc pigment{color rgb <p.x*0.1,1-p.y*0.01, p.y*0.01>}}
		}
		box{<0,h-0.1,0>,<l,h,-h/2>
			texture{balc pigment{color rgb <p.x*0.1,1-p.y*0.01, p.y*0.01>}}
			}
		
	#elseif(c="4")
		difference
		{
			box{-0.1*z,<l,h,0.1>}
			box{<0.5,1.0,-0.11>,<l-0.5,h-0.5,0.11>}
			box{<0.5,0.0,-0.11>,<1.25,h-0.5,0.11>}
			texture{wall}
		}
		union{win0(l-1.75,h-1.5,1,3,0.05,0.1,0.55) rotate -x*90 translate <l-1.75,h-1.5> scale 0.5 translate y*1+x*1.25+z*0.1}
		union{win0(0.75,h-0.5,1,1,0.05,0.1,0.55) rotate -x*90 translate <0.75,h-0.5> scale 0.5 translate x*0.5+z*0.1}
		difference
		{
			cylinder{<l/2,0,0>,<l/2,h/2,0>,l/2-0.4}
			cylinder{<l/2,0.1,0>,<l/2,h/2+0.1,0>,l/2-0.5}
			box{-0.1,<l,h,l/2>}
			texture{balc}
		}
	#elseif(c="5")
		union{win0(l,h,1.6,2,0.05,0.1,0.55) rotate -x*90 translate <l,h,0> scale 0.5 translate z*0.1}
	#else
		box{-0.1*z,<l,h,0.1> texture{wall}}
	#end
		rotate -y*90
		rotate a*y
		translate p
	}
#end

#include "housegen.inc"
#include "win0.inc"
//#macro start()

#declare home1=union
{
#declare reversed=false;
#declare NP=6;
#declare h0p=array[NP]{<0,0><
31.25,-56.24994><12.5,0><31.249999,56.24994><-6.25,6.25><-62.499999,0
>};
rel2abs(0.5)

	floors(5)
	rooftop(5)
#declare NP=18;
#declare h0p=array[NP]{<30,-50><
		3.750023,-3.75002><7.499977,-2e-5><3.75,3.75004><0,18.7499><5,7.5><13.75,7.5001><4.999999,8.7499><-6.249999,8.75><-8.75,10e-5><-10,-6.25><-12.5,-10e-5><-10,6.25><-8.75,0><-6.25,-8.75><5,-8.75><13.75,-7.5><5,-7.5
>};
rel2abs(0.5)

	floors(5)
	rooftop(10)
}


object{home1 scale 0.025 translate <-0.5,0,-0.5>}
object{home1 scale 0.025 rotate -y*90 translate <-0.5,0,0>}

