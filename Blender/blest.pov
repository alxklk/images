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

#declare Car=union
{
	box{-1,1}
}

#declare Tree_1=union
{
	box{-1,1 texture{pigment{color rgb <0.5,1,0.2>}}}
}

#declare Camera=union
{
	box{-0.001,0.001}
}

#declare Lamp=union
{
	box{-0.001,0.001}
}

#declare _Ground=union
{
	box{-0.001,0.001}
}

#declare obj=union
{
	box{-1,1 scale <1,0.001,1>*10 texture{smp pigment{checker color rgb 0.3 color rgb 0.7 scale 2}}}
	union{
		#include "blout.pov"

		#declare i=0;
		#while(i<bcn)	
			object{bcoa[i] scale bcsrt[i][0] rotate bcsrt[i][1] translate bcsrt[i][2]}
			#declare i=i+1;
		#end

		#declare i=0;
		#while(i<prn)	
			object{proa[i] scale prsrt[i][0] rotate prsrt[i][1] translate prsrt[i][2]}
			#declare i=i+1;
		#end

		#declare i=0;
		#while(i<son)	
			object{sooa[i] scale sosrt[i][0] rotate sosrt[i][1] translate sosrt[i][2]}
			#declare i=i+1;
		#end

		texture{smp}
		rotate -x*90
		scale -x
		rotate y*180
		}
	scale 0.025
}


object{obj scale 0.45 rotate y*180 translate -x+y*0.5}
object{obj scale 0.45 rotate y*90 translate -x-y*0.5}
object{obj scale 0.45 rotate y*135 rotate x*-35 translate  x+y*0.5}
object{obj scale 0.45 rotate y*0 rotate x*-90 translate  x-y*0.5}


