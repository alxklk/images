#macro sect(PN, yh, d, h, w)
prism
{
	bezier_spline linear_sweep	
	-yh,yh,
	PN*4*2+4+4

	<0,0+w><0,0+w/2><0,0-w/2><0,0-w>

#declare i=0;
#while(i<PN-0.01)
	#declare fr=mod(i,2)*h;
	<i*2,fr-w><i*2+d,fr-w><i*2+2-d,h-fr-w><i*2+2,h-fr-w>
	#declare i=i+1;
#end

	#declare fr=mod(PN-1,2)*h;
	<PN*2,h-fr-w><PN*2,h-fr-w/2><PN*2,h-fr+w/2><PN*2,h-fr+w>

#declare i=0;
#while(i<PN-0.01)
	#declare fr=mod(PN-i+1,2)*h;
	<PN*2-(i*2),h-fr+w><PN*2-(i*2+d),h-fr+w><PN*2-(i*2+2-d),fr+w><PN*2-(i*2+2),fr+w>
	#declare i=i+1;
#end

 translate -x*PN-y*(h+w)

 rotate x*90
 scale 0.1
}
#end


