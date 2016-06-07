union{

#if(l0)
light_source{        
 -le*z, color rgb <1.0,0.8,0.6>*0.75*mul
#if(area)           
 area_light x*areasize,y*areasize,areacount,areacount jitter adaptive areadacount circular orient 
#else
 parallel
#end
 rotate x*45 rotate -y*60
}
#end

#if(l1)
light_source{
 -le*z, color rgb <0.6,0.8,1>*0.45*mul
#if(area) 
 area_light x*areasize,y*areasize,areacount,areacount jitter adaptive areadacount circular orient 
#else
 parallel
#end
 rotate x*60 rotate y*-120
 }
#end

#if(l2)
light_source{
 -le*z, color rgb 0.25*mul
#if(area) 
 area_light x*areasize,y*areasize,areacount,areacount jitter adaptive areadacount circular orient 
#else
 parallel
#end
 rotate x*30 rotate y*105
}
#end
 rotate y*120
// rotate x*-30
}
