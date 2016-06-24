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

#include "house1.inc"
#include "house0.inc"

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


blob{
 #declare maxnest=5;
 tree(true,true,false, 0,-0.1*y,y*0.5)
 threshold 0.7
 rotate y*30
 translate -x*0.4
} 



//object{house scale 0.5 translate -y*0.}

plane{-y,1 texture{desert}}

/*
#declare fp1=function
{
//	pattern{granite}
	pigment{image_map{png "rect3336.png"}}
}

height_field
{
	png "rect3336.png"
	smooth
	water_level 0.5
	scale y*0.02
	texture
	{
		function{fp1(x,z,y).gray}// {pattern{image_map{png "rect3336.png"}}}
//		gradient y 
		texture_map
		{
			[0, terracotta pigment {color rgb 0.3}]
			[0.5, desert]
			[1, terracotta pigment {color rgb 0.7}]
		}	
	}
	scale <2,1,2>
	translate <-1,0,-1>
} 
*/
/*
sphere
{
	0,1
	texture
	{
		average texture_map
		{
			[1, st]
			[1, terracotta]
		}	
	}	
}
*/

/*
#declare tree1=union{tree(0,-0.2*y,y*0.5,1)}
#declare tree2=union{tree(0,-0.2*y,y*0.5,1)}

#local i=0;
#while(i<15)
 object{tree1 scale 0.2+rand(r)*.4 rotate y*rand(r)*560 translate 1.5*x*(rand(r)-0.5)+1.5*z*(rand(r)-0.5)}  
 object{tree2 scale 0.2+rand(r)*.4 rotate y*rand(r)*560 translate 1.5*x*(rand(r)-0.5)+1.5*z*(rand(r)-0.5)}  
 #local i=i+1;
#end
*/
