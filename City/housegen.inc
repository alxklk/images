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

#macro floorst(p0,p1,fz,s,l,n)

 #local ls=n;
 #local dp=<p1.x,p1.y>-<p0.x,p0.y>;
 #local len=vlength(dp);
 #if(n<0)
 	#local ls=floor(len/2.5);
 	#if(ls<1)#local ls=1;#end
 #end

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
    #local pos=(p0+dp*pl/wlen);
	#local angl=0;
	#if(dp.y=0)
  		#if(dp.x<0)
		  	#local angl=-90;
		#else
		  	#local angl=90;
		#end
	#else
	  	#local angl=atan2(dp.x,dp.y)*180/pi;
	#end

  	block0(<pos.x,fz,pos.y>, angl, len*ll/wlen, 2.5,char)
  	#if(reversed) scale <1,1,-1>#end
//  	cylinder{0.1*x,len*ll*x/wlen,0.1 translate y*3}
//  	rotate -y*90
  	#local pl=pl+weight; 
  }
  #local a=a+1;
 #end
 union{
	block0(<p0.x,0,p0.y>,0,0.0,2.5,".")
	}
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

#macro rel2abs(sc)
#local i=0;
#local cp=<0,0>;
#while(i<NP)
	#local cp=cp+h0p[i]*sc;
	#declare h0p[i]=cp;
	#local i=i+1;
#end
#end


#declare roof=texture{pigment{color rgb <0.3,.3,.5>}}
//#declare wall=texture{finish{diffuse 1 ambient 0.2} pigment{brick color rgb <.4,.45,.45> color rgb <1.0,.65,.22>}scale 0.035 }
#declare wall=texture{finish{diffuse 1.2 ambient 0.3} pigment{/*brick color rgb <.4,.45,.45> */color rgb <1.0,1.05,1.2>}scale 0.035 }
#declare glass=texture{st}
#declare frame=texture{sten pigment{color rgb 1}}
#declare balc =texture{finish{diffuse 1 ambient 0.2} pigment{color rgb 1}}

#declare reversed=false;
#declare NP=9;
#declare h0p=array[NP]{<0,10><30,0><30,-2><34,-2><34,0><64,0><64,10><30,10><5,20>};
#declare h0s=array[9] {"232", "1",  "4",  "1",  "232",  "2",  "2",    "2",  "23"};
#declare h0w=array[9] {  "2", "1",  "1",  "1",    "2",  "1",  "1",    "1",  "23"};
#declare h0n=array[9] {   9 ,  1 ,   1 ,   1 ,     9 ,   5 ,   5 ,     5 ,    5 };



#declare h0p=array[500];
#declare h0s=array[500];
#declare h0w=array[500];
#declare h0n=array[500];
#debug "House included "
#declare i=0;
#while(i<500)
	#declare h0p[i]=<0,0,0>;
	#declare h0s[i]="23";
	#declare h0w[i]="12";
	#declare h0n[i]=-5;
	#declare i=i+1;
#end

#debug concat("i=",str(i,0,0),"\n")

#declare reversed=true;
#declare NP=8;
#declare h0p=array[NP]{
<
0,0><0,-190><-40,0><0,215><20,25><260,0><0,-50><-240,0
>
};

#declare floorh=0;

//#macro floorst(p0,p1,s,l,n) #end

#macro floors(N)
	#local i=0;
	#while(i<N)
		union{
			#declare j=0;
			#while(j<NP)
				#debug concat("\nj=",str(j,0,0),", h0s[j]=",h0s[j],"\n")
				floorst(h0p[j],h0p[mod(j+1,NP)],floorh,h0s[j],h0w[j],h0n[j])
				#declare j=j+1;
			#end
//			translate y*floorh
			#declare floorh=floorh+2.5;
		}
		#local i=i+1;
	#end
#end

#macro rooftop(n)
prism
{
 linear_sweep
 linear_spline
 #debug concat("\nSpline ",str(NP+1,0,0),"\n")
 0,0.1,NP+1
 #declare j=0;
 #while(j<NP)
 #debug concat(" ",vstr(h0p[j],0,0),",")
	h0p[j]
 #declare j=j+1;
 #end
 #debug concat(" ",vstr(h0p[0],0,0),",")
 h0p[0]
	texture{roof}
 translate y*floorh
}
#end

#macro start()
	#declare h0p=array[100];#declare h0p[0]=<0,0>;
	#declare h0s=array[100];#declare h0s[0]="0";
	#declare h0w=array[100];#declare h0w[0]="1";
	#declare h0n=array[100];#declare h0n[0]=-1;
	#declare NP=0;
#end
