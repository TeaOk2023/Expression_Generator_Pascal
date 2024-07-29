
var utf8 := Encoding.GetEncoding(65001); // GetEncoding('UTF-8')
  f: textfile;
  d := new Dictionary<string, string>; //матрица исходов
  //start : set of string;
  start := new string[1];
  
Function check(c:char; flag:boolean):boolean;
begin
  if flag then
  begin
    if c in ['A'..'Z','А'..'Я'] then check:=True
    else check:=False;
    Exit;
  end;
  
  if c in ['A'..'Z','a'..'z','А'..'Я','а'..'я'] then check:=True
  else check:=False;
end;


Procedure makepairs(var d:Dictionary<string, string>; q:array of string;n:integer); //dict, n-учет пар
var buff:string;
begin
  for var i := 0 to (q.Length - n - 1) do //пары  writeln(q[i],' ', q[i + 1],' = ',q[i+2]);
  begin
    buff:=q[i]+' '+q[i + 1];
    
    if check(buff[1], true) and (check(buff.Split()[0][buff.Split()[0].Length], false)) and check(buff[buff.Length], false) then
      begin
      SetLength(start,start.Length+1);
      start[start.Length-1] := buff;
      end;
      
    if (d.ContainsKey(buff)) then 
      d[buff]:=d[buff] + ' ' + q[i+2]
    else
      d[buff]:=q[i+2];
  end;
end;

Procedure Generate();
var first, contact:string;
begin
  first:=start[random(start.length-1)]; 
  var chain := Arr(first.Split()); //цепь
  var last := chain[chain.Length-2] + ' ' + chain[chain.Length-1];
  //writeln(last);
  
  
  var flag:boolean;
  flag:=True;
  
  While flag do //до точки last[last.Length-1] <>'.'
  begin
    var ways := d.Get(last).Split();
    contact := ways[random(ways.length)]; //след слово
    //writeln(contact);
    if '.' in contact then flag := false;

    
    SetLength(chain,chain.Length+1);
    chain[chain.Length-1] := contact;
    last := chain[chain.Length-2] + ' ' + chain[chain.Length-1];
  end;
  
  Writeln();
  Writeln();
  Writeln('Фраза:');
  for var i:=0 to chain.Length-1 do write(chain[i], ' ');
end;


Begin
  var s, buff, first, contact: string;
  s := '';
  AssignFile(f, 'text.txt'); // your text file
  Reset(f, utf8);      
  while not Eof(f) do
  begin
    Readln(f, buff);
    s += buff;
    s += ' ';
  end;
  
  s:= s.replace('  ', ' ');
  s:=Trim(s);
  var q: array of string := s.Split();
  
  makepairs(d, q, 2);

  for var i := 0 to (q.Length - 2 - 1) do 
  begin
    buff:=q[i]+' '+q[i + 1];
    if (d.ContainsKey(buff)) then
  end;
  
  Generate();
end.