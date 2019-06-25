(*
 * Программа расстановки авторов по призовым местам по скейтинг-системе
 * по итогам работы жюри. Любопытна пометка в коде программы:
 * «Число авторов >10 бессмысленно: невозможно расставить такое кол-во
 * по местам». Борис Натанович явно знал, почему на Грелке такие
 * бессмысленные итоги!
 *
 * http://lleo.me/dnevnik/2019/06/25.html
 *)
program SKATING;
uses    Crt, Printer;
const   max0=10; msx0=18; (* MAX число: авторов, судей *)
        (*Число авторов >10 бессмысленно: невозможно расставить такое кол-во
           по местам*)
type    st=string[10];
        mtr=record nap: st;     (*Название ПРЕМИИ*)
                   nan: st;     (*Название номинации*)
                   na,ns: byte; (*Число авторов, число судей*)
                   sa: array[1..max0] of st;      (*Список авторов*)
                bl,me: array[1..max0,1..msx0] of byte; (* Баллы и Места *)
            end;
label   1,2,3,4,5,6,7,8,9,10,11,12,15,16,17,18,19,21,22;
var     n,n1,m,j,jj,j0,j1,j2,b1,b2,nj,i,i0,ii,iii,
                          k,nk,nm0,ma0,np,ns,ms0,rr: byte;
        spa: array[1..max0] of st; (* Список авторов *)
        bl,me,bl0,pp: array[1..max0,1..msx0] of byte; (* Баллы и Места *)
        sbl: array[1..max0,1..2] of real; (* Средний балл и ошибка *)
        sme: array[1..max0,1..msx0] of byte; (* Распр. по местам *)
        na: array[1..max0] of byte; (* na[k,i] - No автора,
                                               занимающего i-е место *)
        sta: array[1..max0,1..msx0] of word; (*Статистика*)
        nap0: st;
        si,ni: word;
        nn,nn0,nfa: word; (*Число записей в файле SCATING.DAT*)
        mt: mtr; (*Запись матрицы баллов/мест очередной номинации*)
        su,su1: real;
        s: string[2];
       sp: st;
        f: file of mtr;

procedure t(k:byte);
begin textcolor(k) end;

procedure wf(nn: word);
begin reset(f); seek(f,nn-1); write(f,mt); close(f) end;

procedure rf(nn: word);
begin reset(f); seek(f,nn-1); read(f,mt); close(f) end;

procedure mst(i: byte);
begin case i of
1: write('  I ');  6: write(' VI ');
2: write(' II ');  7: write('VII ');
3: write(' III');  8: write('VIII');
4: write(' IV ');  9: write(' IX ');
5: write('  V '); 10: write('  X ');
end end;

procedure mstp(i: byte);
begin case i of
         1: write(lst,'  I ');  7: write(lst,'VII ');
         2: write(lst,' II ');  8: write(lst,'VIII');
         3: write(lst,' III');  9: write(lst,' IX ');
         4: write(lst,' IV '); 10: write(lst,'  X ');
         5: write(lst,'  V ');
         6: write(lst,' VI '); end end;

procedure vyv1;
begin   t(15); writeln('ОЦЕНКИ ЖЮРИ (',mt.ns,' судей)');
        t(13); writeln(' ':round(8+(3*mt.ns-5)/2),'БАЛЛЫ'); t(14);
              write(' ':11); for j:=1 to mt.ns do write(' ',j:2); writeln;
      for i:=1 to mt.na do begin t(14); write(mt.sa[i]:10,' '); t(15);
       for j:=1 to mt.ns do if mt.bl[i,j]>0 then write(' ',mt.bl[i,j]:2)
                                            else write(' ':3); writeln end;
writeln; t(10); write('Нажмите ENTER!'); readln; readln;
              t(13); writeln(' ':round(5+(4*mt.ns-5)/2),'МЕСТА'); t(14);
          write(' ':11); for j:=1 to mt.ns do write(' ',j:2,' '); writeln;
     for i:=1 to mt.na do begin t(14); write(mt.sa[i]:10,' '); t(15);
       for j:=1 to mt.ns do if mt.me[i,j]>0 then mst(mt.me[i,j])
                                     else write(' ':4); writeln end;
writeln; t(10); write('Нажмите ENTER!'); readln; readln;
                                      end;

procedure vyvp;
begin writeln(lst); writeln(lst,'ОЦЕНКИ ЖЮРИ (',mt.ns,' судей)');
      writeln(lst); writeln(lst,' ':round(8+(3*mt.ns-5)/2),'БАЛЛЫ');
   write(lst,' ':11); for j:=1 to mt.ns do write(lst,' ',j:2); writeln(lst);
      for i:=1 to mt.na do begin write(lst,mt.sa[i]:10,' ');
      for j:=1 to mt.ns do if mt.bl[i,j]>0 then write(lst,' ',mt.bl[i,j]:2)
                                    else write(lst,' ':3); writeln(lst) end;
       writeln(lst); writeln(lst,' ':round(5+(4*mt.ns-5)/2),'МЕСТА');
write(lst,' ':11); for j:=1 to mt.ns do write(lst,' ',j:2,' '); writeln(lst);
     for i:=1 to mt.na do begin write(lst,mt.sa[i]:10,' ');
       for j:=1 to mt.ns do if mt.me[i,j]>0 then mstp(mt.me[i,j])
                                else write(lst,' ':4); writeln(lst) end end;

procedure obr;
label     1,8,11,12,13,14;
begin for i:=1 to max0 do for k:=1 to msx0 do sme[i,k]:=0;
      for i:=1 to mt.na do begin b1:=mt.bl[i,1]; b2:=mt.bl[i,1];
                        su:=0; su1:=0; ns:=0;
                  for j:=1 to mt.ns do begin
                           if mt.bl[i,j]=0 then goto 1;
                  inc(ns); su:=su+mt.bl[i,j]; su1:=su1+mt.bl[i,j]*mt.bl[i,j];
1:                                      end;
             if ns<3 then begin t(12);
             writeln('ЧИСЛО ДЕЙСТВУЮЩИХ СУДЕЙ(',ns:1,')СЛИШКОМ МАЛО');
                                           t(7); readln; readln; exit end;
                    sbl[i,1]:=su/ns;
      sbl[i,2]:=sqrt((su1-ns*sbl[i,1]*sbl[i,1])/ns/(ns-1));
                                end;
                                na[1]:=1;
                                for n:=2 to mt.na do begin
                                 for k:=1 to n-1 do begin nk:=na[k];
                                   if sbl[n,1]>sbl[nk,1] then begin
                                      for i:=n-1 downto k do na[i+1]:=na[i];
                                                 na[k]:=n; goto 8 end;
                                                 na[n]:=n end;
8:                                                 end;
        for m:=1 to mt.na do for j:=1 to mt.ns do sme[m,j]:=0;
        for m:=1 to mt.na do for j:=1 to mt.ns do inc(sme[m,mt.me[m,j]]);

(* РАССТАНОВКА АВТОРОВ ПО ПОРЯДКУ *)
               k:=1;
13:            nk:=na[k];
               j:=k+1;
14:            nj:=na[j];
if sbl[nk,1]>sbl[nj,1] then
          if abs(sbl[nk,1]-sbl[nj,1])>sbl[nk,2]+sbl[nj,2] then goto 11;
                       for i:=1 to mt.na do begin
                                if sme[nk,i]>sme[nj,i] then goto 11;
                                if sme[nk,i]=sme[nj,i] then goto 12;
                                if sme[nk,i]<sme[nj,i] then begin
                                         na[k]:=nj; na[j]:=nk; goto 13 end;
12:                                      end;
if sbl[nk,1]<sbl[nj,1] then begin na[k]:=nj; na[j]:=nk; goto 13 end;
11:            inc(j); if j<=mt.na then goto 14;
               inc(k); if k<=mt.na-1 then goto 13 end;

procedure usl1;        (*Ввод названий и числа авторов/судей*)
begin readln; write('Название ПРЕМИИ (10 букв) '); read(mt.nap);
      readln; write('Название НОМИНАЦИИ (10 букв) '); read(mt.nan);
      writeln end;

procedure usl2;         (*Ввод списка авторов*)
begin
write('Число АВТОРОВ (<=',max0:2,') '); read(mt.na); writeln;
for i:=1 to mt.na do begin
    readln; t(14); write('Имя автора номер ',i:2,' (10 букв): '); t(15);
                   read(mt.sa[i]) end;
end;

procedure ub(j,i: byte);
begin t(14); write(mt.sa[i]:15);
      t(9); write('  Балл:  '); read(mt.bl[i,j]) end;

procedure um(j,i: byte);
begin t(14); write(mt.sa[i]:15);
      t(10); write('  Место:  '); read(mt.me[i,j]) end;

procedure usl3(j,i: byte);        (*Ввод матрицы баллы/места*)
begin
if mt.bl[i,j]=0 then ub(j,i) (* else write(mt.bl[i,j]:2)*);
if mt.me[i,j]=0 then um(j,i) (*else write(mt.me[i,j]:2)*); t(7); writeln end;

procedure spdt;         (*Вывод СПИСКА всех данных файла SKATING.dat*)
begin clrscr; t(15); writeln('СПИСОК ФАЙЛОВ');
                   nap0:=''; j:=0;
             for nn:=1 to nfa do begin rf(nn); write(nn:3,' ');
              if mt.nap<>nap0 then begin write(mt.nap:10); nap0:=mt.nap end
                              else write(' ':10);
                 writeln(' ',mt.nan:10); inc(j);
                 if j>20 then begin writeln; j:=0 end end; t(7);
end;

procedure vyv;
begin   t(15); write(' ':5,'ПРЕМИЯ: ');
        t(12); write(mt.nap);
        t(15); write('    НОМИНАЦИЯ: ');
        t(13); writeln(mt.nan); t(7); writeln end;

begin   clrscr; t(14); writeln('ПРОГРАММА SKATING ');
        t(15); writeln('Программа расчитана на:');
write('          максимальное число авторов -     '); t(10); writeln(max0:2);
t(15);
write('          максимальное число членов жюри - '); t(10); writeln(msx0:2);
t(12); write('Минимальное '); t(15); write('число членов жюри - ');
t(12); writeln('3'); writeln;
                assign(f,'skating.dat');
10:     t(14); writeln('МЕНЮ ');
        t(15); writeln('ВВОД данных ...............1');
               writeln('ИСПРАВЛЕНИЯ данных.........2');
                 write('ВЫВОД данных ..............3 '); read(ii);
        reset(f); nfa:=filesize(f); close(f);

if ii=1 then begin writeln; spdt;
t(15); writeln; write(' Работаем с файлом номер '); read(nn);
                    if nn=0 then goto 10;
                    if nn>nfa then begin nfa:=nn; goto 12; end;
                    rf(nn);
12: t(14); write('НОВЫЙ ФАЙЛ: ПРЕМИЯ/ЖАНР/АВТОРЫ - 1, НЕТ - 0 '); read(iii);
if iii=1 then begin clrscr; usl1; writeln;
                    usl2; writeln;
for i:=1 to max0 do for j:=1 to msx0 do begin mt.bl[i,j]:=0; mt.me[i,j]:=0 end;
                    mt.ns:=0; wf(nn) end;
writeln; t(14); write('ВВОД матрицы: БАЛЛЫ/МЕСТА - 2, НЕТ - 0 '); read(iii);
         if iii=0 then goto 10;
9:      clrscr; vyv;
        writeln; j:=mt.ns+1;
        write('Судья номер ',j:2);
        t(15); write('   Вводим - 1, НЕТ - 0 '); read(iii);
               if iii=0 then goto 3; i:=1;
5:      usl3(j,i); writeln; n1:=0;
              for k:=1 to i-1 do if mt.me[k,j]=mt.me[i,j] then begin inc(n1);
                                                mt.me[i,j]:=0; mt.bl[i,j]:=0;
                      t(12); writeln('ОШИБКА!!! ПОВТОР НОМЕРА МЕСТА!!!') end;
          if n1>0 then goto 5; inc(i); if i<=mt.na then goto 5;
          mt.ns:=j; wf(nn);
          goto 9;
3:     clrscr; goto 10 end;

if ii=2 then begin
1:            spdt;
writeln; write('Исправление ФАЙЛА '); read(nn);
              if nn=0 then goto 10;
              clrscr; rf(nn); vyv1; writeln;
     write('Исправляем: НАЗВАНИЯ/ЖЮРИ - 1; АВТОРОВ - 2; БАЛЛЫ/МЕСТА - 3 ');
     write('Нет - 0 '); read(jj);
     if jj=0 then goto 1;
     if jj=1 then usl1;
     if jj=2 then usl2;
21:     if jj=3 then begin write('Изменяем автора номер '); read(i0);
                           if i0=0 then goto 22;
                        write('         судью номер  '); read(j0);
                        ub(j0,i0); um(j0,i0); goto 21 end;
22:  wf(nn);
     goto 1 end;

if ii=3 then begin spdt;
writeln; write('Выводим ФАЙЛ номер '); read(nn); rf(nn); obr; clrscr; vyv;
        vyv1;
        t(15); writeln('РЕЙТИНГ'); t(10);
writeln('средний балл; ср.кв.ошибка среднего; число 1-х,2-х и т.д. мест');
       t(14); write(' ':19); for k:=1 to mt.na do mst(k); writeln;
                       for m:=1 to mt.na do begin nk:=na[m];
                t(14); write(mt.sa[nk]:10,' ');
                t(15); write(sbl[nk,1]:10:8,' ',sbl[nk,2]:7:5); t(10);
                       for k:=1 to mt.na do write(' ',sme[nk,k]:2,' ');
                                          writeln end;
             writeln; t(13); write('Нажмите ENTER!'); readln; readln;
                      write('На принтер - 1, МЕНЮ - 0 '); read(i);
                                  if i=0 then begin clrscr; goto 10 end;
writeln(lst); writeln(lst);
write(lst,' ':5,'ПРЕМИЯ: '); write(lst,mt.nap);
write(lst,'    НОМИНАЦИЯ: '); writeln(lst,mt.nan);
                           writeln(lst); vyvp; writeln(lst); writeln(lst);
writeln(lst,'РЕЙТИНГ');
writeln(lst,'(средний балл; ср.кв.ошибка среднего; число 1-х,2-х и т.д. мест)');
writeln(lst);
       write(lst,' ':20); for k:=1 to mt.na do mstp(k); writeln(lst);
                       for m:=1 to mt.na do begin nk:=na[m];
                write(lst,mt.sa[nk]:10,' ',sbl[nk,1]:5:3,' ',sbl[nk,2]:5:3);
              for k:=1 to mt.na do write(lst,' ',sme[nk,k]:2,' ');
                                 writeln(lst) end;
                                  writeln(lst); clrscr;  goto 10 end;
end.
