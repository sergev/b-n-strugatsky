unit CROSSOST;  (*Программа для составления кроссвордов*)
interface
uses    Crt, Printer, Graph, Dos;
const   np=10; (*Число строк в таблице специальностей*)
        n0m=11; (*Максимальная полуширина кроссворда*)
type    s21=string[21]; s39=string[39]; s35=string[35]; s75=string[75];
        tic=record n0: byte; (*Полудлина строки <=n0m*)
                   aa: array[1..20,1..20] of char end;
        zna=record sl: s21;
                    mz: array[1..3] of word; (*номер строки в файле fz*)
                    sp: array[1..3] of byte; (*специальность значения*)
                    tr: array[1..3] of byte;  (*трудность значения*)
                    us: array[1..3] of word; (*номер последнего кроссворда*)
                     end;
       otc=record da,mo,ye: word;       (*дата создания кроссворда*)
                  nt,otr,osp: byte;     (*тип,трудность,специализация*)
                  no,mx: word; (*номер данного и признак получ.гонорара*)
                  t0: word;    (*время составления в сек*)
                  cn: real;    (*цена в тыс руб*)
           end;
var    n,nc,ns,nt,nt0,n1,n2,m1,m2,l,nfz,nps,npk,mm: longint;
       ye,mo,da,dw: word;
       i,i1,k,k1,ii,kk,ij,kj,j,jj,ee,x,y,n0,m,m0,p,otr,osp,vy: byte;
       nn: array[1..22] of longint;
       nm: array[1..21] of longint;
            (* длина файла номер K - nn[k] - кол-во слов длиной K
                                     nn[1] - число строк в файле fz
                                     nn[2] - число заданных типов кроссв-ов
                                     nn[3] - число строк в файле fps
                                     nn[22] - число сделанных кроссвордов *)
       sptr: array[0..2*np,1..3] of word; (*статистика спец-ть/трудность*)
       sl,sc,ss,s0: s21;
       ss1: s35;
       sz,sz0: s75;
       st: array[1..512,1..2] of longint;
(*st - Статистика для каждого типа кроссвордов: число и ср.время в секундах*)
       ac: array[0..40,0..40] of char;
       av: array[0..11,0..11] of char;
       al: array[0..32] of longint; (*Распределение по буквам*)
      al1: array[0..32] of real;
      tc,tc0: tic;
       zn: zna;
       ot: otc;
       f4,f5,f6,f7,f8,f9,f10,
         f11,f12,f13,f14,f15,f16,f17,f18,f19,f20,f21: file of zna;
         ftc,ftc0: file of tic; (*Файл типов кроссвордов - cross.tip*)
      fot: file of otc;  (*Файл-отчет по составленным кроссвордам*)
       fn,fst: text; (*slovar.nnn, slovar.sta*)
       fp: file of s35; (*Файл-список специальностей - slovar.spz*)
       fz: file of s75; (*Файл строк значений - slovar.zna*)
       fps: file of longint; (*"пустые" номера - slovarzn.pst*)

procedure t(i: byte);
procedure nfn(i: byte);
procedure nst(i: byte);
procedure rc(i,k: byte);
procedure rea(k: byte; n: longint; var zn: zna);
procedure wri(k: byte; n: longint);
procedure slsc(k: byte; var ee: byte);
procedure cr;

implementation
procedure t;
begin  textcolor(i) end;

procedure nfn;
begin if i=1 then reset(fn) else rewrite(fn);
      for k1:=1 to 22 do begin
               if i=1 then  readln(fn,nn[k1]);
               if i=2 then writeln(fn,nn[k1]:10) end;
      close(fn) end;


procedure nst;
begin if i=2 then rewrite(fst) else reset(fst);
if i=1 then begin for n:=1 to nn[2] do readln(fst,st[n,1],st[n,2]) end;
if i=2 then begin for n:=1 to nn[2] do writeln(fst,st[n,1]:3,st[n,2]:5) end;
      close(fst) end;

procedure rc;
begin
if i=1 then begin case k of
4: reset(f4); 5: reset(f5); 6: reset(f6); 7: reset(f7); 8: reset(f8);
9: reset(f9); 10: reset(f10); 11: reset(f11); 12: reset(f12);
13: reset(f13); 14: reset(f14); 15: reset(f15); 16: reset(f16);
17: reset(f17); 18: reset(f18); 19: reset(f19); 20: reset(f20);
21: reset(f21) end end;

if i=2 then begin case k of
4: close(f4); 5: close(f5); 6: close(f6); 7: close(f7); 8: close(f8);
9: close(f9); 10: close(f10); 11: close(f11); 12: close(f12);
13: close(f13); 14: close(f14); 15: close(f15); 16: close(f16);
17: close(f17); 18: close(f18); 19: close(f19); 20: close(f20);
21: close(f21) end end end;

procedure rea(k: byte; n: longint; var zn: zna);
begin case k of
           4: begin seek(f4,n-1); read(f4,zn) end;
           5: begin seek(f5,n-1); read(f5,zn) end;
           6: begin seek(f6,n-1); read(f6,zn) end;
           7: begin seek(f7,n-1); read(f7,zn) end;
           8: begin seek(f8,n-1); read(f8,zn) end;
           9: begin seek(f9,n-1); read(f9,zn) end;
          10: begin seek(f10,n-1); read(f10,zn) end;
          11: begin seek(f11,n-1); read(f11,zn) end;
          12: begin seek(f12,n-1); read(f12,zn) end;
          13: begin seek(f13,n-1); read(f13,zn) end;
          14: begin seek(f14,n-1); read(f14,zn) end;
          15: begin seek(f15,n-1); read(f15,zn) end;
          16: begin seek(f16,n-1); read(f16,zn) end;
          17: begin seek(f17,n-1); read(f17,zn) end;
          18: begin seek(f18,n-1); read(f18,zn) end;
          19: begin seek(f19,n-1); read(f19,zn) end;
          20: begin seek(f20,n-1); read(f20,zn) end;
          21: begin seek(f21,n-1); read(f21,zn) end end end;

procedure wri;
begin case k of
           4: begin seek(f4,n-1); write(f4,zn) end;
           5: begin seek(f5,n-1); write(f5,zn) end;
           6: begin seek(f6,n-1); write(f6,zn) end;
           7: begin seek(f7,n-1); write(f7,zn) end;
           8: begin seek(f8,n-1); write(f8,zn) end;
           9: begin seek(f9,n-1); write(f9,zn) end;
          10: begin seek(f10,n-1); write(f10,zn) end;
          11: begin seek(f11,n-1); write(f11,zn) end;
          12: begin seek(f12,n-1); write(f12,zn) end;
          13: begin seek(f13,n-1); write(f13,zn) end;
          14: begin seek(f14,n-1); write(f14,zn) end;
          15: begin seek(f15,n-1); write(f15,zn) end;
          16: begin seek(f16,n-1); write(f16,zn) end;
          17: begin seek(f17,n-1); write(f17,zn) end;
          18: begin seek(f18,n-1); write(f18,zn) end;
          19: begin seek(f19,n-1); write(f19,zn) end;
          20: begin seek(f20,n-1); write(f20,zn) end;
          21: begin seek(f21,n-1); write(f21,zn) end end end;

procedure slsc;
label     1,2;
begin  for i:=1 to k do begin
                        if sl[i]='-' then goto 1;
                        if sl[i]<>sc[i] then begin ee:=1; goto 2 end;
1:                        end;  ee:=0;
2:                        end;


procedure cr;
label   1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
        21,22,23,24,25,26,27,28,29,
        31,32,33,34,35,36,37,38,39,
        40,41,42,43,44,45,46,47;
var    mm,nsl,gv,gv0,x0,y0,pj,j0,aa,pc,pc1,cv,qq: byte;
       gd,gm,x1,x2,y1,y2: integer;
       h1,h2,m1,m2,s1,s2,ss1,ss2,p0,t0,m: word;
       t1,t2: real;
       mm0,nz: word;
       mns: array[1..255] of word; (* номер найденного слова в каталоге К*)
       msq: array[1..255] of byte;
       msc: array[0..255,1..6] of byte; (*Слова в составляемом кроссворде
                                  msc[0,1] - число строк в массиве
                                  msc[n,1..2]=X,Y начала слова
                                  msc[n,3]=gv - гориз(1) или верт (2)
                                  msc[n,4]=nsl - номер слова в кроссворде
                                  msc[n,5]=k - длина слова
                                  msc[n,6]=pr - число пересечений слова *)

procedure wac(nt: longint; var n0: byte); (*Создание типа кроссворда nt*)
label     1,2,3,4,6,7,8;
var       ss: string[2];
          p1,p2,uk: byte;
          up,ui: word;

procedure mx(i: byte; var k: byte);
begin case i of
      5..7 : k:=8-i;
      8..9 : k:=i-4;
      4    : k:=6;
     10..21: k:=i-3 end end;

begin  reset(ftc); seek(ftc,nt-1); read(ftc,tc);
                          n0:=tc.n0;
(*              for y:=0 to 40 do begin ac[0,y]:='0'; ac[2*n0,y]:='0' end;
              for x:=0 to 40 do begin ac[x,0]:='0'; ac[x,2*n0]:='0' end;*)
for y:=0 to 40 do for x:=0 to 40 do ac[x,y]:='0';

              for y:=1 to n0 do begin
                      for x:=1 to n0 do ac[x,y]:=tc.aa[x,y];
                      for x:=n0+1 to 2*n0-1 do ac[x,y]:=tc.aa[2*n0-x,y] end;
              for y:=n0+1 to 2*n0-1 do begin
                      for x:=1 to n0 do ac[x,y]:=tc.aa[x,2*n0-y];
                 for x:=n0+1 to 2*n0-1 do ac[x,y]:=tc.aa[2*n0-x,2*n0-y] end;
                 for y:=0 to 2*n0 do for x:=0 to 2*n0 do
                     if ac[x,y]='0' then ac[x,y]:=' ' else ac[x,y]:='-';
msc[0,1]:=0; nsl:=0; gv0:=0;
             for y:=1 to 2*n0-1 do for x:=1 to 2*n0-1 do
                 begin if ac[x,y]=' ' then goto 1;
                       if ac[x-1,y]='-' then goto 2;
                       k:=1; x0:=x; p1:=0;
3:      if (ac[x0,y-1]=' ') and (ac[x0,y+1]=' ') then goto 7;
        inc(p1);
7:      inc(x0); if ac[x0,y]='-' then begin inc(k); goto 3 end;
             if k>3 then begin inc(msc[0,1]); inc(nsl); gv0:=1;
                               msc[msc[0,1],1]:=x; msc[msc[0,1],2]:=y;
                               msc[msc[0,1],3]:=1; msc[msc[0,1],4]:=nsl;
                               msc[msc[0,1],5]:=k; msc[msc[0,1],6]:=p1  end;
2:                     if ac[x,y-1]='-' then goto 1;
                       k:=1; y0:=y; p2:=0;
4:      if (ac[x-1,y0]=' ') and (ac[x+1,y0]=' ') then goto 8;
        inc(p2);
8:      inc(y0); if ac[x,y0]='-' then begin inc(k); goto 4 end;
             if k>3 then begin inc(msc[0,1]);
                               if gv0=0 then inc(nsl) else gv0:=0;
                               msc[msc[0,1],1]:=x; msc[msc[0,1],2]:=y;
                               msc[msc[0,1],3]:=2; msc[msc[0,1],4]:=nsl;
                               msc[msc[0,1],5]:=k; msc[msc[0,1],6]:=p2  end;
1:    gv0:=0 end;
      msq[1]:=1;
      for j:=2 to msc[0,1] do begin mx(msc[j,5],uk);
                                    up:=100*msc[j,6]+uk;
            for i:=1 to j-1 do begin mx(msc[msq[i],5],uk);
                                    ui:=100*msc[msq[i],6]+uk;
                if up>ui then begin for k:=j downto i+1 do msq[k]:=msq[k-1];
                                        msq[i]:=j; goto 6 end end;
                                        msq[j]:=j;
6:                                      end; close(ftc) end;

procedure trud(var aa: byte);
begin aa:=0;
      if otr=0 then aa:=1;
      if otr=1 then if zn.tr[i]=1 then aa:=1;
      if otr=2 then if zn.tr[i]<3 then aa:=1;
      if otr=3 then if zn.tr[i]=2 then aa:=1;
      if otr=4 then if zn.tr[i]>1 then aa:=1;
      if otr=5 then if zn.tr[i]=3 then aa:=1 end;

procedure spez(var aa: byte);
begin if osp=0 then aa:=1;
      if osp=1 then case zn.sp[i] of 2: aa:=1;
                                     6: aa:=1;
                                    12: aa:=1 else aa:=0 end;
      if osp=2 then case zn.sp[i] of 1: aa:=1;
                                     3: aa:=1;
                                     5: aa:=1;
                                    11: aa:=1;
                                    12: aa:=1 else aa:=0 end;
      if osp=3 then case zn.sp[i] of 1: aa:=1;
                                     7: aa:=1;
                                    12: aa:=1;
                                    14: aa:=1 else aa:=0 end;
      if osp=4 then case zn.sp[i] of 7: aa:=1(*;
                                    16: aa:=1*) else aa:=0 end
end;

procedure prnt;
label     2;
var       z: byte;
procedure co(var z: byte);
begin
if ac[x,y-1]='-' then z:=1 else z:=0;
if ac[x-1,y-1]='-' then z:=z+2;
if ac[x-1,y]='-' then z:=z+4 end;

begin
for y:=1 to 2*n0 do begin
     for x:=1 to 2*n0+1 do begin
              if ac[x,y]=' ' then begin co(z);
                                  case z of
                                0: write(lst,' ':3);
                                1: write(lst,chr(192),chr(196),chr(196));
                                2: write(lst,chr(217),' ':2);
                                3: write(lst,chr(193),chr(196),chr(196));
                                4: write(lst,chr(191),' ':2);
                                5,7: write(lst,chr(197),chr(196),chr(196));
                                6: write(lst,chr(180),' ':2) end end;
              if ac[x,y]='-' then begin co(z);
                              case z of
                            0: write(lst,chr(218),chr(196),chr(196));
                            1: write(lst,chr(195),chr(196),chr(196));
                            2,3,5,6: write(lst,chr(197),chr(196),chr(196));
                            4: write(lst,chr(194),chr(196),chr(196)) end end;
                           end;
 writeln(lst);
    for x:=1 to 2*n0 do begin
        if ac[x,y]='-' then begin ss:='';
           for n:=1 to msc[0,1] do
                    if (msc[n,1]=x) and (msc[n,2]=y) then begin
                                              str(msc[n,4]:2,ss); break end;
      if ss='' then write(lst,chr(179),' ':2) else write(lst,chr(179),ss:2);
                            end;
if y<2*n0 then begin
        if ac[x,y]=' ' then begin
                       if ac[x-1,y]='-' then if ac[x,y-1]='-' then
                       if ac[x+1,y]='-' then if ac[x,y+1]='-' then
                begin write(lst,chr(179),chr(219),chr(219)); goto 2 end;
if ac[x-1,y]='-' then write(lst,chr(179),' ':2) else write(lst,' ':3);
2:                            end

                                           end end; writeln(lst);
                    end; writeln(lst); writeln(lst) end;

procedure ekrn(nt: longint);
begin
gd:=9; gm:=2; initgraph(gd,gm,' '); pc:=20;
for y:=2 to 2*n0 do for x:=2 to 2*n0 do begin
x2:=pc*x; y2:=pc*y; x1:=x2-pc; y1:=y2-pc;
if ac[x-1,y-1]=' ' then cv:=15;
if ac[x-1,y-1]='-' then cv:=0;
setfillstyle(solidfill,cv); bar(x1,y1,x2,y2);
setlinestyle(0,0,1); setcolor(15); rectangle(x1,y1,x2,y2);
for n:=1 to msc[0,1] do begin
  if (msc[n,1]=x-1) and (msc[n,2]=y-1) then begin str(msc[n,4]:2,ss);
settextstyle(0,0,0); outtextxy(x2-round(0.8*pc),y1+round(0.2*pc),ss);
                     break end end end;
str(nt:2,ss); ss:='Кроссворд типа '+ss;
outtextxy(pc,pc*(2*n0+1),ss);
readln; readln; closegraph;
end;

(*Распечатка составленного кроссворда номер NPK*)
procedure crpr(nt:longint);
label     1,5,36,37,38,39;
var       im,jj: byte;
          min,max: longint;
begin         wac(nt,n0); prnt;
              writeln(lst,da:2,'.',mo:2,'.',ye:4);
              writeln(lst,'КРОССВОРД номер ',npk:3);
              writeln(lst,'тип ',nt:3);
 if (otr=0) or (osp=0) then write(lst,' СМЕШАННЫЙ ');
              if otr=1 then write(lst,' ЛЕГКИЙ');
              if otr=2 then write(lst,' СРЕДНЕ-ЛЕГКИЙ');
              if otr=3 then write(lst,' СРЕДНИЙ');
              if otr=4 then write(lst,' СРЕДНЕ-ТЯЖЕЛЫЙ');
              if otr=5 then write(lst,' ТРУДНЫЙ');
              if osp=1 then write(lst,' ГУМАНИТАРНЫЙ');
              if osp=2 then write(lst,' ЕСТЕСТВЕННО-НАУЧНЫЙ');
              if osp=3 then write(lst,' ПОВСЕДНЕВНО-БЫТОВОЙ');
              if osp=4 then write(lst,' ПОЛИТИКО-ЭКОНОМИЧЕСКИЙ');
writeln(lst); writeln(lst);
pj:=1;
37:  if pj=1 then begin writeln('ЖДЕМ ВКЛЮЧЕНИЯ ПРИНТЕРА 1');
                        readln; readln;
          writeln(lst,'КРОССВОРД номер ',npk:3); writeln(lst);
                        writeln(lst,'ПО ГОРИЗОНТАЛИ ') end;
     if pj=2 then begin writeln(lst); writeln(lst,'ПО ВЕРТИКАЛИ ') end;
for j:=1 to msc[0,1] do
          if msc[j,3]=pj then begin rc(1,msc[j,5]); rea(msc[j,5],mns[j],zn);
                write(lst,msc[j,4]:2,' - ');
                max:=1; im:=1;
   for i:=1 to 3 do begin if zn.mz[i]=0 then break;
                         trud(aa); if aa=0 then goto 36;
                         spez(aa); if aa=0 then goto 36;
        if npk-zn.us[i]>max then begin im:=i; max:=npk-zn.us[i] end;
36:                    end;
      reset(fz); seek(fz,zn.mz[im]-1); read(fz,sz); close(fz);
      writeln(lst,sz); rc(2,msc[j,5]) end;
                 if pj=1 then begin inc(pj); goto 37 end;

pj:=1; writeln('ЖДЕМ ВКЛЮЧЕНИЯ ПРИНТЕРА 2'); readln; readln;
       writeln(lst,'КРОССВОРД номер ',npk:3); writeln(lst);
       writeln(lst,'ОТВЕТЫ:'); writeln(lst);
38:  if pj=1 then writeln(lst,'ПО ГОРИЗОНТАЛИ ');
     if pj=2 then begin writeln(lst); writeln(lst);
                        writeln(lst,'ПО ВЕРТИКАЛИ ') end;
     jj:=1;
for j:=1 to msc[0,1] do
          if msc[j,3]=pj then begin rc(1,msc[j,5]); rea(msc[j,5],mns[j],zn);
                write(lst,msc[j,4]:2,'-',zn.sl,' '); rc(2,msc[j,5]);
                inc(jj); if jj>5 then begin jj:=1; writeln(lst) end end;
                 if pj=1 then begin inc(pj); goto 38 end;
writeln(lst); writeln(lst); writeln(lst,' ':20,'Составил Р.Сом');
writeln(lst); writeln(lst); writeln(lst,da:2,'.',mo:2,'.',ye:4);
              writeln(lst,'КРОССВОРД номер ',npk:3);
              writeln(lst,'   тип ',nt:3);
 if (otr=0) or (osp=0) then write(lst,' СМЕШАННЫЙ ');
              if otr=1 then write(lst,' ЛЕГКИЙ');
              if otr=2 then write(lst,' СРЕДНЕ-ЛЕГКИЙ');
              if otr=3 then write(lst,' СРЕДНИЙ');
              if otr=4 then write(lst,' СРЕДНЕ-ТЯЖЕЛЫЙ');
              if otr=5 then write(lst,' ТРУДНЫЙ');
              if osp=1 then write(lst,' ГУМАНИТАРНЫЙ');
              if osp=2 then write(lst,' ЕСТЕСТВЕННО-НАУЧНЫЙ');
              if osp=3 then write(lst,' ПОВСЕДНЕВНО-БЫТОВОЙ');
              if osp=4 then write(lst,' ПОЛИТИКО-ЭКОНОМИЧЕСКИЙ');
              writeln(lst);
writeln(lst,'Пересечения: '); min:=0; jj:=0;
for j:=1 to msc[0,1] do begin rc(1,msc[j,5]); rea(msc[j,5],mns[j],zn); max:=0;
                         for i:=1 to 3 do begin if zn.mz[i]=0 then break;
                                        trud(aa); if aa=0 then goto 39;
                                        spez(aa); if aa=0 then goto 39;
              if npk-zn.us[i]>max then begin im:=i; max:=npk-zn.us[i] end;
39:                                       end;
     if max<=npk-1 then begin inc(min); inc(jj);
                        if min>1 then write(lst,', ');
                        write(lst,zn.sl,' (',zn.us[im],')');
                        if min>6 then begin min:=0; writeln(lst) end end;
      zn.us[im]:=npk; wri(msc[j,5],mns[j]); rc(2,msc[j,5]) end;
if jj=0 then writeln(lst,'ОТСУТСТВУЮТ ') else writeln(lst);

if ii=5 then write(lst,'Составлен ВРУЧНУЮ ',' ':5);
writeln(lst,'Время составления ',t0:6,' сек');
reset(fot); p0:=1+filesize(fot);
ot.da:=da; ot.mo:=mo; ot.ye:=ye;
ot.no:=npk; ot.nt:=nt; ot.otr:=otr; ot.osp:=osp;
ot.mx:=0; ot.t0:=t0; ot.cn:=0;
seek(fot,p0-1); write(fot,ot); close(fot);
writeln(lst); writeln(lst); writeln(lst); writeln(lst);
1:               end;

(*Вывод на экран кроссворда/матрицы ac[x,y]*)
procedure crd;
begin clrscr;
      for y:=1 to 2*n0 do begin for x:=1 to 2*n0 do write(ac[x,y]:2);
                    writeln end; writeln end;


procedure fltr(var aa: byte);
label     1,2,3;
var       j0: byte;
begin rea(msc[j,5],n,zn);
(*Слово zn.sl не анализируется, если не имеет ЗНАЧЕНИЯ *)
          if zn.mz[1]=0 then goto 3;
(*Слово zn.sl не анализируется, если уже есть в данном кроссворде *)
          for j0:=1 to msc[0,1] do
                        if (n=mns[j0]) and (msc[j,5]=msc[j0,5]) then goto 3;
(*Слово zn.sl не анализируется, если ТРУДНОСТЬ и СПЕЦИАЛЬНОСТЬ
                                     не соответствуют заданным*)
         for i:=1 to 3 do begin if zn.mz[i]=0 then break;
                                trud(aa); if aa=0 then goto 2;
                                spez(aa); if aa=0 then goto 2 else goto 1;
2:                        end;
3: aa:=0;
1: end;

procedure vykv(m: word);
begin seek(fot,m-1); read(fot,ot);
write(m:4,' ',ot.da:2,'.',ot.mo:2,'.',ot.ye,'   ',ot.no:4,' ',ot.nt:3,'   ');
            case ot.otr of
                 0: write('СМШ ');
                 1: write('ЛГК ');
                 2: write('СЛГ ');
                 3: write('СРД ');
                 4: write('СТЖ ');
                 5: write('ТЯЖ ') end;
            case ot.osp of
                 0: write('СМШ ');
                 1: write('ГУМ ');
                 2: write('ЕСТ ');
                 3: write('БЫТ ');
                 4: write('ПОЛ ') end;
            write(ot.t0:4,'c  ');
            if ot.cn<>0 then write(ot.cn:6:2) else write(' ');
            if ot.mx<>0 then writeln(' получено ') else writeln(' ':6) end;

procedure vykvp(m: word);
begin seek(fot,m-1); read(fot,ot);
write(lst,m:4,' ',ot.da:2,'.',ot.mo:2,'.',ot.ye,'   ',ot.no:4,' ',ot.nt:3,'   ');
            case ot.otr of
                 0: write(lst,'СМШ ');
                 1: write(lst,'ЛГК ');
                 2: write(lst,'СЛГ ');
                 3: write(lst,'СРД ');
                 4: write(lst,'СТЖ ');
                 5: write(lst,'ТЯЖ ') end;
            case ot.osp of
                 0: write(lst,'СМШ ');
                 1: write(lst,'ГУМ ');
                 2: write(lst,'ЕСТ ');
                 3: write(lst,'БЫТ ');
                 4: write(lst,'ПОЛ ') end;
            write(lst,ot.t0:4,'c  ');
            if ot.cn<>0 then write(lst,ot.cn:6:2) else write(lst,' ');
      if ot.mx<>0 then writeln(lst,' получено ') else writeln(lst,' ':6) end;

procedure srvn(var j: byte);
label     1,31;
var       m: word;
begin  j:=0; for m:=1 to nt do begin if m=nt0 then goto 31;
                                    seek(ftc,m-1); read(ftc,tc);
                                    if tc.n0<>tc0.n0 then goto 31;
for y:=1 to tc.n0 do for x:=1 to tc.n0 do if tc.aa[x,y]<>tc0.aa[x,y]
                                          then goto 31;
             t(12); write('Данный тип кроссворда уже есть:');
                                  write(' ',m:3); t(7); j:=1; goto 1;
31:                                 end;
1:                                  end;

procedure avt;
var       p,v,sx,sy: byte;
          cd: integer;
procedure vv(i: byte);
begin if random<=i/10 then av[x,y]:='1' end;
procedure pp(k: byte; var i:byte);
var       x1,y1: byte;
begin i:=0;
if k=1 then begin x1:=x-1;
                  while av[x1,y]='1' do begin inc(i); dec(x1) end end;
if k=2 then begin y1:=y-1;
                  while av[x,y1]='1' do begin inc(i); dec(y1) end end end;
procedure pv(k: byte);
begin case k of
           1..3: av[x,y]:='1';
              4: vv(8);
              5: vv(7);
              6: vv(6);
          7..10: vv(5) end end;
begin clrscr;
for x:=0 to tc0.n0 do for y:=0 to tc0.n0 do av[x,y]:='0';
write('Обычный - 0, Диагонально-симметричный - 1 '); read(kj);
randomize;
for y:=1 to tc0.n0 do begin if kj=1 then x1:=y else x1:=1;
                        for x:=x1 to tc0.n0 do begin p:=0;
                                    val(av[x+1,y-1],v,cd); p:=v;
                                    val(av[x,y-1],v,cd); p:=p+2*v;
                                    val(av[x-1,y-1],v,cd); p:=p+4*v;
                                    val(av[x-1,y],v,cd); p:=p+8*v;
                   case p of
                   0,1,4,5: vv(5);
                       2: begin pp(2,sy); pv(sy) end;
                       3: if av[x+1,y-2]='1' then av[x,y]:='0'
                          else begin pp(2,sy); pv(sy) end;
                       6: if (av[x-1,y-2]='1') or (av[x-2,y]='1')
                          then av[x,y]:='0'
                          else begin pp(2,sy); pv(sy) end;
                       7: if (av[x-1,y-2]='1')
                          or (av[x+1,y-2]='1') or (av[x-2,y]='1')
                          then av[x,y]:='0'
                          else begin pp(2,sy); pv(sy) end;
                       8: if y=1 then begin if av[x-2,y]='0' then vv(4) end
                                 else begin pp(1,sx); pv(sx) end;
                       9: if av[x-2,y]='0' then av[x,y]:='0'
                                            else begin pp(1,sx); pv(sx) end;
                   12,13: if (av[x-2,y-1]='1') or (av[x,y-2]='1')
                          then av[x,y]:='0'
                          else begin pp(1,sx); pv(sx) end;
                      10: begin pp(1,sx); pp(2,sy);
                                if sx<=sy then pv(sx) else pv(sy) end;
                                    end;
                                    if kj=1 then av[y,x]:=av[x,y] end end;
writeln;
(*for y:=1 to tc0.n0 do begin writeln;
                for x:=1 to tc0.n0 do if av[x,y]='1' then write(' o ')
                                                         else write('   ')
                           end;*)
end;

begin  assign(ftc,'cross.tip'); assign(fot,'cross.otc');
           assign(fn,'slovar.nnn'); assign(fst,'slovar.sta');
  assign(f4,'slovar.4'); assign(f5,'slovar.5'); assign(f6,'slovar.6');
  assign(f7,'slovar.7'); assign(f8,'slovar.8'); assign(f9,'slovar.9');
  assign(f10,'slovar.10'); assign(f11,'slovar.11'); assign(f12,'slovar.12');
  assign(f13,'slovar.13'); assign(f14,'slovar.14'); assign(f15,'slovar.15');
  assign(f16,'slovar.16'); assign(f17,'slovar.17'); assign(f18,'slovar.18');
  assign(f19,'slovar.19'); assign(f20,'slovar.20'); assign(f21,'slovar.21');
           assign(fp,'slovar.spz'); assign(fz,'slovar.zna');
           assign(fps,'slovarzn.pst');
getdate(ye,mo,da,dw);
10:   clrscr; nfn(1);
       t(15); writeln('Выход в МЕНЮ ......................... 0'); t(7);
              writeln('Типы кроссвордов и статистика......... 1');
              writeln('Ввод нового типа кроссворда........... 2');
              writeln('Исправление типа кроссворда........... 3');
              writeln('СОСТАВЛЕНИЕ кроссворда/автоматическое..4');
              (*writeln('СОСТАВЛЕНИЕ кроссворда/вручную.........5');*)
              writeln('НАБОР СТАТИСТИКИ.......................6');
              writeln('ВЫВОД ФАЙЛ-ОТЧЕТА......................7');
              writeln('Ввод после продажи.....................8');
              writeln('Сведения о типе кроссворда.............9');
              writeln;
              write('Выбран код.............................. '); read(ii);
              if ii=0 then goto 15;

if ii=9 then begin nst(1);
45:          clrscr; writeln('Всего в каталоге ',nn[2],' типов');
             writeln; write('Рассматриваем тип номер '); read(nt);
             if nt=0 then goto 10;
writeln(nt:3,'   ',st[nt,1]:4,'   ',round(st[nt,2]/st[nt,1]):3,' сек');
             readln; readln; goto 45 end;

if ii=7 then begin
29: reset(fot); p0:=filesize(fot);
writeln; writeln('В файл-отчете всего ',p0,' квитанций');
28:                write('Выводим квитанции от номера '); read(m1);
                   if m1=0 then begin close(fot); goto 10 end;
                   write('                  до номера '); read(m2);
        for m:=m1 to m2 do vykv(m);
        if ii=8 then goto 27;
        write('На принтер - 1, нет - 0 '); read(i);
        if i=1 then for m:=m1 to m2 do vykvp(m); goto 28 end;

if ii=8 then begin goto 29;
27:     writeln; write('Ввод в квитанцию номер '); read(m);
        if m=0 then goto 28;
        seek(fot,m-1); read(fot,ot);
write('Вводим цену - 1, Ввод признака получения гонорара - 2 '); read(i);
  if i=1 then begin write('Цена в тыс руб '); read(ot.cn) end;
  if i=2 then begin write('Кроссворд продан - 1, нет - 0 '); read(ot.mx) end;
        seek(fot,m-1); write(fot,ot); writeln; vykv(m); goto 27 end;

if ii=6 then begin
(*        nst(1);
        for n:=1 to nn[2] do st[n,1]:=1;
        nst(2);*)

18:     nst(1); otr:=0; osp:=0; n1:=st[1,1]; nt:=1;
for n:=1 to nn[2] do begin
      if (st[n,1]<n1) and (st[n,2]>0) then begin nt:=n; n1:=st[nt,1] end end;
     clrscr; write('Кроссворд номер ',nt:3);
writeln(';  число проб ',st[nt,1]:3,';  ср.время ',round(st[nt,2]/st[nt,1]):3,' сек ');
                                     delay(10000); goto 17;
             end;

       clrscr;
       reset(ftc); nt:=filesize(ftc);
       writeln('Всего в списке ',nt:3,' типов кроссвордов '); writeln;
       close(ftc);

if ii=1 then begin clrscr; nst(1);
for ii:=1 to 128 do begin if ii mod 16=1 then begin t(14);
                                        writeln(' nt  Ns Spr   ST'); end;
               for jj:=1 to 4 do begin nt:=jj+4*(ii-1);
                   if nt>nn[2] then goto 19;
                     wac(nt,n0);
                    t1:=0; for n:=1 to msc[0,1] do t1:=t1+msc[n,6];
                    t1:=t1/msc[0,1];
          t(15); write(nt:3,'  '); t(7);
if round(st[nt,2]/st[nt,1])<100 then t(10);
if round(st[nt,2]/st[nt,1])=0 then t(12);
                    write(msc[0,1]:2,' ',t1:3:1,' ');
if st[nt,2]>0 then write(round(st[nt,2]/st[nt,1]):4,'  ')
                                                    else write(' ':6) end;
                   writeln; if ii mod 16=0 then begin readln; readln end end;
19:                     writeln; write('На принтер - 1 '); read(i);
if i=1 then begin writeln(lst,'Данные на ',da:2,'.',mo:2,'.',ye:4);
                  writeln(lst,'Длина файла значений ',nn[1]);
for ii:=1 to 128 do begin if ii mod 16=1 then writeln(lst,' nt  Ns Spr   ST');
               for jj:=1 to 4 do begin nt:=jj+4*(ii-1);
         if nt>nn[2] then begin writeln(lst); writeln(lst); goto 7 end;
                     wac(nt,n0);
                    t1:=0; for n:=1 to msc[0,1] do t1:=t1+msc[n,6];
                    t1:=t1/msc[0,1];
           write(lst,nt:3,'  '); t(7);
                    write(lst,msc[0,1]:2,' ',t1:3:1,' ');
if st[nt,2]>0 then write(lst,round(st[nt,2]/st[nt,1]):4,'  ')
                                               else write(lst,' ':6) end;
   writeln(lst); if ii mod 16=0 then writeln(lst) end end;
7: writeln; write('Выводим тип-кроссворд номер '); read(nt);
                   if nt=0 then goto 10;
                   wac(nt,n0); ekrn(nt);
write('Выводим тип кроссворда на печать - 1, нет - 0 '); read(i);
          if i=1 then prnt;
(*writeln('ПОРЯДОК ВЫБОРА СЛОВ');
writeln('Кроссворд типа ',nt:2);
write(' ':6,'k pr   N nsl',' ':3);
if msc[0,1]>20 then write(' ':6,'k pr   N nsl',' ':3);
if msc[0,1]>40 then write(' ':6,'k pr   N nsl',' ':3);
writeln;
          for i:=1 to 20 do begin
          for jj:=1 to 3 do begin j:=20*(jj-1)+i;
                            if j<=msc[0,1] then begin
         write(j:2,'   ',msc[msq[j],5]:2,' ',msc[msq[j],6]:1,'   ');
        write(msq[j]:2,' ',msc[msq[j],4]:2,' ':4) end else write(' ':18);
                                              end; writeln end;
writeln; write('Выводим на печать - 1, нет - 0 '); read(i);
if i=1 then begin;
writeln(lst,'ПОРЯДОК ВЫБОРА СЛОВ');
writeln(lst,'Кроссворд типа ',nt:2);
write(lst,' ':6,'k pr   N nsl',' ':3);
if msc[0,1]>20 then write(lst,' ':6,'k pr   N nsl',' ':3);
if msc[0,1]>40 then write(lst,' ':6,'k pr   N nsl',' ':3);
writeln(lst);
          for i:=1 to 20 do begin
          for jj:=1 to 3 do begin j:=20*(jj-1)+i;
                            if j<=msc[0,1] then begin
         write(lst,j:2,'   ',msc[msq[j],5]:2,' ',msc[msq[j],6]:1,'   ');
write(lst,msq[j]:2,' ',msc[msq[j],4]:2,' ':4) end else write(lst,' ':18);
                                              end; writeln(lst) end;
writeln(lst); writeln(lst) end; *)
   goto 10 end;

if ii=2 then begin
1:      reset(ftc); nt:=filesize(ftc);
write('Вводим кроссворд типа '); read(nt0);
      if nt0=0 then begin close(ftc); goto 10 end;
        write('Полудлина строки (<=',n0m:2,'!) '); read(tc0.n0);
    writeln; write('Ввод: "из газеты" - 1; "автоматический" - 2 '); read(ij);
        if ij=2 then begin avt;
        for y:=1 to tc0.n0 do for x:=1 to tc0.n0 do tc0.aa[x,y]:=av[x,y];
                            goto 34 end;

      writeln; write(' ':10); for i:=1 to tc0.n0 do write('o'); writeln;
       y:=1;
33:    readln; write('Строка ',y:2,' '); x:=1;
32:    read(tc0.aa[x,y]); inc(x); if x<=tc0.n0 then goto 32;
                             inc(y); if y<=tc0.n0 then goto 33;
34:                       srvn(jj); if jj=1 then begin writeln; goto 1 end;
     if ii=2 then begin if nt0>nt then begin inc(nn[2]); nfn(2) end end;
              seek(ftc,nt0-1); write(ftc,tc0); close(ftc);
          if ij=2 then begin y0:=0; goto 47 end;
                               goto 1 end;

 if ii=3 then begin
31: writeln; write('Исправляем кроссворд типа '); read(nt0);
                      if nt0=0 then goto 10;
47:                   reset(ftc); seek(ftc,nt0-1); read(ftc,tc);
                      if ij=2 then begin ij:=0; goto 46 end;
36:                   t(14); write('Строку номер '); read(y0);
46:        if y0=0 then begin tc0.n0:=tc.n0;
    for x:=1 to tc0.n0 do for y:=1 to tc0.n0 do tc0.aa[x,y]:=tc.aa[x,y];
                       srvn(jj); if jj=1 then begin writeln; goto 31 end;
                       tc.n0:=tc0.n0;
    for x:=1 to tc.n0 do for y:=1 to tc.n0 do tc.aa[x,y]:=tc0.aa[x,y];
                   seek(ftc,nt0-1); write(ftc,tc); close(ftc);
                   wac(nt0,n0); ekrn(nt0);
                         goto 31 end;
t(12); write('Старая строка ');
       for x:=1 to tc.n0 do write(tc.aa[x,y0]:1); writeln;
t(13); readln; write('Новая строка  '); x:=1;
35:      read(tc.aa[x,y0]); inc(x); if x<=tc.n0 then goto 35;
                   goto 36 end;

(*СОСТАВЛЕНИЕ КРОССВОРДОВ*)
writeln; write('Составление: Пробное - 0, на ВЫВОД - 1 '); read(vy);
(*if vy=1 then begin writeln;
t(12); write('Кириллица в принтер ЗАГРУЖЕНА? Да - 0, Нет - 1 '); read(i);
                 t(7); if i=1 then exit end;*)
if vy=0 then begin otr:=0; osp:=0; goto 25 end;
(*t(12); write('К выводу с экрана готов? Да - 1, Нет - 0 '); t(7); read(i);*)
    writeln('Задаем трудность кроссворда: ЛЕГКИЙ ........ 1');
    writeln('                             ПОСЛОЖНЕЕ ..... 2');
    writeln('                             СРЕДНИЙ ....... 3');
    writeln('                             СЛОЖНЫЙ ....... 4');
    writeln('                             САМЫЙ СЛОЖНЫЙ . 5');
      write('                             СМЕШАННЫЙ ..... 0  '); read(otr);
  writeln('Задаем специализацию: ГУМАНИТАРНЫЙ ............. 1');
  writeln('                      ЕСТЕСТВЕННО-НАУЧНЫЙ ...... 2');
  writeln('                      ПОВСЕДНЕВНО-БЫТОВОЙ....... 3');
  writeln('                      ПОЛИТИКО-ЭКОНОМИЧЕСКИЙ ... 4');
    write('                             СМЕШАННЫЙ ......... 0  '); read(osp);

clrscr; t(14);
write('Селекция типа кроссворда - 0, тип известен - номер типа ');
                read(i); t(7);
        if i>0 then nt:=i;
        if i=0 then begin
        write('Среднее время составления меньше '); read(t0);
        if t0=0 then goto 10;
        write('Число слов в кроссворде от '); read(m1);
        write('                        до '); read(m2);
 write('Рассматриваем ВСЕ типы - 1, только НЕИСПОЛЬЗОВАННЫЕ - 0 '); read(qq);
        nst(1); reset(fot); p0:=filesize(fot);
        for nt:=1 to nn[2] do begin jj:=0;
                              if st[nt,1]=0 then goto 37;
         if round(st[nt,2]/st[nt,1])<t0 then wac(nt,n0) else goto 37;
          if msc[0,1]<m1 then goto 37; if msc[0,1]>m2 then goto 37;
          if qq=0 then for m:=1 to p0 do begin seek(fot,m-1); read(fot,ot);
                                         if ot.nt=nt then jj:=jj+ot.da end;
          if jj=0 then begin
t(15); write(nt:3,'    ',msc[0,1]:2,' ',round(st[nt,2]/st[nt,1]):4,'c  '); t(14);
          for m:=1 to p0 do begin seek(fot,m-1); read(fot,ot);
              if ot.nt=nt then begin write('.',ot.mo:2,'.',(ot.ye-1900):2);
                    if ot.cn>0 then write('* ') else write('  ') end end;
                      writeln end; t(7);
37:                           end; close(fot); writeln;
25:      write('Составляем кроссворд типа '); read(nt);
                   if nt=0 then goto 10 end;

                   nst(1); writeln; randomize;
write('Среднее время для кроссворда номер ',nt:3,' ');
    if st[nt,1]=0 then begin t(12); writeln('весьма велико') end
else begin t(10); write('около ',round(st[nt,2]/st[nt,1]):4,' сек');
                          writeln('   по ',st[nt,1]:3,' испытаниям') end;
    nfn(1); t(14); writeln('Всего составлено ',nn[22],' кроссвордов');
            t(7); write('Составляем - 1, Нет - 0 '); read(j);
            if j=0 then goto 25; for j:=1 to 255 do mns[j]:=0;
             npk:=nn[22]+1;
if ii=4 then begin
17:     gettime(h1,m1,s1,ss1); t1:=60*h1+m1+(s1+ss1/100)/60;
13:                wac(nt,n0);
        for pj:=1 to msc[0,1] do begin
        if keypressed then begin if ii=6 then goto 10 else goto 25 end;
                     j:=msq[pj]; sl:=ac[msc[j,1],msc[j,2]];
            for i:=1 to msc[j,5]-1 do
                 sl:=sl+ac[msc[j,1]+(2-msc[j,3])*i,msc[j,2]+(msc[j,3]-1)*i];
                                rc(1,msc[j,5]);
          n1:=1+random(nn[msc[j,5]]); n2:=nn[msc[j,5]]+n1-1;
11:       if n1<=nn[msc[j,5]] then n:=n1 else n:=n1-nn[msc[j,5]];
          fltr(aa); if aa=0 then goto 26;
                      sc:=zn.sl; slsc(msc[j,5],ee); if ee=0 then goto 12;
26:       inc(n1); if n1<=n2 then goto 11; goto 13;
12:       rc(2,msc[j,5]);
          for i:=0 to msc[j,5]-1 do
                ac[msc[j,1]+(2-msc[j,3])*i,msc[j,2]+(msc[j,3]-1)*i]:=sc[i+1];
                mns[j]:=n; if pj=msc[0,1] then t(15);
                if ii=4 then crd;
                 end;
                gettime(h2,m2,s2,ss2); t2:=60*h2+m2+(s2+ss2/100)/60;
                t0:=round(60*(t2-t1));
                write('t=',t0:3,' сек');
                for i:=1 to 3 do begin
                    sound(5000); delay(10000); nosound; delay(1500) end;
        if t2-t1>0 then begin
        st[nt,2]:=st[nt,2]+t0; inc(st[nt,1]);
        writeln(' ':30,'cр.время ',round(st[nt,2]/st[nt,1]):3); delay(50000);
                nst(2) end
     else begin t(143); writeln('Ошибка в вычислении времени'); t(7) end;
                if ii=6 then begin delay(10000); goto 18 end;
if vy=1 then begin write('На принтер - 1, НЕТ - 0 '); read(i);
                if i=1 then begin crpr(nt); nn[22]:=npk; nfn(2) end end;
                t(7); ii:=4; goto 25 end;

if ii=5 then begin
                   gettime(h1,m1,s1,ss1); t1:=60*h1+m1+(s1+ss1/100)/60;
             wac(nt,n0); jj:=1; for i:=1 to msc[0,1] do mns[i]:=0;
39:             crd; write('Вставляем слово номер '); read(nsl);
             for j:=1 to msc[0,1] do if msc[j,4]=nsl then goto 38;
38: if msc[j+1,4]=nsl then begin
       write('Горизонт. - 1, Вертик. - 2 '); read(gv);
       if gv=2 then inc(j) end else gv:=msc[j,3];
41:    if gv=1 then for x:=msc[j,1] to msc[j,1]+msc[j,5]-1 do
       if (ac[x,msc[j,2]-1]=' ') or (ac[x,msc[j,2]-1]='-') then
       if (ac[x,msc[j,2]+1]=' ') or (ac[x,msc[j,2]+1]='-') then
                                 ac[x,msc[j,2]]:='-';
       if gv=2 then for y:=msc[j,2] to msc[j,2]+msc[j,5]-1 do
                 if (ac[msc[j,1]-1,y]=' ') or (ac[msc[j,1]-1,y]='-') then
                 if (ac[msc[j,1]+1,y]=' ') or (ac[msc[j,1]+1,y]='-') then
                                 ac[msc[j,1],y]:='-';
                 sl:=ac[msc[j,1],msc[j,2]];
                     for i:=1 to msc[j,5]-1 do sl:=sl+ac[msc[j,1]+(2-gv)*i,msc[j,2]+(gv-1)*i];
    rc(1,msc[j,5]);
          n1:=1+random(nn[msc[j,5]]); n2:=nn[msc[j,5]]+n1-1;
42:       if n1<=nn[msc[j,5]] then n:=n1 else n:=n1-nn[msc[j,5]];
          fltr(aa); if aa=0 then goto 43;
                   sc:=zn.sl; slsc(msc[j,5],ee); if ee=0 then goto 40;
43:       inc(n1); if n1<=n2 then goto 42;
44:       rc(2,msc[j,5]);
t(15); writeln('СЛОВО НЕ ОБНАРУЖЕНО'); t(7);
readln; readln; goto 39;
40:          for i:=0 to msc[j,5]-1 do
                ac[msc[j,1]+(2-msc[j,3])*i,msc[j,2]+(msc[j,3]-1)*i]:=sc[i+1];
        crd; write('Слово годится - 1, Нет - 0 '); read(i);
             if i=0 then goto 41;
       if mns[j]=0 then inc(jj); mns[j]:=n; if jj<=msc[0,1] then goto 39;
                gettime(h2,m2,s2,ss2); t2:=60*h2+m2+(s2+ss2/100)/60;
                t0:=round(60*(t2-t1));
                crpr(nt); nn[22]:=npk; nfn(2); t(7); goto 10 end;
15:               end;
end.

