
\\
\\ Author: Jose Aranda, 2024 (C)
\\
\\ a086432
\\ Maximum of |det(M)| 
\\ M is an (n,n) binary circulant matrix.
\\
\\ a003432
\\ Hadamard "Maximal determinant problem"
\\ Largest Det of a (n,n) binary matrix.
\\
\\ for k: 3,7,11,15,19,23,31,35
\\ a003432(k)=a086432(k)
\\ 23= 4353564672
\\ 31= 562949953421312
\\ 35= 300189270593998242


\\ Code
\\
rowprint(n,R)={
my(i);
for(i=1,n,print1(R[i]));print;
}
matprint(n,M)={
my(i);
for(i=1,n,rowprint(n,M[i,])   );
}

shiftrow(n,P)={
my(t=P[n],L);
L=concat(t,P[1..(n-1)]);
return(L);
}


{
default(log,0);
default(logfile,"D:/DETMAXBC.LOG");
default(log,1);
\\
my(n);
for(n=2,19,
   my(a,gmaxd,glogR,gloga);
   gmaxd=0;glogR=0;gloga=0;
\\ number of Ones.
   for(a=1,(n-1),
      my(base,i);
      my(lmaxd,llogR,lloga);
      lmaxd=0;llogR=0;lloga=0;
      base=vector(n,i,0);
      for(i=(n-a+1),n,base[i]=1);
      qite=0;
      forperm(base,s,
         my(Rbeg,T,M,i,j,D,ck);
         Rbeg=Vec(s);M=matrix(n,n);
         qite++;
         if(qite%10^5==0,print("trz",qite));
         \\ Rbeg, R --> M
         T=Rbeg;
         for(i=1,n,
            for(j=1,n,M[i,j]=T[j]);
            T=shiftrow(n,T);
            );
         D=matdet(M);D=abs(D);
         if(D<lmaxd,next);
         lmaxd=D;llogR=Rbeg;lloga=a;
         llogM=M;
         );
      printsep(" ","a-local:"
         ,"n=",n,"a=",lloga,"D=",lmaxd);
      rowprint(n,llogR);
      if(lmaxd<gmaxd,next);
      gmaxd=lmaxd;gloga=lloga;
      glogR=llogR;glogM=llogM;
      );
   printsep(" ","Global:","n=",n
      ,"a=",gloga,"D=",gmaxd);
   matprint(n,glogM);
   print;print;
   );
}


