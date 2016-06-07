sphere{0,1000 
 texture{
  pigment{
   gradient y color_map{ 
    [0,color rgb <0.8,0.83,1>]
    [1,color rgb <0.4,0.7,1>]
    }scale 2 translate -y}finish{ambient .4 diffuse .8}scale 1000}

texture{
 pigment{average pigment_map{
 #declare gr=.75;
 #declare ge=3/(1+gr+gr);
 #declare t1=.2;
 #declare t2=.9;
 #declare tr1=-.2;
 #declare tr2=.2;
  [1,bozo translate 1*y color_map{
   [t1,color rgbt < 1,gr,gr,tr1>*ge]
   [t2,color rgbt < 0, 0, 0,tr2>*ge]
  }]
  [1,bozo translate 1*z color_map{
   [t1,color rgbt < gr, 1,gr,tr1>*ge/.85]
   [t2,color rgbt <  0, 0, 0,tr2>*ge]
  }]
  [1,bozo translate 1*x color_map{
   [t1,color rgbt < gr,gr, 1,tr1>*ge/.7]
   [t2,color rgbt <  0, 0, 0,tr2>*ge]
  }]
   
 }}scale 0.25 finish{ambient .4 diffuse .8}scale 2500}

 no_shadow
 no_image 
 //no_reflection
 hollow double_illuminate scale 100}
