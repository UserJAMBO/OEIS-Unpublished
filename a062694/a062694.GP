
\\ Author: Jose Aranda, 2024.
\\ Public domain source code
\\
\\ Sequence A062694		
\\ Squarefree n such that the elliptic curve 
\\ n*y^2 = x^3 - x 
\\ arising in the "congruent number" problem 
\\ has rank 3 and nontrivial SHA[2].


\\ main
{
default(log,0);
default(logfile,"D:\LOGtemp0000.log");
default(log,1);


my(n,lin);lin=0;
for(n= 1,10^3,
  if(!issquarefree(n),next);
  my(n2,ebas,emod,erin);
  n2= n^2;

\\ D=1, Q.
  ebas= ellinit([-n2,0],D=1);
  emod= ellminimalmodel(ebas);
  erin=ellrankinit(ebas);

  my(rtno);
  rtno=ellrootno(ebas);

  my(rpl,trsn,v);
  rpl=ellratpoints(ebas,n,0);
  v=elltors(ebas);trsn=v[1];

  my(vran);
  vran= ellrank(erin,0,rpl); \\ effort default:0
  if(vran[1] != vran[2],
    vran= ellrank(erin,1,rpl); \\ effort:1
    );
\\ Tate-Shaferevich group info
  SHAs= vran[3];  
  my(aran);
  aran= ellanalyticrank(ebas);
\\ match rank 3 values
  my(badr,nrank);
  badr=0;
  nrank=aran[1];
  if(vran[1]!=aran[1],badr=1);
  if(vran[2]!=aran[1],badr=1);
\\
  if(badr>0,
    print(n);
    print("many rank values ");
    print(vran);print(aran);
    );
  printsep(" ",n
  ,"Rank=",nrank,rtno
  ,"Tors=",trsn,"SHAs=",SHAs);
\\
\\ discard and select
\\ select rank=3, SHA not trivial.
  if(badr,next);
  if(nrank != 3,next);
  if(SHAs==0,next);
\\
  lin++;
  print;
  printsep(" ","term:",lin,n);
  print;
  );
}

\\ PARI ellrank.
\\ The algorithm computes (exactly) three quantities:
\\ the rank C of the 2-Selmer group.
\\ the rank T of the 2-torsion subgroup.
\\ the rank s of G[2]/2G[4], using the Cassels pairing.
\\ the quantities that we are interested in are:
\\ the quantity R = C-T-s.
\\ the rank r of E(Q)
\\ the 2-rank of ?S) (conjecturally even).
\\ the following formula holds: C =T+r+S
\\ so R+s = r+S.
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


