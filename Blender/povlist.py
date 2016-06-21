import bpy
import math

def r2d(x) :
	return x/math.pi*180

def povlist() :
	f=open("d:\\wrk\\images\\Blender\\blout.pov","w")
	f.write("\n//Object list\n")
	
	for v in bpy.data.objects :
		dotindex=v.name.find(".")
		name=v.name
		if dotindex>0 :
			name=v.name[0:dotindex]
		f.write("object{\n")
		f.write("\t"+name+"\n")
		f.write("\tscale <%8.6f, %8.6f, %8.6f>\n"%(v.scale.x, v.scale.y,v.scale.z))
		f.write("\trotate <%8.6f, %8.6f, %8.6f>\n"
		%(r2d(v.rotation_euler.x), r2d(v.rotation_euler.y),r2d(v.rotation_euler.z)))
		f.write("\ttranslate <%8.6f, %8.6f, %8.6f>\n"%(v.location.x,v.location.y,v.location.z))
		f.write("}\n")
	f.close()
	print("\nOK\n")

povlist()
