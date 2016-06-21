#version 3.7;

global_settings
{
	assumed_gamma 2.2
	noise_generator 3
}

light_source
{
	-z,color rgb 0.85
	parallel
	point_at 0
	rotate x*35
	rotate -y*45
}

light_source
{
	-z,color rgb 0.5
	parallel
	point_at 0
	rotate -x*25
	rotate y*40
}


camera{
 orthographic
// spherical
 location -15*z
 look_at 0
 up image_height*y/image_width
 right image_width*x/image_width
 angle 15
// translate -y*0.5
// rotate x*35
// rotate y*45
 
 }          

#declare smp=texture
{
	pigment{color rgb 1}
	finish{diffuse 0.9 ambient 0.1 phong 0.7 phong_size 80}
}

#declare Cube=union
{
	box{-1,1}
}

#declare Camera=union
{
	box{-0.001,0.001}
}

#declare Lamp=union
{
	box{-0.001,0.001}
}

#declare obj=union
{
	box{-1,1 scale <1,0.01,0.5>*10 texture{smp pigment{checker color rgb 0.3 color rgb 0.7 scale 2}}}
	union{
		#include "blout.pov"	
		texture{smp}
		rotate -x*90
		}
	scale 0.1
}


object{obj scale 0.45 rotate y*180 translate -x+y*0.5}
object{obj scale 0.45 rotate y*90 translate -x-y*0.5}
object{obj scale 0.45 rotate y*135 rotate x*-35 translate  x+y*0.5}
object{obj scale 0.45 rotate y*0 rotate x*-90 translate  x-y*0.5}


