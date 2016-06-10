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

#macro win0(wx,wz,nx,ny,d,f,l)
 union{
	box{<-wx,-d,-wz>,<wx,d,wz> texture{glass}}
	union{
	box{-1,1 scale <wx+f,d*2,f> translate  z*wz}
	box{-1,1 scale <wx+f,d*2,f> translate -z*wz}
	box{-1,1 scale <f,d*2,wz+f> translate  x*wx}
	box{-1,1 scale <f,d*2,wz+f> translate -x*wx}
    #local i=1;
    #while(i<nx-0.001)
		box{-1,1 scale <wx+f,d*2,f/2> translate z*(i-nx/2)*wz/nx*2}
		#local i=i+1;
	#end
    #local i=1;
    #while(i<ny-0.001)
		box{-1,1 scale <f/2,d*2,wz+f> translate -x*(i-ny/2)*wx/ny*2}
		#local i=i+1;
	#end
		
	texture{frame}
	}
 }
#end 

#macro win(wx,wz,d,f,l)
	win0(wx,wz,3,1.5,d,f,l)
#end

#macro ho1(wx,wz,h,hr,rd,vv)
 union{
 	union{
	box{<-wx,0,-wz>,<wx,h,wz>}
	intersection{
		box{-1,1 rotate x*45 scale (z+y)/sqrt(2)}
		box{<-1.1,0,-1.1>,1.1}
		scale x*wx+y*hr+z*wz translate y*h
	}
	
	texture{wall}
 	}
 	union{
	box{-1,1 rotate x*45 scale <wx+rd,rd*2,rd*2> translate y*(h+hr)}	
	#local s=1/10;
	#local i=s/2;
	#local l=s*sqrt(wz*wz/4+hr*hr);
	#while(i<1+s)
		box{-1,1 scale <wx+vv,rd,l> rotate x*(-5+degrees(atan2(hr,wz))) translate y*(h+hr) translate z*i*wz-y*hr*i}	
		box{-1,1 scale <wx+vv,rd,l> rotate x*(-5+degrees(atan2(hr,wz))) translate y*(h+hr) translate z*i*wz-y*hr*i scale -z}	
		#declare i=i+1/10;
	#end   
	texture{roof}
	}
 }
#end 


#macro t04()
intersection{
 union{ho1(3,1,2,1,0.01,0.1)}
 box{0,<3,3.1,3> rotate -y*45}
}
#end

#macro tow4()
union{
	#local i=0;
	#while(i<4)
		union{t04 rotate y*i*90}
		#local i=i+1;
	#end
 scale 0.3 texture{sten}
}
#end

#macro towr(n, h, h1)
union{
	#local i=0;
	#while(i<n)

	intersection{
	 union{
	 	ho1(1,1,h,h1,0.01,0.1)
		union{win0(1.5,1,1,1.8,0.05,0.1,0.55) rotate -z*90 rotate y*90 scale 0.2 translate z+y*0.7}
	 	}
	 box{0,<1.75,h+h1+1,1.75> rotate -y*45 scale x*tan(pi/n)}
	 rotate y*i*360/n
	}
		#local i=i+1;
	#end
}
#end
/*
union{
towr(8,1,1)
scale 0.3
texture{sten}
}*/
//#declare house1=

#declare roof=texture{pigment{color rgb <1,.3,.5>}}
#declare wall=texture{finish{diffuse 1 ambient 0.2} pigment{brick color rgb <.8,.85,.85> color rgb <1.0,.95,.92>}scale 0.0205 }
#declare glass=texture{st}
#declare frame=texture{sten pigment{color rgb 1}}

#declare house1=
union{
union{ho1(3,1,2.75,1.25,0.01,0.1) rotate y*90}
union{ho1(1,1,2.5,1.5,0.01,0.1) translate -x*1.1}
union{ho1(0.4,0.7,1.2,0.8,0.01,0.1) translate -z*2+y*1.8-x*0.5}
union{ho1(0.4,0.7,1.2,0.8,0.01,0.1) translate  z*2+y*1.8-x*0.5}

union{win0(2,3.0,3,1.8,0.05,0.1,0.55) rotate -z*90 scale 0.25 translate -x-z*2+y*1.25}
union{win (2,1.5,0.05,0.1,0.55) rotate -z*90 scale 0.25 translate -x+z*2+y*1.25}
union{win0(2,3.0,3,1.8,0.05,0.1,0.55) rotate -z*90 rotate y*90 scale 0.25 translate -z*3+y*1.25}
union{win (2,1.8,0.05,0.1,0.55) rotate -z*90 rotate y*90 scale 0.2 translate -z*3+y*2.75}
union{win (1,1.25,0.05,0.1,0.55) rotate -z*90 scale 0.2 translate -x*0.9-z*2+y*3.15}
union{win (1,1.25,0.05,0.1,0.55) rotate -z*90 scale 0.2 translate -x*0.9+z*2+y*3.15}
union{win (2,1.5,0.05,0.1,0.55) rotate -z*90 scale 0.2  translate -x*2.1+y*2.75}

	union{box{-1,1 scale y*3.5+z*1.5+x*0.1} scale 0.25 translate -x*2.1+y*0.7 texture{roof pigment{color rgb <1,0.8,0.4>}}}
	union{win0(1.8,0.9,2,3,0.05,0.05,0.55) rotate -z*90 scale 0.25 translate -x*2.12+y*1.0}
}

#declare house2=
union{
	union{ho1(4.0,1.5,2.5,1.5,0.02,0.1) rotate y*90}
	union{ho1(2.8,2.25,2.75,2.2,0.02,0.1) rotate y*90}
	union{win0(2,1.5,2,1.4,0.05,0.1,0.55) rotate -z*90 scale 0.25 translate -x*1.5+y*1.25-z*3.4}
	union{win0(2,1.35,2,1.4,0.05,0.1,0.55) rotate -z*90 rotate y*90 scale 0.25 translate -x*0.6+y*1.25-z*4}
	union{win0(2,1.35,2,1.4,0.05,0.1,0.55) rotate -z*90 rotate y*90 scale 0.25 translate  x*0.6+y*1.25-z*4}
	union{win0(2,1.5,2,1.4,0.05,0.1,0.55) rotate -z*90 rotate y*90 scale 0.25 translate  x*0.0+y*2.8-z*4}

	union{ho1(1.0,1.0,2.75,1.5,0.02,0.1)translate -z*1.5-x*2}
	union{win0(2,1,2,1.5,0.05,0.1,0.55) rotate -z*90 scale 0.25 translate -x*3+y*1.25-z*1.1}
	union{win0(2,1,2,1.5,0.05,0.1,0.55) rotate -z*90 scale 0.25 translate -x*3+y*1.25-z*1.9}
	union{win0(1.7,1,2,1.4,0.05,0.1,0.55) rotate -z*90 scale 0.25 translate -x*3+y*3.0-z*1.5}

	union{ho1(1.2,1.2,2.75,1.75,0.02,0.1)translate z*1.3-x*1.8}
	union{win0(2,1.2,2,1.4,0.05,0.1,0.55) rotate -z*90 scale 0.25 translate -x*3+y*3.25+z*1.3}

	union{ho1(0.5,0.5,2.5,0.5,0.02,0.1)rotate y*90 translate -x*2.5-z*0.2}

	union{ho1(0.35,0.5,4.05,0.5,0.02,0.1)rotate y*90 translate -x*2.0-z*0.2}
	union{win0(1.3,1.0,2,1.8,0.05,0.1,0.55) rotate -z*90 scale 0.25 translate -x*2.5+y*3.5-z*0.2}

	union{ho1(0.6,1.5,2.2,0.5,0.02,0.1)rotate y*90 translate -x*2.5+z*1.3}
	union{win0(2,0.8,2,1.5,0.05,0.1,0.55) rotate -z*90 scale 0.25 translate -x*4.0+y*1.25+z*1.5}
	union{win0(2,0.8,2,1.5,0.05,0.1,0.55) rotate -z*90 scale 0.25 translate -x*4.0+y*1.25+z*1.1}

	union{ho1(0.5,0.7,0,0.25,0.02,0.1)rotate y*90 translate -x*3.0-z*0.2+y*2.25}
	union{box{-1,1 scale y*3.5+z*1.5+x*0.1} scale 0.25 translate -x*3.0+y*0.7-z*0.2 texture{roof pigment{color rgb <1,0.8,0.4>}}}
	union{win0(1.8,0.9,2,3,0.05,0.05,0.55) rotate -z*90 scale 0.25 translate -x*3.02+y*1.0-z*0.2}


//	rotate -y*45
//	scale .1
	}


object{house1 scale 0.1 translate <0.5,0,-0.5>}
object{house2 scale 0.1 translate <0.5,0,0.5>}

//union{towr(16,1.5,1.5) scale .2}