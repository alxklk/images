#include <stdio.h>
#include <stdlib.h>

struct vert{
    float x;
    float y;
    float z;
    float nx;
    float ny;
    float nz;
    float u;
    float v;
};


int main(int argc, char** argv)
{
    if(argc<2)
        return 0;
    FILE* f=fopen(argv[1],"rb");
    if(!f)
        return 0;
/*    fseek(f,0,SEEK_END);
    int sz=ftell(f);
    printf("File size %i\n", sz);
    fseek(f,0,SEEK_SET);
    char* txt=(char*)malloc(sz+1);
    fread(txt,1,sz,f);
    txt[sz]='\0';
    printf("%s\n", txt);

    char* line=txt;
    int mode=0;*/
    char line[2048];
    vert* v;
    int* idx;
    int idxn=0;

    int nv=0;
    int ni=0;
    int iv=0;
    int ii=0;

    int l=0;
    bool readv=false;
    bool readi=false;
    while(1)
    {
        fgets(line,2046,f);
        if(feof(f))
            break;
        l++;
        int n=0;
        if(readv)
        {
            vert vrt;
            n=sscanf(line,"%f %f %f %f %f %f %f %f", 
                &vrt.x,&vrt.y,&vrt.z,
                &vrt.nx,&vrt.ny,&vrt.nz,
                &vrt.u,&vrt.v
                );
            if(n==8)
            {
                v[iv]=vrt;
                iv++;
                if(iv==nv)
                {
                    printf("vertices end\n");
                    readv=false;
                    readi=true;
                }
            }
            else
            {
                printf("error in vertices\n");
            }
        }
        else if(readi)
        {
            int in, id, nl=0, n;
            sscanf(line,"%i%n", &in, &n);
            if(n)
            {
                nl+=n;
                int inti[6];
                int intin=0;
                for(int i=0;i<in;i++)
                {
                    if(sscanf(line+nl," %i %n", &id, &n))
                    {
                        inti[intin++]=id;
                        nl+=n;
                    }
                    else
                    {
                        printf("error in indices\n");
                        break;
                    }
                }
                if(intin==3)
                { 
                    idx[idxn]=inti[0];idxn++; 
                    idx[idxn]=inti[1];idxn++; 
                    idx[idxn]=inti[2];idxn++;
                }
                else if(intin==4)
                {
                    idx[idxn]=inti[0];idxn++;
                    idx[idxn]=inti[1];idxn++;
                    idx[idxn]=inti[2];idxn++;
                    idx[idxn]=inti[0];idxn++;
                    idx[idxn]=inti[2];idxn++;
                    idx[idxn]=inti[3];idxn++;
                    if(idxn<20)
                    {
                        printf("index line: %i <", idxn);
                        for(int v=0;v<idxn;v++)
                            printf("%i ",idx[v]);
                        printf(">\n");
                    }
                }
                else
                {
                    printf("error in idx line\n");
                    break;
                }
            }
        }
        else if(sscanf(line,"element vertex %i", &n))
        {
            nv=n;
            printf("%i vertices\n", nv);
        }
        else if(sscanf(line,"element face %i", &n))
        {
            ni=n;
            idx=(int*)malloc(sizeof(int)*6*ni);
            printf("%i faces\n", ni);
        }
        else
        {
            n=0;
            sscanf(line,"end_header%n", &n);
            if(n)
            {
                readv=true;
                v=(vert*)malloc(sizeof(vert)*nv);
                printf("end header %i\n",n);
            }
        }
    }
    printf("%i indices\n", idxn);
    printf("%f triangles\n", idxn/3.0);
    printf("%i lines\n", l);
    {
        FILE* f=fopen("out.pov","wb");
        fprintf(f,"mesh2{\n\tvertex_vectors{\n\t\t%i,\n",nv);
        for(int i=0;i<nv;i++)
        {
            if((i%4)==0)
                fprintf(f,"\n\t\t");
            fprintf(f,"<%f,%f,%f>", v[i].x, v[i].y, v[i].z);
            if(i<nv-1)
                fprintf(f,", ");
        }
        fprintf(f,"\n\t}\n\tnormal_vectors{\n\t\t%i,\n",nv);
        for(int i=0;i<nv;i++)
        {
            if((i%4)==0)
                fprintf(f,"\n\t\t");
            fprintf(f,"<%f,%f,%f>", v[i].nx, v[i].ny, v[i].nz);
            if(i<nv-1)
                fprintf(f,", ");
        }
        fprintf(f,"\n\t}\n\tuv_vectors{\n\t\t%i,\n",nv);
        for(int i=0;i<nv;i++)
        {
            if((i%4)==0)
                fprintf(f,"\n\t\t");
            fprintf(f,"<%f,%f>", v[i].u, v[i].v);
            if(i<nv-1)
                fprintf(f,", ");
        }
        fprintf(f,"\n\t}\n\tface_indices{\n\t\t%i,\n",idxn/3);
        for(int i=0;i<idxn/3;i++)
        {
            if((i%4)==0)
                fprintf(f,"\n\t\t");
            fprintf(f,"<%i,%i,%i>", idx[i*3],idx[i*3+1],idx[i*3+2]);
            if(i<idxn/3-1)
                fprintf(f,", ");
        }
        fprintf(f,"\n\t}\n}\n");
        fclose(f);
    }    
    return 0;
}