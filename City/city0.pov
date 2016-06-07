// Alex Kluchikov, 2004
// mailto: klkspa[at]ukr.net, aklk[at]mail.ru
// Feel free to modify/use in any form

#version 3.7

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

#declare area=1; 
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

#include "house0.inc"

#include "tree.inc"


blob{
 #declare maxnest=5;
 tree(true,true,false, 0,-0.1*y,y*0.5)
 threshold 0.7
 rotate y*30
 translate -x*0.4
 scale 0.4
 translate <0.4,-0.2,-0.7>
} 


#declare b=
box
{
	-1,1 scale 0.5	
	texture
	{
		function{min(1,y*(5+f_granite(x,y,z)*2))}
		texture_map
		{
			[0,desert]
			[1,terracotta scale 0.3 pigment{bozo scale 0.6 color_map{[0,color rgb 0.65][1, color rgb 0.5]}}]
		}
	}
}


#declare f=0.02;
#declare r=0.4;
#declare lat1=
lathe {  // Lathe0
  bezier_spline
  52
  <0,0><r/3,0><2*r/3,0.0><r-f,0>
  <r-f,0><r,0.0><r,2*f><r+f,f>
  <r+f,f><r+2*f,0><r,0><r,-2*f>

#declare p0=0;
#declare p1=-1/3;
  <r  , p0-2*f><r,p0-2*f><r,p1+3*f><r,p1+2*f>
  <r  , p1+2*f><r,p1+f><r+f,p1+f><r+f,p1>
  <r+f, p1    ><r+f,p1-f><r,p1-f><r,p1-2*f>

#declare p0=-1/3;
#declare p1=-2/3;
  <r  , p0-2*f><r,p0-2*f><r,p1+3*f><r,p1+2*f>
  <r  , p1+2*f><r,p1+f><r+f,p1+f><r+f,p1>
  <r+f, p1    ><r+f,p1-f><r,p1-f><r,p1-2*f>

#declare p0=p1;
#declare p1=-1;
  <r,p0-2*f><r,p0-3*f><r,p1+3*f><r,p1+2*f>

  <r+f,p1-f><r+2*f,p1><r,p1><r,p1+2*f>
  <r-f,p1><r,p1><r,p1-2*f><r+f,p1-f>
  <0,p1><r/3,p1><2*r/3,p1><r-f,p1>

  translate y
  scale 0.22
}  // end Lathe0

union{
union{
	object{lat1 rotate x*3 translate -x-z}
	object{lat1 rotate x*5 translate -x-z*0.6}
	object{lat1 rotate -x*3 translate -x*0.8-z}
	object{lat1 translate -x-z*0.8}
	translate -y*0.03
	texture
	{
		function{max(0,min(1,y*(4+f_granite(x,y,z)*2)))}
		texture_map
		{
			[0,desert]
			[1,terracotta scale 0.3 pigment{bozo scale 0.6 color_map{[.5,color rgb <0.5,0.2,0.1>][1, color rgb <0.3,0.25,0.1>]}}]
		}
	}
	
	}

object{lat1 rotate x*90 rotate y*25 translate -x*0.5-z*0.75+y*0.05
	texture
	{
		function{max(0,min(1,y*(4+f_granite(x,y,z)*2)))}
		texture_map
		{
			[0,desert]
			[1,terracotta scale 0.3 pigment{bozo scale 0.6 color_map{[.5,color rgb <0.5,0.2,0.1>][1, color rgb <0.3,0.25,0.1>]}}]
		}
	}
	}
 	scale 0.6
 	rotate y*80
}
#declare hangar=
union{
#declare i=0;
#while(i<20.01)
	torus{1,0.1 rotate z*90 translate x*(i*0.15-1.5)}
//	cone{0,1.1, x*0.1,1 translate x*(i*0.2-1.5)}
//	cone{0,1.1,-x*0.1,1 translate x*(i*0.2-1.5)}
	
#declare i=i+1;
#end
	cylinder{-x*1.6,x*1.5,1.0}
	cylinder{-x*1.6-z*0.1,-x*1.6-z*0.1+y*0.5      ,0.01}
	cylinder{-x*1.6+z*0.1,-x*1.6+z*0.1+y*0.5      ,0.01}
	cylinder{-x*1.6-z*0.1+y*0.5,-x*1.6+z*0.1+y*0.5,0.01}
	scale 0.5
	texture
	{
		function{max(0,min(1,y*(4+f_granite(x,y,z)*2)))}
		texture_map
		{
			[0,desert]
			[1,terracotta scale 0.3 pigment{bozo scale 0.6 color_map{[0,color rgb 0.65][1, color rgb 0.5]}}]
		}
	}
}

height_field
{
	png "hf0.png"
	smooth
	scale x*2+z*2
	translate -x-z
	translate -y
	scale y*0.25
	texture
	{
		function{max(0,min(1,-y*20-1.0+f_granite(x*5,y*5,z*5)*0.1))}
		texture_map
		{
			[0,desert]
			[1,st pigment{color rgb<0.45,0.4,0.35>}normal{granite 0.01 scale 0.1}]
		}
	}  
	rotate y*90
}
difference
{
	cylinder
	{
		-x,x,1
	}
	cylinder
	{
		-x,x,0.9
		scale x*1.3
	}
	texture
	{
		terracotta scale 4
		pigment
		{
			function{max(0,min(1,y*0.5+0.5+f_granite(x*2,y*2,z*2)*0.2))}
			color_map
			{
				[0,color rgb <0.13,0.25,0.15>]
				[1,color rgb <0.6,0.5,0.4>]
			}
		}
	}
	scale x*1.2
	scale 0.1
	rotate y*35
	translate -x*0.35-z*0.32-y*0.175
}
/*box{-1,1 scale y*0.1 translate -y*0.1-y*0.05
	texture{st pigment{color rgb<0.45,0.4,0.35>}normal{granite 0.01 scale 0.1}}
	}*/

//plane{-y,0 texture{desert}}
