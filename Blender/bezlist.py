import bpy
import math

def bezlist() :
	f=open("/Users/oleksii.kliuchykov/wrk/blout.txt","w")
	for v in bpy.data.objects :
		if v.type=="CURVE" :
			f.write("object{\n")
			for s in v.data.splines :
				print(s.type)
				if(s.type=="POLY") :
					for p in s.points :
#						print("<%8.6f, %8.6f, %8.6f>"%(p.co.x,p.co.y,p.co.z))
						print(p.co.count)
						f.write("<%8.6f, %8.6f, %8.6f>"%(p.co.x,p.co.y,p.co.z))
				elif(s.type=="BEZIER") :
					for p in s.bezier_points :
						print(p.co)
			f.write("}\n")
	f.close()
	print("\nOK\n")

bezlist()
