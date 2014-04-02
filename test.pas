unit test;

{$mode objfpc}{$H+}

interface

uses
  ctypes, sysutils;

implementation

const
{$IFDEF WIN32}
  prefix = '_';
{$ELSE}
  prefix = '';
{$ENDIF}

  
function GetAnswer: cint; cdecl; public name prefix+'GetAnswer';
begin
  Result:= trunc(now);
end;

//exports
//  GetAnswer;

end.

