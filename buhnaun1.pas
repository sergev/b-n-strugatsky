(*
 * Похоже, программа ведения финансовых расходов/приходов.
 * Интересны финансовые статьи Бориса Стругацкого:
 * «Домхозяйство», «Филателия», «Авто», «Книги», «Подарки»,
 * «PC/TV/VM», «Отпуcк,сад,ремонт», «Медицина», «Налоги»,
 * «Гонорар», «Филателия», «Дивиденды», «Пенсия»...
 *
 * http://lleo.me/dnevnik/2019/06/25.html
 *)
unit    BUHNAUN1;
interface
uses      Crt, Printer;
type     tr=record da,mo,ye,st,stn,ad: byte;
                   dk: word;
                   pri: string[20];
                   su,sb,sn,sd: real end;
         tm=record ye,mo: byte; su: real end;
var      i,k,kk,jj,ii,da,mo,ye,st,stn,ad,mo0,ye0,mo1,mo2,ye1,va: byte;
         d1,d2,d3,d4,nn,n0,nn0,n,nk,dk,m: word;
         ku,su1,su2,su,sb,sn,sd,xi,xa,yi,ya,xs,ys: real;
         fuc: array[1..240] of real;
         ss: string[5];
         w1: string[3];
         w: string[6];
        pri: string[20];
        smo: tm;
         rr,rd,re: tr;
         fr,fd,fe: file of tr;
         fsm: file of tm;

procedure fn(jj: byte);
procedure rf(jj: byte; n: word); {чтение файлов}
procedure wf(jj: byte; n: word); {запись файлов}
procedure pre(jj: byte);         {преобразование данных в файл rr.da:=da...}
procedure erp(jj: byte);         {преобразование файлов в данные da:=rr.da...}
procedure vvd(n: word);          {ввод ДАТЫ}
{procedure rmo;}                   (*расходы по месяцам*)
procedure vvo(jj:byte; n: word); (*ввод данных*)
procedure pro(jj,st: byte);  {Результат вида действия - расх, дох, перенос....}
procedure tab(ii: byte; var stn: byte); {определение статьи дохода/расх}
procedure vyv(jj:byte; n: word);
procedure kd1(k: byte);
procedure kd2(k: byte);
procedure kd3(k: byte);

implementation

procedure t(k: byte);
begin textcolor(k) end;

procedure fn(jj:byte);
begin
     if jj=1 then begin reset(fr); nn:=filesize(fr); close(fr) end;
     if jj=2 then begin reset(fd); nn:=filesize(fd); close(fd) end;
     if jj=3 then begin reset(fe); nn:=filesize(fe); close(fe) end;
end;

procedure rf(jj:byte; n:word);
begin
     if jj=1 then begin reset(fr); seek(fr,n-1); read(fr,rr); close(fr) end;
     if jj=2 then begin reset(fd); seek(fd,n-1); read(fd,rd); close(fd) end;
     if jj=3 then begin reset(fe); seek(fe,n-1); read(fe,re); close(fe) end;
     end;

procedure wf(jj:byte; n:word);
begin
     if jj=1 then begin reset(fr); seek(fr,n-1); write(fr,rr); close(fr) end;
     if jj=2 then begin reset(fd); seek(fd,n-1); write(fd,rd); close(fd) end;
     if jj=3 then begin reset(fe); seek(fe,n-1); write(fe,re); close(fe) end;
end;

procedure pre(jj:byte);
begin
     if jj=1 then begin rr.da:=da; rr.mo:=mo; rr.ye:=ye;
                        rr.st:=st; rr.stn:=stn; rr.ad:=ad;
                        rr.dk:=dk; rr.pri:=pri; rr.su:=su end;
     if jj=2 then begin rd.da:=da; rd.mo:=mo; rd.ye:=ye;
                        rd.st:=st; rd.stn:=stn; rd.ad:=ad;
                        rd.dk:=dk; rd.pri:=pri; rd.su:=su end;
     if jj=3 then begin re.da:=da; re.mo:=mo; re.ye:=ye;
                        re.st:=st; re.stn:=stn; re.ad:=ad;
                        re.dk:=dk; re.pri:=pri; re.su:=su end
end;

procedure erp(jj:byte);
begin
     if jj=1 then begin da:=rr.da; mo:=rr.mo; ye:=rr.ye;
                        st:=rr.st; stn:=rr.stn; ad:=rr.ad;
                        dk:=rr.dk; pri:=rr.pri; su:=rr.su end;
     if jj=2 then begin da:=rd.da; mo:=rd.mo; ye:=rd.ye;
                        st:=rd.st; stn:=rd.stn; ad:=rd.ad;
                        dk:=rd.dk; pri:=rd.pri; su:=rd.su end;
     if jj=3 then begin da:=re.da; mo:=re.mo; ye:=re.ye;
                        st:=re.st; stn:=re.stn; ad:=re.ad;
                        dk:=re.dk; pri:=re.pri; su:=re.su end
end;

procedure vvd(n:word);
label 1;
begin
    write(n:4,' Дата:   день '); read(da);
    if da=0 then begin writeln; goto 1 end;
    write(' ':4,'        месяц '); read(mo);
    write(' ':4,'        год 20'); read(ye);
1:     end;

procedure tab(ii:byte; var stn: byte);
begin  if ii=1 then begin
                  writeln('Домхоз-во........1    Филателия......2');
                  writeln('Авто.............3    Книги..........4');
                  writeln('Подарки..........5    PC/TV/VM.......6');
                  writeln('Отпск,сад,ремонт.7    Медицина.......8');
                  writeln('Налоги...........9    Прочее........10') end;
       if ii=2 then begin
                  writeln('Гонорар......1');
                  writeln('Филателия....2');
                  writeln('Авто.........3');
                  {writeln('Дивиденды....4');}
                  writeln('Пенсия и пр..5') end;
                  writeln; write('Выбран код.........  '); read(stn);
end;

procedure pro(jj,st:byte);
label 1,2,10;
begin
     case st of
         1: begin
         if jj=1 then begin if stn=1 then rr.sd:=rr.sd+su;
                            if ad=1 then rr.sb:=rr.sb-su;
                            if ad=2 then rr.sn:=rr.sn-su;
                            if ad=3 then rr.sd:=rr.sd-su end;
         if jj=2 then begin if ad=1 then rd.sb:=rd.sb-su;
                            if ad=2 then rd.sn:=rd.sn-su end;
         if jj=3 then begin if ad=1 then re.sb:=re.sb-su;
                            if ad=2 then re.sn:=re.sn-su end;
                            end;
         2: begin
         if jj=1 then begin if ad=1 then rr.sb:=rr.sb+su;
                            if ad=2 then rr.sn:=rr.sn+su end;
         if jj=2 then begin if ad=1 then rd.sb:=rd.sb+su;
                            if ad=2 then rd.sn:=rd.sn+su end;
         if jj=3 then begin if ad=1 then re.sb:=re.sb+su;
                            if ad=2 then re.sn:=re.sn+su end;
                             end;
         3: begin
    if jj=1 then begin if ad=1 then begin rr.sb:=rr.sb-su; rr.sn:=rr.sn+su end;
                       if ad=2 then begin rr.sb:=rr.sb+su; rr.sn:=rr.sn-su end;
                if ad=3 then begin rr.sd:=rr.sd-su; rr.sn:=rr.sn+su end end;
    if jj=2 then begin if ad=1 then begin rd.sb:=rd.sb-su; rd.sn:=rd.sn+su end;
             if ad=2 then begin rd.sb:=rd.sb+su; rd.sn:=rd.sn-su end end;
    if jj=3 then begin if ad=1 then begin re.sb:=re.sb-su; re.sn:=re.sn+su end;
             if ad=2 then begin re.sb:=re.sb+su; re.sn:=re.sn-su end end;
              end;

         4: begin
                if jj=1 then begin
                if ad=1 then rr.sd:=su;
                if ad=2 then rr.sn:=su;
                if ad=3 then rr.sb:=su end;
              if jj=2 then begin
                if ad=1 then rd.sd:=su;
                if ad=2 then rd.sn:=su;
                if ad=3 then rd.sb:=su end;
              if jj=3 then begin
                if ad=1 then re.sd:=su;
                if ad=2 then re.sn:=su;
                if ad=3 then re.sb:=su end;
                                    end;
        5: begin rf(jj,dk-1);
             if jj=2 then begin
                rd.da:=da; rd.mo:=mo; rd.ye:=ye; rd.st:=5;
                rd.su:=su; str(ku:5:2,ss); rd.pri:=ss;
                rd.sn:=rd.sn-su; rd.dk:=dk; wf(2,dk) end;
            if jj=3 then begin
                re.da:=da; re.mo:=mo; re.ye:=ye; re.st:=5;
                re.su:=su; str(ku:5:2,ss); re.pri:=ss;
                re.sn:=re.sn-su;  re.dk:=dk; wf(3,dk) end;

                fn(1); dk:=nn; rf(1,dk);
                rr.da:=da; rr.mo:=mo; rr.ye:=ye; rr.st:=5;
                rr.su:=su*ku; str(ku:5:2,ss);
             if jj=2 then pri:='КУРС:'+ss+'р/;
             if jj=3 then pri:='КУРС:'+ss+'р/E';
                rr.pri:=pri;
                rr.sn:=rr.sn+su*ku; rr.dk:=dk+1; wf(1,dk+1); end end;
10: end;

procedure vvo(jj:byte; n:word);
label 2;
var   mo1: byte;
begin
2:
      rf(jj,n-1); erp(jj); mo1:=mo;

vvd(n);
        t(15); write(n:4,'  ',da:2,'.',mo:2,'.20',ye:2);

if mo<>mo1 then rr.sd:=0;

    t(14); write('     Сумма');
    if jj=1 then write('(руб)  ');
    if jj=2 then write('($)  ');
    if jj=3 then write('(E)  ');
    read(su); t(10);
write('Расход - 1, Доход - 2, Перенос - 3, Поправка - 4, Конвертация - 5 ');
    read(st); writeln; t(7);
         case st of
         1: begin tab(1,stn);
             write('Сумма изымается из: Банка - 1, Наличных - 2');
             if jj=1 then begin if stn>1 then write(',  Дома - 3 ');
                                if stn=1 then write(' ') end;
             if jj=2 then write(' ');
             if jj=3 then write(' '); read(ad) end;

         2: begin tab(2,stn);
            write('Сумма вносится в: Банк - 1, Наличные - 2 '); read(ad) end;

         3: begin writeln('Банк ---> нлчн...1');
                  writeln('Нлчн ---> банк...2');
                  writeln('Нлчн ---> дом....4');
     if jj=1 then writeln('Дом  ---> нлчн...3');
                  writeln; write('Выбран код.........  '); read(ad) end;

         4: begin
        write('Исправляем: ДОМ - 1, НАЛИЧНЫЕ - 2, БАНК - 3 '); read(ad);
                                      end;
         5: begin writeln;
         if jj=2 then write('КУРС: руб за USD ');
         if jj=3 then write('КУРС: руб за EVR '); read(ku);
           dk:=n end;
        end;
        if st<5 then begin readln; write('Примечание '); read(pri) end;
   writeln; write('Если ошибка, повторяем ввод - 1  Нет - 0 '); read(i);
        if i=1 then goto 2;  dk:=n; pro(jj,st);
        if st<>5 then begin  pre(jj); wf(jj,n) end;
      end;

procedure kd1;
begin
    case k of
         1: write('Домхоз    ');
         2: write('Филателия ');
         3: write('Авто      ');
         4: write('Книги     ');
         5: write('Подарки   ');
         6: write('PC/TV/VM  ');
         7: write('Отпск/сад ');
         8: write('Медицина  ');
         9: write('Налоги    ');
        10: write('Прочее    ') end;
end;

procedure kd2;
begin
    case k of
         1: write('Гонорар   ');
         2: write('Филателия ');
         3: write('Авто      ');
         4: write('"Подарки" ');
         5: write('Пенсия +  ') end;
end;

procedure kd3;
begin
    case k of
         1: write('БАНК->НАЛ ');
         2: write('НАЛ->БАНК ');
         4: write('НАЛ->ДОМ  ');
         3: write('ДОМ->НАЛ  ');
          end;
end;

procedure vyv(jj: byte; n: word);
var       mo1: byte;
begin rf(jj,n-1); erp(jj); mo1:=mo;
      rf(jj,n); erp(jj); if mo<>mo1 then writeln;
    t(13); write(n:4,' ');
    t(15); write(da:2,'.',mo:2,'.',ye:2,' ');
                                       if st=0 then write('    ');
                          if st=1 then begin t(12); write(' Р  ') end;
                          if st=2 then begin t(10); write(' Д  ') end;
                          if st=3 then begin t(15); write(' Пе ') end;
                          if st=4 then begin t(13); write(' По ') end;
                          if st=5 then begin t(10); write(' Ко ') end;
                                     if jj=1 then write(' ');
                                     if jj=2 then write(');
                                     if jj=3 then write('E');

                                  t(14); write(su:8:1,' ');
                                  if (st=0) or (st=5) then write(' ' :10);
                           if st=1 then begin t(12); kd1(stn); t(14) end;
                           if st=2 then begin t(10); kd2(stn); t(14) end;
                                  if st=3 then kd3(ad);
                                  if st=4 then begin t(13);
                                  write('Заменить     ') end;

if jj=1 then begin write(rr.sd:6:0,'  '); write(rr.sn:8:1,'  ',rr.sb:8:1,'  ') end;
if jj=2 then begin write(rd.sd:6:0,'  '); write(rd.sn:8:1,'  ',rd.sb:8:1,'  ') end;
if jj=3 then begin write(re.sd:6:0,'  '); write(re.sn:8:1,'  ',re.sb:8:1,'  ') end;
             if st=5 then begin
             if jj=2 then pri:='КУРС:'+pri+'р/;
             if jj=3 then pri:='КУРС:'+pri+'р/E' end;
writeln(pri);
end;

end.
