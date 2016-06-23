import bpy
import math

def r2d(x) :
	return x/math.pi*180

def printtransform(f,v) :
	f.write("\tscale <%8.6f, %8.6f, %8.6f>\n"%(v.scale.x, v.scale.y,v.scale.z))
	f.write("\trotate <%8.6f, %8.6f, %8.6f>\n"
	%(r2d(v.rotation_euler.x), r2d(v.rotation_euler.y),r2d(v.rotation_euler.z)))
	f.write("\ttranslate <%8.6f, %8.6f, %8.6f>\n"%(v.location.x,v.location.y,v.location.z))

def printsrt(f,v) :
	f.write("<%8.6f, %8.6f, %8.6f>"%(v.scale.x, v.scale.y,v.scale.z))
	f.write("<%8.6f, %8.6f, %8.6f>"
	%(r2d(v.rotation_euler.x), r2d(v.rotation_euler.y),r2d(v.rotation_euler.z)))
	f.write("<%8.6f, %8.6f, %8.6f>"%(v.location.x,v.location.y,v.location.z))


def povlist() :
	f=open("d:\\wrk\\images\\Blender\\blout.pov","w")
	f.write("//Object list\n")
	f.write("#declare praa=array[1000];// prizm points array array\n")
	f.write("#declare proa=array[1000];// prizm objects array\n")
	f.write("#declare prna=array[1000];// prizm point number array\n")
	f.write("#declare prsrt=array[1000];// prizm scale rotate translate\n")
	f.write("#declare bcaa=array[1000];// bezier curve points array array\n")
	f.write("#declare bcoa=array[1000];// bezier curve objects array\n")
	f.write("#declare bcna=array[1000];// bezier curve point number array\n")
	f.write("#declare bcsrt=array[1000];// bezier curve scale rotate translate\n")
	f.write("#declare sooa=array[1000];//simple object array\n")
	f.write("#declare sosrt=array[1000];// simple object scale rotate translate\n")

	prn=0
	bcn=0
	son=0
	
	for v in bpy.data.objects :
		print(v.name+": "+v.type)
		if v.type=="CURVE" :
			f.write("//curve\n")
			for s in v.data.splines :
				print(s.type)
				if(s.type=="POLY") :
					len=s.points.__len__()
					print(len)
					f.write("#declare pntn=%i;\n"%len)
					f.write("#declare prna[%i]=pntn;\n"%prn)
					f.write("#declare praa[%i]=array[pntn]{\n"%prn)
					for p in s.points :
						f.write("<%8.6f, %8.6f, %8.6f>"%(p.co.x,p.co.y,p.co.z))
					f.write("\n};\n")

					f.write("#declare prsrt[%i]=array[3]{"%prn)
					printsrt(f,v)
					f.write("};\n")

					f.write("#declare proa[%i]=\n"%prn)
					f.write("prism{\n\tlinear_sweep\n\tlinear_spline 0,-%8.6f\n\tprna[%i]\n"%(s.points[0].co.z,prn))
					f.write("#declare i=0;\n#while(i<prna[%i])\n\t<praa[%i][i].x,praa[%i][i].y>\n\t#declare i=i+1;\n#end\n"%(prn,prn,prn))
					f.write("\trotate -x*90\n")
#					f.write("\n\tscale prsrt[%i][0]\n\trotate prsrt[%i][1]\n\ttranslate prsrt[%i][2]\n\t"%(prn,prn,prn))
					f.write("}\n")
					prn=prn+1
					
				elif(s.type=="BEZIER") :
					len=s.bezier_points.__len__()
					print(len)
					f.write("#declare pntn=%i;\n"%(len*4))
					f.write("#declare bcna[%i]=pntn;\n"%bcn)
					f.write("#declare bcaa[%i]=array[pntn]{\n"%bcn)

					for i in range(0,len) :
						ni=i+1
						if ni>=len : ni=0
						pc=s.bezier_points[i ]
						pn=s.bezier_points[ni]
						for p in [pc.co, pc.handle_right, pn.handle_left, pn.co]:
							f.write("<%8.6f, %8.6f> "%(p.x,p.y))
						f.write("\n")
					f.write("};\n")

					f.write("#declare bcsrt[%i]=array[3]{"%bcn)
					printsrt(f,v)
					f.write("};\n")

					f.write("#declare bcoa[%i]=\n"%bcn)
					f.write("prism{\n\tlinear_sweep\n\tbezier_spline 0,-%8.6f\n\tbcna[%i]\n"%(s.bezier_points[0].co.z,bcn))
					f.write("#declare i=0;\n#while(i<bcna[%i])\n\t<bcaa[%i][i].x,bcaa[%i][i].y>\n\t#declare i=i+1;\n#end\n"%(bcn,bcn,bcn))
					f.write("\trotate -x*90\n")
#					f.write("\n\tscale bcsrt[%i][0]\n\trotate bcsrt[%i][1]\n\ttranslate bcsrt[%i][2]\n\t"%(bcn,bcn,bcn))
					f.write("}\n")
					bcn=bcn+1
			print("\ncurve OK\n")
		elif v.type=="MESH" and v.name[0]!='_':
			dotindex=v.name.find(".")
			name=v.name
			if dotindex>0 :
				name=v.name[0:dotindex]
			f.write("#declare sooa[%i]=object{"%son)
			f.write(name)
			f.write("}\n")

			f.write("#declare sosrt[%i]=array[3]{"%son)
			printsrt(f,v)
			f.write("};\n")

			son=son+1
			print("\nobject OK\n")

	f.write("#declare bcn=%i;\n"%bcn)
	f.write("#declare prn=%i;\n"%prn)
	f.write("#declare son=%i;\n"%son)
	f.close()
	print("\nOK\n")

povlist()
