
\\
\\ Author: Jose Aranda, 2024 (C)
\\
\\ a086432. Only Odd terms.
\\ Maximum of |det(M)| 
\\ M is an (n,n) binary circulant matrix.
\\
\\ 3:2^1,7:2^5,15:2^17,31:2^49,63: ?
\\
\\ See Brent pdf.
\\ also [2]J.Arndt and Others, Dec.16,2016.
\\

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
nmdigits(n,m)={
my(a=digits(m,2));
if(#a<n,
   a=concat( vector(n-#a), a);
   );
return(a);
}

{
default(log,0);
default(logfile,"D:/BCmaxdet.LOG");
default(log,1);
\\
forstep(n=3,31,2,
   if(n%2==0,break);
\\ root's of unity circle/n sectors.
\\ complex numbers.
   rofu=Vec(rootsof1(n));
\\ matrix of powers: roots^e 0..(n-1)
   rpj=matrix(n,n);
   for(i=1,n,
      for(j=1,n,
         rpj[i,j]=rofu[i]^(j-1);
         ););
\\ Odd term only.
\\ number of ones of the solution
   lones=(n+1)/2;
   if(n==5,lones=4);
\\
   BASE=vector(n);
   for(i=n-lones+1,n,BASE[i]=1); 
   totperm= (n!)/(lones!*(n-lones)!);
\\
   printsep(" ",n
      ,"Perm=",totperm,
      ,"Ones=",lones);
   print("integer permutations");
   
   my(FUL=List());
   forperm(BASE,s,
      m=fromdigits(Vec(s),2);
      listput(FUL,m);
      );
\\
   print(#FUL);
   printsep(" ","Lyndon words");
\\ 
   FUL=Vec(FUL);
   FUL=vecsort(FUL);
   for(ii=1,#FUL,
      if(ii%10^6==0,print(ii));
      m=FUL[ii];
      if(frac(m)>0,next);
      S=nmdigits(n,m);
      for(j=2,n,
         S=shiftrow(n,S);
         m=fromdigits(S,2);
         k=vecsearch(FUL,m);
         if(k==0,error("k0search"));
         FUL[k]+= 0.1;
         );
      );
   for(i=1,#FUL,
      if(frac(FUL[i])>0,FUL[i]=0);
      );
   FUL=vecsort(FUL,,8);
   if(FUL[1]!=0,error("FUL1ne0"));
   my(LW);
   LW=FUL[2..#FUL];
   FUL=0;
\\
   printsep(" ","LW max det",#LW);
   detmax=0;
   LW=Vec(LW);LW=vecsort(LW);
   for(ii=1,#LW,
      lw=LW[ii];
      S=nmdigits(n,lw);
\\ column = matrix*column
      my(eigen,PEV,pei);
      eigen= rpj*(S~);
      PEV= vecprod(eigen);
\\ imaginary side
      pei=imag(PEV);pei=abs(pei);
      pei=round(pei);if(pei!=0,next);
\\
      PEV=real(PEV);PEV=abs(PEV);
      PEV=round(PEV);
      if(PEV<=detmax,next);
      detmax=PEV;
      printsep(" ","n=",n,"det=",PEV,lw);
      );
   print("term end");
   LW=0;
   print;print;
   );
}


