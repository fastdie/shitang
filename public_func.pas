unit public_func;

interface

uses classes,sysutils,windows;   {public utils}

const
  encrypt_key='NNqzhg@9';

function encoding(s:string;key:string):string;

// how to use --------------------------------
//
{var
  s,result:string;
begin
  if s<>'' then
  begin
    result:=encoding(s,encrypt_key);
  end;
end;}
//
// -------------------------------------------

function decoding(s:string;key:string):string;

// how to use --------------------------------
//
{var
  s,result:string;
begin
  if s<>'' then
  begin
    result:=decoding(s,encrypt_key);
  end;
end;}
//
// -------------------------------------------

function my_leftcopy(s:string):string;

// how to use --------------------------------

// -------------------------------------------

function my_rightcopy(s:string):string;

// how to use --------------------------------

// -------------------------------------------

implementation

function encoding(s:string;key:string):string;
var
  i,j:integer;
begin
  result:='';
  j:=1;
  for i:=1 to length(s) do
  begin
    result:=result + inttohex(byte(s[i]) xor Byte(key[j]),2);
    j:=(j+1) mod 8;
  end;
end;

function decoding(s:string;key:string):string;
var
  i,j:integer;
begin
  result:='';
  j:=1;
  for i:=1 to (length(s) div 2) do
  begin
    result:=result + char(strtoint('$'+copy(s,i*2-1,2)) xor byte(key[j]));
    j:=(j+1) mod 8;
  end;
end;

function my_leftcopy(s:string):string;
var
  i:integer;
begin
  result:='';
  while pos(':',s)>0 do
  begin
    i:=pos(':',s);
    result:=copy(s,1,i-1);
  end;
end;

function my_rightcopy(s:string):string;
var
  i:integer;
begin
  result:='';
  while pos(':',s)>0 do
  begin
    i:=pos(':',s);
    result:=copy(s,i+1,length(s));
  end;
end;

end.
