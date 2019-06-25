program SLOVGAME;
(*Программа для игры в слова и подсчета распределения букв*)
uses    Crt, Printer;
label   1,31,32,33,41,42;
type    s21=string[21]; s35=string[35];
        zna=record sl: s21;
                    mz: array[1..3] of word; (*номер строки в файле fz*)
                    sp: array[1..3] of byte; (*специальность значения*)
                    tr: array[1..3] of byte;  (*трудность значения*)
                    us: array[1..3] of word; (*номер последнего кроссворда*)
                     end;
var    n,nc,m1: longint;
       i,k,k1,kk,j,jj,m: byte;
       nn: array[1..22] of longint;
            (* длина файла номер K - nn[k] - кол-во слов длиной K
                                     nn[1] - число строк в файле fz
                                     nn[2] - число заданных типов кроссв-ов
                                     nn[3] - число строк в файле fps
                                     nn[22] - число сделанных кроссвордов *)
       sl,sc,ss,s0: s21;
       ss1: s35;
       al: array[0..32] of longint; (*Распределение по буквам*)
      al1: array[0..32] of real;
       zn: zna;
       f4,f5,f6,f7,f8,f9,f10,
         f11,f12,f13,f14,f15,f16,f17,f18,f19,f20,f21: file of zna;
       fn: text; (*slovar.nnn, slovar.sta*)

procedure t(i: byte);
begin  textcolor(i) end;

(* Запись/считывание длины файлов nn[k] *)
procedure nfn(i: byte);
begin if i=1 then reset(fn) else rewrite(fn);
      for k1:=1 to 22 do begin
               if i=1 then  readln(fn,nn[k1]);
               if i=2 then writeln(fn,nn[k1]:10) end;
      close(fn) end;

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


begin    assign(fn,'slovar.nnn');
   assign(f4,'slovar.4'); assign(f5,'slovar.5'); assign(f6,'slovar.6');
   assign(f7,'slovar.7'); assign(f8,'slovar.8'); assign(f9,'slovar.9');
   assign(f10,'slovar.10'); assign(f11,'slovar.11'); assign(f12,'slovar.12');
   assign(f13,'slovar.13'); assign(f14,'slovar.14'); assign(f15,'slovar.15');
   assign(f16,'slovar.16'); assign(f17,'slovar.17'); assign(f18,'slovar.18');
   assign(f19,'slovar.19'); assign(f20,'slovar.20'); assign(f21,'slovar.21');

1:    clrscr; writeln('Игра в слова ...................1');
              writeln('Распределение по буквам ........2');
              writeln; write('Выбран код................ '); read(kk);
                          nfn(1);


if kk=1 then begin t(15); writeln('ВКЛЮЧИ ПРИНТЕР '); t(7);
                   readln; readln;
33:           clrscr; readln; write('БАЗОВОЕ слово '); read(sl);
              if sl='' then goto 1;
  writeln(lst); writeln(lst); writeln(lst,'БАЗОВОЕ слово ',sl); writeln(lst);
                       for k:=4 to 21 do begin rc(1,k); jj:=0;
               for n:=1 to nn[k] do begin ss:=sl; rea(k,n,zn); sc:=zn.sl;
                          for i:=1 to length(sc) do begin
                                   for j:=1 to length(ss) do begin
                            if sc[i]=ss[j] then begin ss[j]:='0'; goto 31 end
                                                             end;
                                                    goto 32;
31:                                                 end;
                             write(lst,sc,' '); inc(jj);
                             if jj mod 8=0 then writeln(lst);
32:                          end;
             rc(2,k); if jj>0 then begin writeln(lst); writeln(lst) end end;
                  readln; readln; goto 33;
end;

if kk=2 then begin
          clrscr; for m:=0 to 32 do al[m]:=0;
          for k:=4 to 21 do begin rc(1,k);
               for n:=1 to nn[k] do begin rea(k,n,zn); sc:=zn.sl;
                          for i:=1 to length(sc) do begin
                              m1:=ord(sc[i]);
                              if (m1>159) and (m1<176) then m1:=m1-159;
                              if (m1>175) and (m1<240) then m1:=m1-207;
                              inc(al[m1]); inc(al[0]) end end;
                                 rc(2,k) end;
          for m:=1 to 32 do al1[m]:=al[m]/al[0];
          al[1]:=1;
          for m:=2 to 32 do begin
                   for k:=1 to m-1 do if al1[k]<al1[m] then goto 41;
                               al[m]:=m; goto 42;
41:           al1[0]:=al1[m];
          for i:=m-1 downto k do begin al1[i+1]:=al1[i]; al[i+1]:=al[i] end;
                              al1[k]:=al1[0]; al[k]:=m;
42:                          end;
          writeln('ЧАСТОТНЫЙ АНАЛИЗ АЛФАВИТА'); writeln;
          for i:=1 to 16 do begin
                         m:=al[i];
                         if m<17 then m:=m+159 else m:=m+207;
                         write(chr(m),'  ',al1[i]:8:6,' ':8);
                         m:=al[i+16];
                         if m<17 then m:=m+159 else m:=m+207;
                         writeln(chr(m),'  ',al1[i+16]:8:6);
                            end;
              nc:=0; for k:=4 to 21 do nc:=nc+nn[k];
              writeln;
              writeln('Число слов в словаре ',nc:11);
              writeln('Число букв           ',al[0]:11);
              writeln('Средняя длина слова  ',(al[0]/nc):4:2);
              writeln;
              write('На принтер - 1, нет - 0 '); read(k);
              if k=1 then begin t(15); writeln('ВКЛЮЧИ ПРИНТЕР '); t(7);
                                readln; readln; writeln(lst); writeln(lst);
          writeln(lst,'ЧАСТОТНЫЙ АНАЛИЗ АЛФАВИТА'); writeln(lst);
          for i:=1 to 16 do begin
                         m:=al[i];
                         if m<17 then m:=m+159 else m:=m+207;
                         write(lst,chr(m),'  ',al1[i]:8:6,' ':8);
                         m:=al[i+16];
                         if m<17 then m:=m+159 else m:=m+207;
                         writeln(lst,chr(m),'  ',al1[i+16]:8:6);
                            end;
              nc:=0; for k:=4 to 21 do nc:=nc+nn[k];
              writeln(lst);
              writeln(lst,'Число слов в словаре ',nc:11);
              writeln(lst,'Число букв           ',al[0]:11);
              writeln(lst,'Средняя длина слова  ',(al[0]/nc):4:2);
              writeln(lst) end;

goto 1 end;

end.


