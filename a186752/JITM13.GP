

\\ Author Jose Aranda, Sept 2024. 
\\ Sequence A186752.
\\ Script for new terms a(12),a(13).

\\ Times:
\\  1 minute to a(11)
\\ 12 minute to a(12)=64
\\ 3H+       to a(13)=76

\\ About the new performance
\\ Items of INT type.
\\ Distinct Lists. 
\\ Cache/Virtual memory friendly.
\\ Calls to full set operators. 
\\ like Intersect, setminus.
\\ Use of best type for each operation.
\\ like Set, Vec, List.


\\\\\\\\\\\\\\\\\\\\\\\
\\ CODE ***************
\\
ItemDump(n)={
t=digits(n,16);
printsep(" ",n,t);
}
\\ start execution time
InitialAt=getwalltime();
ToMega(n)={
a=floor(n/10^6);return(a);
}
TRZMEMCLK()={
printsep(" ","MEM  Heap:",ToMega(getheap())
   ,"B_Stack:",getstack());
printsep(" ","CLK ",strtime(getwalltime()-InitialAt) );
}

\\ 1-->3
SWAPROTATES(n)= {
K=digits(n,16);SL=#K;
\\
t=K;
t=concat(t[2..SL],t[1]);
L=fromdigits(t,16);
\\
t=K;
t=concat(t[SL],t[1..(SL-1)]);
R=fromdigits(t,16);
\\
t=K;
t=concat(concat(t[2],t[1]),t[3..SL]);
X=fromdigits(t,16);
\\
return([L,X,R]);
}

\\ evaluate meet
redmea(n)={
if(n==1 || n==2,return(0));
if(n%2==0,v=(n-2)/2,v=(n-1)/2);
return(v);
}
TestIfMeet(SL,tolis,blis)={
eqpar= ((tolis%2)==(blis%2));
if(eqpar==1,return(-1));
santo=redmea(tolis);sanb=redmea(blis);
san=santo+sanb;
print;
printsep(" ","Meet at : "
,tolis,blis,"-->",santo,sanb,"-->",san);
return(san);
}


{
default(log,0);
default(logfile,"D:/PMIDLE13.LOG");
default(log,1);

\\ Groups to be solved
SLA= 2;SLB=11;Vresults=vector(SLB);
for(SL= SLA,SLB,
\\ *   
   my(diam);
\\ group diameter as conjectured.
   diam=(SL-1)*SL/2;
   print;
   printsep(" ","Group=",SL,"Diameter=",diam);
\\
\\ Sn, Rn  States
   t=vector(SL,i,i);SN=fromdigits(t,16);
   t=Vecrev(t);RN=fromdigits(t,16);
\\ minimum mustbe 4. (SL 1,2,3).
   my(totlis= max(4,diam));
\\
\\ main struCture vector of _TYPE
   VL=vector(totlis,i,List());
\\
   listput(~VL[1],RN);listput(~VL[2],SN);
   VL[1]=Set(VL[1]);VL[2]=Set(VL[2]);
\\
\\ start main loop 
   my(aofn,meeted);aofn=-1;meeted=0;
\\ *   
\\ main for.  expand set's.
   for(nlis=1,diam,
\\    **
      if(meeted==1,break);
      my(exlis,tolis);
      exlis=nlis;tolis=nlis+2;
      if(exlis>totlis,break);
      if(tolis>totlis,break);
\\
      printsep(" ","Group Sn=",SL
         ,"of Diameter=",diam);
      print("Before next expand: ");
      my(besumr=0,besumb=0);
\\    **
      for(i=1,totlis,
         besumr+=#VL[i];
         besumb+= 2*sizebyte(VL[i]);
         );
      printsep(" ","MegaItems=",ToMega(besumr)
         ,"MB=",ToMega(besumb));
      TRZMEMCLK();
\\
\\    **
      my(exlissz=#VL[exlis]);
      printsep(" ","expand",exlis,exlissz
         ,"-> <tolis> ",tolis);
\\ expand exlis --> tolis
      VL[exlis]= Vec(VL[exlis]);
      VL[tolis]= List();
\\ foreach's vector exlis
\\ Add listsort each xx items.
\\    **
      foreach(VL[exlis],p,
         LABC = SWAPROTATES(p);
         for(j=1,3,
            q=LABC[j];
            listput(~VL[tolis],q);
            );
         );
\\
\\    **
\\ restore exlis to type Set
      print("Set & Close <exlis>");
      VL[exlis]= Set(VL[exlis]);
\\ sort wo dupl.
      print("listsort <tolis>");
      listsort(~VL[tolis],1);
      VL[tolis]=Set(VL[tolis]);
\\
      my(begSames,begOthers);
      if(tolis%2==1,begSames=1;begOthers=2;
         ,begSames=2;begOthers=1;
         );
\\    **
\\
      print("<tolis> setminus some Sets");
      forstep(i=begSames,(tolis-1),2,
         VL[i]= Set(VL[i]);
\\ setminus
         VL[tolis]
         =setminus(VL[tolis],VL[i]);
         print1(-i," ");
         );
\\ reorg tolis
\\    **
      print("listsort <tolis>");
\\ tolis listsort and Set.
      VL[tolis]=List(VL[tolis]);
      listsort(~VL[tolis],1);
      VL[tolis]=Set(VL[tolis]);
      print("Test others <tolis> setintersect");
      forstep(i=begOthers,(tolis-1),2,
         print1(" ?",i);
         VL[i]= Set(VL[i]);
         my(sinte,qinte);
         sinte= setintersect(VL[tolis],VL[i]);
         qinte=#sinte;sinte=Set();
\\
         if(qinte>0,
            tpr=TestIfMeet(SL,tolis,i);
            if(tpr>0,meeted=1;aofn=tpr;break);
            );
         );
      print;
\\    **
      if(meeted,break);
      print("listsort <tolis>");
\\ tolis listsort and Set.
      VL[tolis]=List(VL[tolis]);
      listsort(~VL[tolis],1);
      VL[tolis]=Set(VL[tolis]);
\\
\\    **
      printsep(" ","<tolis> items=",#VL[tolis]);
      print;
      );
\\ *   
\\ out main for. end of this group.
   printsep(" ","MEET. SL=",SL
   ,"Diameter=",diam
   ,"a(SL)=",aofn);
   print;Vresults[SL]=aofn;
\\ free memory
   print("Deallocate memory");
   for(i=1,#VL,VL[i]=List());VL=List();
   ); \\ close 
\\ end
print("RESULTS");
for(i=SLA,SLB,printsep(" ",i,Vresults[i]));
print;
}

\\ end of code
\\\\\\\\\\\\\\
\\\\\\\\\\\\\\
