#declare terracotta=
texture{
 finish{diffuse 1.3 phong .1}
 normal
 {
  average normal_map
  {
  	[1,bozo .5 rotate 60 scale .02 noise_generator 3 slope_map{[0,<5,-10>][.5,<0,0>]}]
  	[1,bozo .5 rotate 60 scale .015 noise_generator 3 slope_map{[0,<5,-10>][.5,<0,0>]}]
  	[1,bozo 2 rotate 60 scale .006 noise_generator 3]
  } scale .75
 }
 pigment
 {
  color rgb <.9,.75,.68>
 } 
}
