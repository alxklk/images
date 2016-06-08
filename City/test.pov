#include "env.inc"
#include "textures.inc"

camera{
 location -5*z
 look_at 0
 rotate x*35
 rotate y*45
 }  

light_source
{
  -10*z, color rgb 1
  rotate x*60
  rotate y*30
}



#include "wire.inc"

union{
	wire(10,0.01,0.001,0.023)
	scale 0.2
	translate -x
	texture{st pigment{color rgb 0}}
	}

#include "sect.inc"

union{sect(40,40,1,1,0.01) scale 0.3 texture{st}}
/*
intersection
//union
{
	object{sect}
	object{sect rotate y*90}
	rotate x*90
}
*/