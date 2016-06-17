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

#declare obj0=
union{
	cylinder{0,x,0.25 texture{smp pigment{color <1,0,0>}}}
	cylinder{0,y,0.25 texture{smp pigment{color <0,1,0>}}}
	cylinder{0,z,0.25 texture{smp pigment{color <0,0,1>}}}
	sphere{0,0.5 texture{smp}}
	}

#declare objb=
blob{
#declare i=-1;
#while(i<1.001)
	cylinder{-x*(2.8-i*i*0.5),x*(2.2-i*i*0.2),1.0,0.8 translate z*i-y*i*i*0.1 texture{smp pigment{color <1,0,0>}}}
#declare i=i+0.1;
#end
#declare i=-1;
#while(i<1.001)
	cylinder{-x*(0.6-i*i*0.4),x*(1.2-i*i*0.2),1.0,0.6 translate z*i*0.8-y*(-0.8+i*i*0.5) texture{smp pigment{color <1,0,0>}}}
#declare i=i+0.25;
#end
	cylinder{-z*2,z*2,0.8,   2 translate -x*1.25-y*0.75 texture{smp pigment{color <0,0,1>}}}
	cylinder{-z*2,z*2,0.7, -10 translate -x*1.25-y*0.75 texture{smp pigment{color <0,0,1>}}}
	cylinder{-z*2,z*2,0.8,   2 translate  x*1.5 -y*0.75 texture{smp pigment{color <0,0,1>}}}
	cylinder{-z*2,z*2,0.7, -10 translate  x*1.5 -y*0.75 texture{smp pigment{color <0,0,1>}}}
	cylinder{y-x*3-z,y-x*3+z,1.7,-6 texture{smp}}
	cylinder{y+x*3-z,y+x*3+z,1.5,-4 texture{smp}}
	sphere{-x*4+z*2.5,3.5,-4 texture{smp}}
	sphere{+x*3+z*3  ,2.5,-4 texture{smp}}
	sphere{-x*4-z*2.5,3.5,-4 texture{smp}}
	sphere{+x*3-z*3  ,2.5,-4 texture{smp}}
	}

#include "textures.inc"
#include "env.inc"

#declare ft=function{pigment{image_map{png "carmap.png"}}}
#declare obj=
union{
union
{
#include "out.pov"
texture{uv_mapping function{ft(x,y,z).gray} texture_map{[0,st pigment{color rgb <1,0.0,0.2>}][1,st]}}
rotate x*90
scale -y
//texture{uv_mapping pigment{function{ft(x,y,z).gray}}}
scale .5
}

	#declare wx=0.47;
	#declare wy=0.10;
	#declare wz=0.71;
	#declare wb=0.63;
	#declare ws=0.15;

	torus{1,0.5 rotate z*90 scale ws translate <-wx,wy,-wb> texture{st}}
	torus{1,0.5 rotate z*90 scale ws translate < wx,wy,-wb> texture{st}}
	torus{1,0.5 rotate z*90 scale ws translate <-wx,wy, wz> texture{st}}
	torus{1,0.5 rotate z*90 scale ws translate < wx,wy, wz> texture{st}}
}
object{obj scale 0.45 rotate y*180 translate -x+y*0.5}
object{obj scale 0.45 rotate y*90 translate -x-y*0.5}
object{obj scale 0.45 rotate y*135 rotate x*-35 translate  x+y*0.5}
object{obj scale 0.45 rotate y*0 rotate x*-90 translate  x-y*0.5}


