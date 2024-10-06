
\\ Author: Jose Aranda, 2024. (C).
\\ S_n presentarion.
\\ fixed patter length < n^2
\\ -------------------------


aplyX(V)= {
my(n,t);n=#V;t=V;
t=concat(concat(t[2],t[1]),t[3..n]);
return(t);
}
aplyL(V)= {
my(n,t);n=#V;t=V;
t=concat(t[2..n],t[1]);
return(t);
}
aplyR(V)= {
my(n,t);n=#V;t=V;
t=concat(t[n],t[1..(n-1)]);
return(t);
}
\\ execute presentation
exec(n,P)={
ID=vector(n,i,i);RN=Vecrev(ID);
T=ID;plen=#P;
for(i=1,plen,
   c=P[i];
   if(c=="L",T=aplyL(T));
   if(c=="R",T=aplyR(T));
   if(c=="X",T=aplyX(T));
   );
if(T==RN,
   print("Reached RN");return(1);
   );
print("ERROR RN not reached");
return(0);
}

{
default(log,0);
default(logfile,"D:/DETERMIN.LOG");
default(log,1);

print("Fixed pattern presentation");
print;

for(n=2,oo,
   trz=(n<9);
   nodd= (n%2==1);
   if(n%2==0,lp=n/2,lp=(n+1)/2);
   rp= n-lp;
   printsep(" ","n=",n,lp,"+",rp);
\\
   P=vector(n^3);pp=0;
\\
   for(a=1,(lp-1),
      forstep(b=a,1,-1,
         for(c=1,(b-1),pp++;P[pp]="L";);
         pp++;P[pp]="X";
         for(c=1,(b-1),pp++;P[pp]="R";);
         );
      );
\\
   if(nodd,f=rp;dch="R",f=lp;dch="L");
   for(c=1,f,pp++;P[pp]=dch);
\\   
   for(a=1,(rp-1),
      forstep(b=a,1,-1,
         for(c=1,(b-1),pp++;P[pp]="L");
         pp++;P[pp]="X";
         for(c=1,(b-1),pp++;P[pp]="R");
         );
      );
\\ naive presentation shortest
   P=P[1..pp];
   if(trz,print(concat(P)));
   while(1,
      pp=#P;
      B=vector(pp);bb=0;
      i=1;
      while(i<=pp,
         if(i<pp,
            islr= (P[i]=="L" && P[i+1]=="R");
            isrl= (P[i]=="R" && P[i+1]=="L");
            if(islr||isrl,i=i+2;next);
            bb++;
            B[bb]=P[i];
            i++;next;
            );
         bb++;B[bb]=P[i];i++;
         );
      B=B[1..bb];
      P=B;
      if(trz,
         printsep(" ","short",pp,bb);
         printsep(" ",concat(P));
         );
      if(bb==pp,break);
      );
\\ presentation ready
   pp=#P;
   printsep(" ","n=",n,"Pr.Length=",pp);
\\ ratio
   n2=n^2;diam= n*(n-1)/2;
   printsep(" ","n^2=",n2,"diameter=",diam);
   r1= pp/n2;r2= pp/diam;
   printf("ratios: %6.4f %6.4f \n",r1,r2);
\\ check presentation
   status=exec(n,P);
   if(status==0,break);
   print("presentation Checked.");
   print;
   );
}


