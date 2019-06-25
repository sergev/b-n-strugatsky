program CROSWORD;
(*Программа для работы с кроссвордами*)
{$L-}
uses    Crossost, Crt, Printer, Graph, Dos;
const   np=10; (*Число строк в таблице специальностей*)
label   1,2,3,4,5,6,7,  15,16,17,18,19,  20,21,22,23,24,25,26,27,
        43,44,45,46,47,48,49,50,51,52,53,54,55,56, 66,65,  72;
type    s21=string[21]; s39=string[39]; s35=string[35]; s75=string[75];
        tic=record n0: byte; (*Полудлина строки <=20*)
                   aa: array[1..20,1..20] of char end;
        zna=record sl: s21;
                    mz: array[1..3] of word; (*номер строки в файле fz*)
                    sp: array[1..3] of byte; (*специальность значения*)
                    tr: array[1..3] of byte;  (*трудность значения*)
                    us: array[1..3] of word; (*номер последнего кроссворда*)
                     end;
var    n,nc,ns,nt,n1,n2,m1,m2,l,nfz,nps,npk: longint;
       ye,mo,da,dw: word;
       i,i1,k,k1,ii,kk,j,jj,jjj,ee,x,y,n0,m,m0,p,otr,osp: byte;
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
(*       st: array[1..100,1..2] of longint;*)

(*st - Статистика для каждого типа кроссвордов: число и ср.время в секундах*)
       ac: array[0..40,0..40] of char;

      al1: array[0..32] of real;
   tc,tc0: tic;
       zn: zna;
       f4,f5,f6,f7,f8,f9,f10,
         f11,f12,f13,f14,f15,f16,f17,f18,f19,f20,f21: file of zna;
      ftc: file of tic; (*Файл типов кроссвордов - cross.tip*)
       fn,fst: text; (*slovar.nnn, slovar.sta*)
       fp: file of s35; (*Файл-список специальностей - slovar.spz*)
       fz: file of s75; (*Файл строк значений - slovar.zna*)
       fps: file of longint; (*"пустые" номера - slovarzn.pst*)

procedure t(i: byte);
begin  textcolor(i) end;

(* Запись/считывание длины файлов nn[k] *)
procedure nfn(i: byte);
begin if i=1 then reset(fn) else rewrite(fn);
      for k1:=1 to 22 do begin
               if i=1 then  readln(fn,nn[k1]);
               if i=2 then writeln(fn,nn[k1]:10) end;
      close(fn) end;

(*Запись/чтение файла статистики скорости составления кроссвордов*)

procedure nst(i: byte);
begin if i=2 then rewrite(fst) else reset(fst);
if i=1 then begin for n:=1 to nn[2] do readln(fst,st[n,1],st[n,2]) end;
if i=2 then begin for n:=1 to nn[2] do writeln(fst,st[n,1]:3,st[n,2]:5) end;
      close(fst) end;

procedure rc(i,k: byte);
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

(* Считывание  n-й позиции файла fK *)
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

procedure wri(k: byte; n: longint);
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


(*Удаление пустот в файле fzK*)
procedure udl;
begin writeln; writeln('Удаление пустот ');
      nc:=0; for n:=1 to nn[k] do begin rea(k,n,zn);
                      if zn.sl<>'' then begin inc(nc); wri(k,nc) end end;
                          nn[k]:=nc; nfn(2) end;

procedure vysp;
begin t(14);
      for p:=1 to np do begin reset(fp);
      seek(fp,p-1); read(fp,ss1); write(ss1:35,'  ',p:2);
      seek(fp,np+p-1); read(fp,ss1); close(fp);
      writeln(' ',ss1:35,'  ',(np+p):2) end; writeln; t(7) end;

(*Вывод всех сведений о слове*)
procedure vysl(k: byte; n: longint);
label     49;
begin for m:=1 to 3 do begin if zn.tr[m]=0 then goto 49; t(15);
                   reset(fz); seek(fz,zn.mz[m]-1); read(fz,sz); close(fz);
                           writeln(m:1,'. ',sz);
writeln('   ',zn.tr[m]:1,' ',zn.sp[m]:2,' ',zn.us[m]:3,'   ',zn.mz[m]) end;
49:         end;

(* Ввод значений и специализаций *)
procedure vvzs(k: byte; n: longint);
label     2;
begin   for m:=1 to 3 do begin if zn.mz[m]=0 then begin
    writeln; readln; writeln('Значение номер ',m:1,' '); read(sz);
                                       if sz='' then goto 2;
        if nn[3]>0 then begin reset(fps); seek(fps,nn[3]-1); read(fps,nfz);
                              dec(nn[3]); close(fps) end;
        if nn[3]=0 then begin inc(nn[1]); nfz:=nn[1] end;
                        zn.mz[m]:=nfz; nfn(2);
       reset(fz); seek(fz,nfz-1); write(fz,sz); close(fz);
                              zn.us[m]:=0;
                     writeln('Трудность (1-->3) '); read(zn.tr[m]);
                             vysp;
         write('Специальность номер '); read(zn.sp[m]); wri(k,n) end;
                        end; t(7);
2:          rc(2,k) end;

procedure vvod(sl: s21);
label     21,22,23,51;
begin  k:=length(sl); rc(1,k); n:=1;
23:          rea(k,n,zn); sc:=zn.sl;
if sc[1]<>sl[1] then goto 51;
             if sc=sl then begin t(12); writeln('Слово уже есть в словаре ');
                                 rc(2,k); goto 21 end;
             if sc>sl then begin writeln('ИДЕТ ПЕРЕФОРМИРОВКА');
                                 sound(300); delay(200); nosound;
             for l:=nn[k] downto n do begin rea(k,l,zn); wri(k,l+1) end;
 zn.sl:=sl; for m:=1 to 3 do begin zn.mz[m]:=0; zn.tr[m]:=0;
                                   zn.sp[m]:=0; zn.us[m]:=0 end;
                           wri(k,n); inc(nn[k]); goto 22 end;
51:            inc(n); if n<=nn[k] then goto 23;
 zn.sl:=sl; for m:=1 to 3 do begin zn.mz[m]:=0; zn.tr[m]:=0;
                                   zn.sp[m]:=0; zn.us[m]:=0 end;
                           inc(nn[k]); wri(k,nn[k]);
22:   nfn(2); rc(2,k);
21:   end;

(*Вывод ЗНАЧЕНИЙ слова SL и его номера n в SLOVO.K*)
procedure znac(sl:s21);
label     1,46;

begin k:=length(sl); rc(1,k);
      for n:=1 to nn[k] do begin rea(k,n,zn);
                           if zn.sl=sl then goto 46 end;
                              vvod(sl); rc(1,k);
46:                           vysl(k,n);
     if m=1 then begin t(14); writeln('Значение еще не введено'); t(7) end;
1:   end;


begin assign(ftc,'cross.tip');
      assign(fn,'slovar.nnn'); assign(fst,'slovar.sta');
   assign(f4,'slovar.4'); assign(f5,'slovar.5'); assign(f6,'slovar.6');
   assign(f7,'slovar.7'); assign(f8,'slovar.8'); assign(f9,'slovar.9');
   assign(f10,'slovar.10'); assign(f11,'slovar.11'); assign(f12,'slovar.12');
   assign(f13,'slovar.13'); assign(f14,'slovar.14'); assign(f15,'slovar.15');
   assign(f16,'slovar.16'); assign(f17,'slovar.17'); assign(f18,'slovar.18');
   assign(f19,'slovar.19'); assign(f20,'slovar.20'); assign(f21,'slovar.21');
assign(fp,'slovar.spz'); assign(fz,'slovar.zna'); assign(fps,'slovarzn.pst');
getdate(ye,mo,da,dw);
1:    clrscr; writeln('Статистика .................... 0');
              writeln('РЕДАКТИРОВАНИЕ словаря......... 1');
              writeln('РЕШЕНИЕ КРОССВОРДОВ.............3');
              writeln('СОСТАВЛЕНИЕ КРОССВОРДОВ ........5');
              writeln('ЗНАЧЕНИЯ СЛОВ  ................ 7');
              writeln('Дополнительные вводы/выводы.... 8');
              writeln; write('Выбран код................ '); read(kk);
                          nfn(1);
if kk=8 then begin
(*clrscr;
writeln('Проверка типов кроссвордов на повторяемость ');
reset(ftc); n1:=filesize(ftc)-1; jjj:=0;
for nt0:=1 to n1 do begin seek(ftc,nt0-1); read(ftc,tc);
                          tc0.n0:=tc.n0;
        for x:=1 to tc0.n0 do for y:=1 to tc0.n0 do tc0.aa[x,y]:=tc.aa[x,y];
        jj:=0; m0:=0;
               for m:=nt0+1 to n1 do begin seek(ftc,m-1); read(ftc,tc);
                                           if tc.n0<>tc0.n0 then goto 6;
      for y:=1 to tc.n0 do for x:=1 to tc.n0 do if tc.aa[x,y]<>tc0.aa[x,y]
                                          then goto 6;
             inc(jjj); inc(jj); inc(m0);
             if m0=1 then write(nt0:3,' '); t(12); write(' ',m:3); t(7);
6:                                   end;
                          if jj>0 then writeln end;
                          close(ftc);
if jjj=0 then begin t(14); writeln('Повторяющихся типов НЕТ ');
                    readln; readln; t(7); goto 1 end;
writeln; write('На принтер - 1 '); read(i);
if i=1 then begin
writeln(lst,'Повторяющиеся кроссворды ');
reset(ftc); n1:=filesize(ftc)-1;
for nt0:=1 to n1 do begin seek(ftc,nt0-1); read(ftc,tc);
                          tc0.n0:=tc.n0;
        for x:=1 to tc0.n0 do for y:=1 to tc0.n0 do tc0.aa[x,y]:=tc.aa[x,y];
        jj:=0; m0:=0;
               for m:=nt0+1 to n1 do begin seek(ftc,m-1); read(ftc,tc);
                                           if tc.n0<>tc0.n0 then goto 7;
      for y:=1 to tc.n0 do for x:=1 to tc.n0 do if tc.aa[x,y]<>tc0.aa[x,y]
                                          then goto 7;
             inc(jj); inc(m0);
      if m0=1 then write(lst,nt0:3,'  '); t(12); write(lst,' ',m:3); t(7);
7:                                   end;
                          if jj>0 then writeln(lst) end; close(ftc);
            end;*)
(* Разборка специализации "0" по другим специализациям
for k:=4 to 21 do begin rc(1,k);
    for n:=1 to nn[k] do begin rea(k,n,zn); jj:=0;
                         if zn.mz[1]=0 then goto 2; clrscr;
             for m:=1 to 3 do begin if zn.tr[m]=0 then goto 3;
                      if zn.sp[m]=0 then begin inc(jj); write(' ',zn.sl);
                   reset(fz); seek(fz,zn.mz[m]-1); read(fz,sz); close(fz);
                   t(15); write(zn.sl); t(12); writeln(zn.sp[m]:2); t(7);
                    writeln(m:1,'. ',sz) end end;
3: if jj>0 then begin writeln; vysp;
write('Вводим новую специализацию (не 0) в позицию '); read(m0);
                if m0=0 then begin rc(2,k); goto 1 end;
                write('Новая специализация ',m0:1,' '); read(zn.sp[m0]);
                wri(k,n);
4:                end;
2:                             end;
          rc(2,k) end; *)

(*Проверка СЛОВ, для которых zn.mz[m]>nn[1]
for k:=4 to 21 do begin rc(1,k);
    for n:=1 to nn[k] do begin rea(k,n,zn);
                         if zn.mz[1]=0 then goto 72;
             for m:=1 to 3 do begin if zn.tr[m]=0 then goto 72;
   if zn.mz[m]>nn[1] then begin write(lst,'   ',zn.sl:k,' ',zn.mz[m]:4);
                          zn.mz[m]:=0; zn.sp[m]:=0; zn.tr[m]:=0; wri(k,n)
                          end end;
72:                       end;
          rc(2,k) end; *)
goto 1 end;

if kk=0 then begin
27:     clrscr; nc:=0; ns:=0;
        for m:=0 to 2*np do for k:=1 to 3 do sptr[m,k]:=0;
for k:=4 to 21 do begin rc(1,k); nm[k]:=0;
            for n:=1 to nn[k] do begin rea(k,n,zn);
                                         if zn.mz[1]<>0 then inc(nm[k]);
     for m:=1 to 3 do if zn.mz[m]<>0 then inc(sptr[zn.sp[m],zn.tr[m]]) end;
   writeln(k:2,'    ',nn[k]:11,'  ',nm[k]:11); nc:=nc+nn[k]; ns:=ns+nm[k];
                                             rc(2,k) end;
                        writeln('Итого ',nc:11,'  ',ns:11);
                        readln; readln;
clrscr; writeln('Распределение по коэффициентам трудности ');
                        writeln;
reset(fp);
for p:=1 to 2*np do begin seek(fp,p-1); read(fp,ss1);
            if ss1<>'*' then begin nc:=0; for m:=1 to 3 do nc:=nc+sptr[p,m];
 t(14); write(ss1:35); t(15); for m:=1 to 3 do write(' ',sptr[p,m]:5);
                                        t(14); writeln('   ',nc:5) end end;
for m:=1 to 3 do begin nc:=0;
  for p:=1 to 2*np do begin seek(fp,p-1); read(fp,ss1);
                      if ss1<>'*' then nc:=nc+sptr[p,m] end;
                       if m=1 then write(' ':35);
                       write(' ',nc:5) end;
                                       t(7); writeln; close(fp);
                        readln; readln; goto 1 end;


53: if kk=7 then begin writeln;
                    t(15); writeln('ВЫХОД В ГЛАВНОЕ МЕНЮ...........0'); t(7);
                           writeln('АВТОМАТИЧЕСКИЙ ввод значений...1');
                           writeln('Ввод значений ВРУЧНУЮ..........2');
                           writeln('ИСПРАВЛЕНИЯ ЗНАЧЕНИЙ...........3');
                           writeln('ИСПРАВЛЕНИЕ списка спец-тей....4');
                           writeln('Вывод значений ПО НОМЕРУ.......5');
                           writeln('Вывод значений ПО СЛОВУ........6');
                           writeln('Вывод значений напрямую........7');
(*                           writeln('Создание списка "пустот".......8');*)
                           writeln; write('Выбран код.............. ');
                           read(ii); if ii=0 then goto 1;

(* if ii=8 then begin writeln;
writeln('Создается файл номеров "пустот" в списке ЗНАЧЕНИЙ');
reset(fps); nps:=0;
      for nfz:=1 to nn[1] do begin write(' ',nfz:4);
                for k:=4 to 21 do begin rc(1,k);
                    for n:=1 to nn[k] do begin rea(k,n,zn);
       for m:=1 to 3 do begin if zn.mz[m]=0 then goto 66;
                if zn.mz[m]=nfz then begin rc(2,k); goto 65 end end;
66:                                end; rc(2,k) end;
             inc(nps); seek(fps,nps-1); write(fps,nfz);
65:                          end; close(fps); nn[3]:=nps; nfn(2);
writeln;
write('Выводим список "пустых" номеров на печать - 1, нет - 0 '); read(i);
               if i=1 then begin t(143); writeln('ВКЛЮЧИ ПРИНТЕР!!!!!!!');
                       readln; readln; t(7); reset(fps);
             writeln(lst); writeln(lst,'"Пустые" номера в списке ЗНАЧЕНИЙ');
                      for n:=1 to nn[3] do begin seek(fps,n-1);
                                  read(fps,nfz); write(lst,' ',nfz:4);
                                           end; close(fps) end;
goto 1 end;
*)

56: if ii=7 then begin reset(fz); nfz:=filesize(fz); close(fz);
       clrscr; writeln('Число записей ',nn[1],'  Длина файла ',nfz);
                write('Выводим из файла значений номера от '); read(n1);
                 if n1=0 then goto 53;
                write('                                 до '); read(n2);
                reset(fz);
                for n:=n1 to n2 do begin seek(fz,n-1); read(fz,sz);
                                      writeln(n:4,' ',sz) end; close(fz);
write('На принтер - 1, нет - 0 '); read(i);
if i=1 then begin reset(fz);
                for n:=n1 to n2 do begin seek(fz,n-1); read(fz,sz);
                      writeln(lst,n:4,' ',sz) end; close(fz) end;
                             goto 56 end;


44:  if ii=1 then begin write('Вводим ЗНАЧЕНИЯ слов с числом букв ');
                        read(k); if k=0 then goto 53;
                 readln; write('Начинаем с 4-х букв '); read(s0);
                 for i:=5 to k do s0:=s0+'а';
                        rc(1,k);
                        for n:=1 to nn[k] do begin rea(k,n,zn);
                        if s0<=zn.sl then begin n1:=n; break end end;
                        for n:=n1 to nn[k] do begin rea(k,n,zn);
                        clrscr;
if zn.mz[1]=0 then begin t(14); writeln(zn.sl); t(7); vvzs(k,n); rc(1,k) end
                                          else goto 47;
                            write('Продолжаем - 1, нет - 0 '); read(i);
                            if i=0 then begin rc(2,k); goto 44 end;
47:                             end; goto 44 end;

45:  readln; if ii=2 then begin write('Вводим ЗНАЧЕНИЕ слова '); t(14);
                          read(sl);
                          if sl='' then goto 53;
                          znac(sl); vvzs(k,n);
                          goto 45 end;

48: if ii=3 then begin readln; write('Исправляем ЗНАЧЕНИЕ слова '); t(14);
                       read(sl); t(7); if sl='' then goto 53;
                          znac(sl);
                          if (zn.mz[1]+zn.mz[2]+zn.mz[3])<>0 then goto 49;
                          if m=1 then begin writeln; goto 48 end;
49:                t(7); writeln;
                   write('Изменяем значение номер '); read(m0);
                   if m0=0 then goto 48;
t(15); writeln('Изменяем: значение........... 1');
       writeln('          трудность.......... 2');
       writeln('          специальность...... 3');
         write('Номер последнего кроссворда.. 4 '); read(jj); t(7);
if jj=1 then begin
   writeln; readln; writeln('Значение номер ',m0:1,' '); t(15); read(sz);
              reset(fz); seek(fz,zn.mz[m0]-1); write(fz,sz); close(fz);
              if sz='' then begin zn.mz[m0]:=0; zn.tr[m0]:=0; zn.us[m0]:=0;
                                  zn.sp[m0]:=0 end end;
if jj=2 then begin write('Трудность (1-->3) '); read(zn.tr[m0]) end;
if jj=4 then begin write('Номер последнего кроссворда ');
                   read(zn.us[m0]) end;
if jj=3 then begin vysp; write('Специальность номер '); read(zn.sp[m0]) end;
        wri(k,n); rc(2,k); goto 48 end;

50: if ii=4 then begin clrscr; vysp;
                             write('Исправляем строку номер '); read(m);
                             if m=0 then goto 53;
                             reset(fp);
                             readln; write('Новая сециальность '); read(ss1);
                        seek(fp,m-1); write(fp,ss1); close(fp); goto 50 end;

54: if ii=5 then begin
      clrscr; writeln('Файл значений насчитывает ',nn[1],' позиций');
      write('Выводим позицию номер '); t(14); read(nfz); t(7);
      if nfz=0 then goto 53;
            reset(fz); seek(fz,nfz-1); read(fz,sz); close(fz);
      for k:=4 to 21 do begin rc(1,k);
                                for n:=1 to nn[k] do begin rea(k,n,zn);
       for m:=1 to 3 do if zn.mz[m]=nfz then begin rc(2,k); goto 52 end
                                             end; rc(2,k) end;
    t(12); writeln('Данный номер не соответствует какому-либо слову'); t(7);
                       readln; readln; goto 54;
52:  writeln; writeln(zn.sl,' - ',sz); readln; readln; goto 54
end;

55: if ii=6 then begin clrscr; readln;
                       write('Выводим ЗНАЧЕНИЕ слова '); t(14); read(sl);
                          t(7); if sl='' then goto 53;
                          znac(sl); readln; readln; goto 55
                 end;
end;


if kk=1 then begin
16:  clrscr; write('Редактируем к-буквенный (к=>4) словарь; к=');
             read(k); if k=0 then goto 1; rc(1,k);
             writeln('Всего в словаре ',nn[k]:10,' слов'); writeln;
             if nn[k]<20 then begin s0:='а'; goto 43 end;
    readln; write('Начинаем с 4-х букв '); read(s0);
                 for i:=5 to k do s0:=s0+'а';
43:    for n:=1 to nn[k] do begin  rea(k,n,zn); sc:=zn.sl;
          if s0<sc then begin n1:=n; n2:=n1+20; goto 17 end end;
    n1:=1; n2:=20;

17: if nn[k]<20 then n2:=nn[k]; rc(1,k); i:=0;
    clrscr; if n2>nn[k] then n2:=nn[k];
    for n:=n1 to n2 do begin inc(i); rea(k,n,zn); sc:=zn.sl;
         if zn.mz[1]=0 then t(14); writeln(i:2,' ',sc:k); t(7) end; writeln;
write('Заменяем СЛОВО - 1, Продолж. - 2, Кончаем - 0 ');
                    read(j); if j=0 then begin udl; goto 16; rc(2,k) end;
        if j=2 then begin n1:=n2+1; n2:=n2+20;
               if n1>nn[k] then begin udl; goto 16; rc(2,k) end end;
       if j=1 then begin t(15); write('Заменяем слово номер '); read(i1);
                    rea(k,i1,zn);
                    readln; write('Новое слово '); t(12); read(zn.sl); t(7);
                        for m:=1 to 3 do begin zn.mz[m]:=0; zn.tr[m]:=0;
                                               zn.sp[m]:=0; zn.us[m]:=0 end;
                    wri(k,n1+i1-1); n1:=n1+i1-1; n2:=n2+i1-1; end;
               if n2>nn[k] then n2:=nn[k]; goto 17;
end;


if kk=3 then begin
18:   clrscr; readln;
write('ВВОДИМ ИСКОМОЕ СЛОВО (неизвестные буквы - тире) ');
                      read(sl); if sl='' then goto 1;
                      writeln; m1:=0; m2:=0;
                      k:=length(sl); rc(1,k); j:=0;
                      for i:=1 to k do if sl[i]<>'-' then inc(j); jj:=j;
                      for n:=1 to nn[k] do begin rea(k,n,zn); sc:=zn.sl;
                      j:=0;
                      for i:=1 to k do if sl[i]=sc[i] then inc(j);
                      if j=jj then begin writeln(sc:k); inc(m1); inc(m2);
                       if m2>20 then begin readln; readln; m2:=0 end end end;
                      if m1=0 then writeln('Слово не найдено');
                      for i:=1 to 20 do write('-');
                      readln; readln; rc(2,k);
                      if m1=0 then goto 18;
19:  readln; t(13); writeln; write('Проверяем значение слова ');
             t(14); read(sl);
if sl='' then goto 18;
znac(sl); writeln;
t(13); write('СНОВА проверяем значение слова - 1');
t(15); write(', НОВЫЙ ввод искомого слова - 0 '); read(i);
if i=1 then goto 19 else goto 18;
                      end;

if kk=5 then begin cr;  goto 1 end;
end.

