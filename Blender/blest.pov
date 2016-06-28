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
	rotate y*45
}

light_source
{
	-z,color rgb 0.5
	parallel
	point_at 0
	rotate x*65
	rotate -y*130
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
	box{-0.001,0.001}
	box{-1,1}
}

#macro Car(sc,rt,tr)
union
{
	box{-0.001,0.001}
	box{-1,1}
	scale sc rotate rt translate tr
}
#end

#declare trrnd=seed(12341234);
#macro Tree_1(sc,rt,tr)
union
{
	box{-0.001,0.001}
	box{-1,1 texture{pigment{color rgb <0.2+rand(trrnd)*0.3,1+rand(trrnd)*0.3,0.1+rand(trrnd)*0.1>}}}
	translate z
	rotate z*90*rand(trrnd)
	scale 0.7+rand(trrnd)*0.6
	scale sc rotate rt translate tr
}
#end

#declare Camera=union
{
	box{-0.001,0.001}
	box{-0.001,0.001}
}

#declare Lamp=union
{
	box{-0.001,0.001}
	box{-0.001,0.001}
}

#declare _Ground=union
{
	box{-0.001,0.001}
	box{-0.001,0.001}
}

#macro fd(s)
	#local ls=strlen(s);
  	#local i=1;
	#while(i<ls)
		#if(substr(s,i,1)=".")
			#local i=i-1;
			#break
		#end
		#local i=i+1;
	#end
	substr(s,1,i)
#end

#include "../City/textures.inc"
#include "../City/housegen.inc"


#declare rnd=seed(234124);

#macro block0(p,a,l,h,c)
//#debug c
	union{
		box{-0.001,0.001}
		box{-0.001,0.001}
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

#declare obj=union
{
	box{-1,1 scale <1,0.00001,1>*1000 texture{smp pigment{checker color rgb 0.3 color rgb 0.7 scale 2}}}
	union{
		#include "blout.pov"

		#declare i=0;
		#while(i<bcn)	
//			object{bcoa[i] scale bcsrt[i][0] rotate bcsrt[i][1] translate bcsrt[i][2]}
			#debug fd(bcnames[i])
		#end

		#declare i=0;
		#while(i<prn)	
			#if (fd(prnames[i])="House1")
			object{proa[i] scale prsrt[i][0] rotate prsrt[i][1] translate prsrt[i][2] scale z*0.1 translate z*(8*2.5-0.2)}
			union
			{
				
//				start()
				#declare NP=prna[i];
				#debug concat("\nNP=",str(NP,0,0),"\n")
				#declare h0p=praa[i];
				box{-0.001,0.001}
				box{-0.001,0.001}
				floors(8)
//				rooftop(7)
				rotate x*90
				scale prsrt[i][0] rotate prsrt[i][1] translate prsrt[i][2]
			}
			#else
			object{proa[i] scale prsrt[i][0] rotate prsrt[i][1] translate prsrt[i][2] scale z*prha[i]/2 translate z*prha[i]/2}
			
			#end
			#debug concat("<",fd(prnames[i]),">")
			#declare i=i+1;
		#end

		#declare i=0;
		#while(i<son)	
			object{sooa[i]
				// scale sosrt[i][0] rotate sosrt[i][1] translate sosrt[i][2]
			}
			#debug fd(sonames[i])
			#declare i=i+1;
		#end

		texture{smp}
		rotate -x*90
		scale -x
		rotate y*180
		}
	scale 0.025
}

#declare test4=
union{
	object{obj scale 0.45 rotate y*180 translate -x+y*0.5}
	object{obj scale 0.45 rotate y*90 translate -x-y*0.5}
	object{obj scale 0.45 rotate y*135 rotate x*-35 translate  x+y*0.5}
	object{obj scale 0.45 rotate y*0 rotate x*-90 translate  x-y*0.5}
}

object{obj rotate y*135 rotate x*-35 translate y*0.5}
