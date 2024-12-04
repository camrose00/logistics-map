		.syntax     unified
		.cpu        cortex-m4
		.text

		.global		map
		.thumb_func
		.align
map:
//r, x0, xi*, xi size

            //S0 = r
           // S1 = x0
            //S2 = xi* address
            //R1 = size

  //copy of x0
push {R4}
MOV R4,0    //loop ctr



loop:
VMUL.f32 S4,S1,S0       //S4 = xi*r
VMOV.f32 S5,1.0
VSUB.f32 S5,S5,S1          //1-xi
VMUL.f32 S1,S4,S5          //xi+1 = xi*r*(1-xi)


ADD R4,1
CMP R4,100
blo loop            //1->100


MOV R4,0

      

loopr:              //101->(101+size)
CMP R4,0


VMUL.f32 S4,S1,S0
VMOV.f32 S5,1.0
VSUB.f32 S5,S5,S1
VMUL.f32 S1,S4,S5

VSTR S1,[R0]

ADD R0,4


ADD R4,1

CMP R4, R1
blo loopr


pop {r4}
		bx	lr
		.end
