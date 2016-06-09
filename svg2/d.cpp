#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv)
{
    FILE* f=fopen("d.txt","rb");
    if(!f)
        return 0;
    fseek(f,0,SEEK_END);
    int sz=ftell(f);
    printf("File size %i\n", sz);
    fseek(f,0,SEEK_SET);
    char* txt=(char*)malloc(sz+1);
    fread(txt,1,sz,f);
    txt[sz]='\0';
    printf("%s\n", txt);

    char* line=txt;
    int mode=0;
    while(1)
    {
        float x0, y0;
        float x1, y1;
        float x2, y2;
        int n=0;
        if(sscanf(line,"m %f,%f %n",&x0, &y0, &n))
        {
            printf("MoveTo(%f, %f);\n",x0,y0);
            line+=n;
            mode=1;
        }
        else if((mode==1)&&sscanf(line," %f,%f %n",&x0, &y0, &n))
        {
            printf("LineTo(%f, %f);\n",x0,y0);
            line+=n;
            mode=1;
        }
        else if(sscanf(line,"c %f,%f %f,%f %f,%f %n",&x0, &y0, &x1, &y1, &x2, &y2, &n))
        {
            printf("CurveTo(%f, %f, %f, %f, %f, %f);\n",x0,y0,x1,y1,x2,y2);
            line+=n;
            mode=2;
        }
        else if((mode==2)&&sscanf(line," %f,%f %f,%f %f,%f %n",&x0, &y0, &x1, &y1, &x2, &y2, &n))
        {
            printf("CurveTo(%f, %f, %f, %f, %f, %f);\n",x0,y0,x1,y1,x2,y2);
            line+=n;
            mode=2;
        }
        else if(sscanf(line,"z%n",&n))
        {
            printf("Close();\n");
            line+=n;
            mode=2;
        }
        else
        {
            break;
        }
//        printf("\n<%s>\n", line);

    }
    printf("\n<%s>\n", line);



    return 0;
}