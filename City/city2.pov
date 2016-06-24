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


#include "tree.inc"
/*blob{
 #declare maxnest=5;
 tree(true,true,false, 0,-0.1*y,y*0.5)
 threshold 0.7
 rotate y*30
 translate -x*0.4
 scale 0.5
 translate <0.4,-0.1,-0.7>
}*/ 

union{
 #declare maxnest=5;
 tree(false,true,true, 0,-0.1*y,y*0.5)
 rotate y*30
 translate -x*0.4
// scale 0.5
 translate <0.4,-0.1,-0.7>
} 

