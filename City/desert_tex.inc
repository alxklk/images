#declare desert = texture{
  pigment{
   granite scale 3
   pigment_map{
    [.1,color rgb <.7,.5,.3>]
    [.3,bozo scale .025
     color_map{
      [0.1, color rgb <.7,.5,.3>]
      [0.5, color rgb <.9,.7,.4>]
     }
    ]
   }
  }
  finish{diffuse .8 ambient .15}
  normal{granite scale 3
   normal_map{
    [0.15,average normal_map{[1,bozo 5 scale .05][bozo 5 scale .01][bozo 5 scale .005][bozo 5 scale .0025][bozo 5 scale .001]}scale .4]
    [0.2,average normal_map{[1,bozo 5 scale .001][bozo 5 scale .002][granite 3]}]
    [.25,average normal_map{[1,bozo 5 scale .025][bozo 5 scale .01][bozo 5 scale .0025][bozo 5 scale .001][bozo 5 scale .0005]}]
   }
  }
 }
