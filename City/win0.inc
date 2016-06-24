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
