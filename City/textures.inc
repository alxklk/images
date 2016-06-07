#declare st=texture{pigment{color rgb<0.83,0.82,0.84>*1.2}
  finish{diffuse 0.85 ambient 0 specular 0.8 roughness 0.03 phong 1.0 brilliance 7.3 phong_size 80  metallic .5 
   reflection{0.6,1.0 metallic}}
  }

#declare pla=texture{
   pigment{color rgb 1}
   finish{diffuse 1. phong 1. phong_size 80 
    reflection{.1,.3}
   }
   //normal{bozo .3 scale .01}
  }

#declare sten=texture{
 finish{diffuse .9 phong 1.8 phong_size 80 reflection{.1,.3}}
 pigment{
  slope y color_map{
   [0,color rgb <.8,.85,1>]
   [1,color rgb <.9,.5,.3>]
   }
  }
 normal{
  average normal_map{
  [1,bozo .4 rotate 60 scale .025 noise_generator 3 slope_map{[0,<3,-18>][1,<0,0>]}]
  [1,bozo .7 rotate 60 scale .025 noise_generator 3]
  }
 } 
  
}


#declare sten1=
texture{
// finish{diffuse 1 phong .2}
 st
 normal{
  average normal_map{
  [1,bozo rotate -60 scale .01 noise_generator 3 slope_map{[0,<-8,24>][.8,<0,0>]}]
  [1,bozo rotate 60 scale .006 noise_generator 3 slope_map{[0,<8,-24>][.8,<0,0>]}]
  }scale 2
 } 
// pigment{
//   bozo rotate -60 scale 1 noise_generator 3 color_map{[0,color rgb <.9,.8,.8>][1,color rgb <1,.8,.8>]}
//   } 
  }
/*texture{
 finish{diffuse .5 phong 1.8 metallic .25 reflection{.3,.5 metallic}}
 normal{
  average normal_map{
  [1,bozo .3 rotate 20 scale .03 noise_generator 3 slope_map{[0,<3,-8>][1,<0,0>]}]
  [1,bozo 3.5 rotate 60 scale 1.5 noise_generator 3]
  }
 } 
 pigment{
   color rgbt <.6,.75,1,0>
   }
  }*/

#declare sten2=
texture{
 finish{diffuse 1.5 phong .2}
// normal{bozo 2 rotate 60 scale .006 noise_generator 3}
 normal{
  average normal_map{
  [1,bozo .5 rotate 60 scale .02 noise_generator 3 slope_map{[0,<5,-10>][.5,<0,0>]}]
  [1,bozo 4 rotate 60 scale .006 noise_generator 3]
  }scale .75
 }
 pigment{
   color rgb <.5,.7,1>
   } 
  }
texture{
 finish{diffuse .15 phong 1.8 reflection{.15,.3}}
 normal{
  average normal_map{
  [1,bozo .05 rotate 60 scale .15 noise_generator 3 slope_map{[0,<3,-8>][1,<0,0>]}]
//  [1,bozo 3.5 rotate 60 scale 1.5 noise_generator 3]
  }
 } 
 pigment{
   color rgbt <.6,.75,1,.85>
   }
  }
