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

#macro block0(l,h,c)
#debug c
	#if(c="1")
		box{0,<l,h,0.1> texture{wall}}
	#elseif(c="2")
		difference
		{
			box{0,<l,h,0.1>}
			box{<0.5,1.0,-0.01>,<l-0.5,h-0.5,0.11>}
			texture{wall}
		}
		union{win0(l-0.5+0.125,h-1.5,1,1.8,0.05,0.1,0.55) rotate -x*90 translate <l-1,h-1.5> scale 0.5 translate y*1+x*0.5+z*0.1}
	#elseif(c="3")
		difference
		{
			box{0,<l,h,0.1>}
			box{<0.5,1.0,-0.01>,<l-0.5,h-0.5,0.11>}
			box{<0.5,0.0,-0.01>,<1.25,h-0.5,0.11>}
			texture{wall}
		}
		union{win0(l-1.75,h-1.5,1,3,0.05,0.1,0.55) rotate -x*90 translate <l-1.75,h-1.5> scale 0.5 translate y*1+x*1.25+z*0.1}
		union{win0(0.75,h-0.5,1,1,0.05,0.1,0.55) rotate -x*90 translate <0.75,h-0.5> scale 0.5 translate x*0.5+z*0.1}
		difference
		{
			box{0,<l,h/2,-h/2>}
			box{<0.1,0.1,-h/2+0.1>,<l-0.1,h*2+0.1,0.1>}
			texture{balc}
		}
	#elseif(c="4")
		difference
		{
			box{0,<l,h,0.1>}
			box{<0.5,1.0,-0.01>,<l-0.5,h-0.5,0.11>}
			box{<0.5,0.0,-0.01>,<1.25,h-0.5,0.11>}
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
	#end
#end

#declare weight=1;

#macro s2w(s)
  	#if(!strcmp(s,"1"))#declare weight=1;#end
  	#if(!strcmp(s,"2"))#declare weight=2;#end
  	#if(!strcmp(s,"3"))#declare weight=3;#end
  	#if(!strcmp(s,"4"))#declare weight=4;#end
  	#if(!strcmp(s,"5"))#declare weight=5;#end
  	#if(!strcmp(s,"6"))#declare weight=6;#end
  	#if(!strcmp(s,"7"))#declare weight=7;#end
  	#if(!strcmp(s,"8"))#declare weight=8;#end
  	#if(!strcmp(s,"9"))#declare weight=9;#end
#end

#macro floorst(p0,p1,s,l,n)

 #local ls=n;
 #local dp=p1-p0;
 #local len=vlength(dp);

 #local wlen=0;
 #local a=0;
 #while(a<ls)
  s2w(substr(l,mod(a,strlen(l))+1,1))
  #local ll=weight;
  #declare wlen=wlen+ll;
  #local a=a+1;
 #end

 #local a=0;
 #local pl=0;
 #while(a<ls)
  #local char=substr(s,mod(a,strlen(s))+1,1)
  s2w(substr(l,mod(a,strlen(l))+1,1))
  #local ll=weight;
  
  union{
  	block0(len*ll/wlen,2.5,char)
//  	cylinder{0.1*x,len*ll*x/wlen,0.1 translate y*3}
  	rotate atan2(dp.x,dp.y)*180/pi*y
  	rotate -y*90
    #local pos=(p0+dp*pl/wlen);
  	translate <pos.x,0,pos.y> 
  	#local pl=pl+weight; 
  }
  #local a=a+1;
 #end
#end


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

#declare roof=texture{pigment{color rgb <0.3,.3,.5>}}
#declare wall=texture{finish{diffuse 1 ambient 0.2} pigment{brick color rgb <.4,.45,.45> color rgb <1.0,.65,.22>}scale 0.035 }
#declare glass=texture{st}
#declare frame=texture{sten pigment{color rgb 1}}
#declare balc =texture{finish{diffuse 1 ambient 0.2} pigment{color rgb 1}}


#declare h0p=array[10]{<0,10><30,0><30,-2><34,-2><34,0><64,0><64,10><30,10><5,20><0,10>};
#declare h0s=array[10]{"0", "232", "1",  "4",  "1",  "232",  "1",  "1",    "1",  "23"};
#declare h0w=array[10]{"0", "232", "1",  "1",  "1",  "232",  "1",  "1",    "1",  "23"};
#declare h0n=array[10]{ 0,     9 ,  1 ,   1 ,   1 ,      9,   5 ,   5 ,     5 ,   5 };

#declare home1=
union{
#declare i=0;
#while(i<15)
union{
	#declare j=0;
	#while(j<9)
	floorst(h0p[j],h0p[j+1],h0s[j+1],h0w[j+1],h0n[j+1])
//	#declare j=1;
//	floorst(h0p[j],h0p[j+1],h0s[j+1],h0w[j+1],h0n[j+1])
//	floorst(<0,0>,<10,0>,"34","12",4)
//	floorst(<10,0>,<10,10>,"4343","32",3)
//	floorst(<10,10>,<0,0>,"1232","23",4)
	#declare j=j+1;
	#end
	translate y*i*2.5
}
#declare i=i+1;
#end

prism
{
 linear_sweep
 linear_spline
 0,0.1,10
 #declare j=0;
 #while(j<9)
	h0p[j]
 #declare j=j+1;
 #end
 h0p[0]
	texture{roof}
 translate y*(15*2.5)
 }
}

object{home1 scale 0.015 translate <-0.5,0,-0.5>}