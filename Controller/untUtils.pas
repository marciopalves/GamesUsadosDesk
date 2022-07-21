unit untUtils;

interface

uses
  Classes, IOUtils, Winapi.ShellAPI;

  function ApenasNumerosString(const pTexto: String): String;
  function ValidarEmail(const pEmail: String): Boolean;


implementation

uses
    Dialogs, SysUtils, Windows, Vcl.Forms;


function ApenasNumerosString(const pTexto: String):String;
var
  vText : PChar;
begin
  vText := PChar(pTexto);
  Result := '';

  while (vText^ <> #0) do
  begin
    {$IFDEF UNICODE}
    if CharInSet(vText^, ['0'..'9']) then
    {$ELSE}
    if vText^ in ['0'..'9'] then
    {$ENDIF}
      Result := Result + vText^;

    Inc(vText);
  end;
end;

function ValidarEmail(const pEmail: String): Boolean;
begin
  result := (Pos('@', pEmail)> 1) And (Pos('.', pEmail)> 1) And (Length(pEmail) > 3)
end;

end.
