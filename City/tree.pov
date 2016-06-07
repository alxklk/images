#declare fn0=function(a,b,c){f_granite(a*0.1,b*0.1,c*0.1)*0.3}
#declare fnx=function(a,b,c){fn0(a,b,c)}
#declare fny=function(a,b,c){fn0(a+100,b,c)}
#declare fnz=function(a,b,c){fn0(a,b,c+100)}

#declare maxnest=4;
//#declare rr=0.051;
#declare prb=0.4;


#declare N=0;
#declare r=seed(1364);
#declare r1=seed(13634);

#macro tree(trunk, leaves, nest, pos, del, sc1)
	#if (nest<=maxnest)

	#declare N=N+1;
	#local depth0=(nest  )/(maxnest);
	#local depth1=(nest+1)/(maxnest);
	
	#if(trunk)
	#if (nest<maxnest)
	#local is=0;
	#local l=vlength(del);
	#while(is<=l)
	   #local dr=is/l;
	   #local depth=depth0+(depth1-depth0)*dr;
	   #local R=pow(1-depth,4)*0.02+0.002;
	   sphere{0, R
			#local p=pos+del*dr;
			translate p
			translate (x*fnx(p.x,p.y,p.z)+y*fny(p.x,p.y,p.z)+z*fnz(p.x,p.y,p.z))*(1.3-depth)*0.3
			 
			texture{terracotta
			  pigment {granite scale 0.1+y*0.25 color_map{[0,color rgb <0.3,0.2,0.1>+(1-depth)*<0.5,0.5,0.5>][1,color rgb<0.3,0.2,0.1>]}}
			 }
		}
	 #local is=is+R/4+0.001;
	#end
	#end
	#end

	if(leaves)
	#if(nest>maxnest-2)
	 #local il=0;
	 #local l=vlength(del);
	 #while(il<=l)
	  #local dr=il/l;
	  #local il=il+.0005;
	  #local depth=depth0+(depth1-depth0)*dr;
	  #local p=pos+del*dr;
	   sphere{0,1
			translate x 
			scale <1,0.05,0.6>*0.03
			scale 0.1+rand(r1)*0.2
			translate x*rand(r1)*0.2*(1-depth)
//			scale (rand(r)+1)*pow(sc,1/4)*((1-dr)*0.5+0.5)*0.5
			rotate x*(rand(r1)-.5)*160
			rotate y*rand(r1)*360

			translate p
			translate (x*fnx(p.x,p.y,p.z)+y*fny(p.x,p.y,p.z)+z*fnz(p.x,p.y,p.z))*(1.3-depth)*0.3

			 texture{terracotta
			  finish{phong 1}
			  #local fl=dr;//*0.5+dr*0.5;
			  pigment {color rgb<fl*fl*0.4+0.2,0.3+0.7*fl,fl*fl*0.4+0.1>}
			 }
		}
	 #end
	#end
	#end
	
   #local ib=0;
   #while(ib<6)
	#local cmp=prb;
	#if(ib=0)#local cmp=0;#end 
	#if(rand(r)>cmp)
	 #local far=(0.25+rand(r)*0.7);
	 #if(ib=0)#local far=1;#end 
	 #local depth=depth0+(depth1-depth0)*far;

	 #local newdel=vnormalize(del);
	 #local newdel=vrotate(newdel,-90*x*rand(r));
	 #local newdel=vrotate(newdel,360*y*rand(r));
	 line(nest+1, pos+del*far,pow((1.0-depth+rand(r)*0.5)/2,2)*newdel,1)

//	 line(nest+1, pos+del*far,pow((1.50-depth)/2,2)*vrotate(vnormalize(del),90*(x*(rand(r))+360*y*(rand(r)-0.5)+0*z*(rand(r)-0.5))),1)
	#end
   #local ib=ib+1;
  #end

 #end
#end
