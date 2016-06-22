import bpy
import math

def r2d(x) :
	return x/math.pi*180

def povlist() :
	f=open("d:\\wrk\\images\\Blender\\blout.pov","w")
	f.write("\n//Object list\n")
	
	for v in bpy.data.objects :
		print(v.name+": "+v.type)
		if v.type=="CURVE" :
			f.write("//curve\n")
			for s in v.data.splines :
				print(s.type)
				if(s.type=="POLY") :
					len=s.points.__len__()
					f.write("#declare apntn=%i;\n"%len)
					f.write("#declare apnts=array[apntn]{\n")
					for p in s.points :
						f.write("<%8.6f, %8.6f, %8.6f>"%(p.co.x,p.co.y,p.co.z))
					f.write("\n};\n")
					f.write("prism{\nlinear_sweep\nlinear_spline 0,-%8.6f,apntn\n"%s.points[0].co.z)
					f.write("#declare i=0;\n#while(i<apntn)\n\t<apnts[i].x,apnts[i].y>\n\t#declare i=i+1;\n#end\n")
					f.write("\nrotate -x*90}\n")
	
					
				elif(s.type=="BEZIER") :
					len=s.bezier_points.__len__()
					print(len)
					f.write("prism{\nlinear_sweep\nbezier_spline 0,-%8.6f,%i\n"%(s.bezier_points[0].co.z,len*4))
					for i in range(0,len) :
						ni=i+1
						if ni>=len : ni=0
						pc=s.bezier_points[i ]
						pn=s.bezier_points[ni]
						for p in [pc.co, pc.handle_right, pn.handle_left, pn.co]:
							print(p)
							f.write("<%8.6f, %8.6f> "%(p.x,p.y))
						f.write("\n")
#					f.write("<%8.6f, %8.6f> "%(pn.co.x,pn.co.y))
					f.write("\nrotate -x*90\n}\n")

			print("\ncurve OK\n")
			f.write("//\n")
		elif v.type=="MESH" :
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
