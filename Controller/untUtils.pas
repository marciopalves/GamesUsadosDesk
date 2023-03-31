unit untUtils;

interface

uses
  Classes, IOUtils, Winapi.ShellAPI;

  function ApenasNumerosString(const pTexto: String): String;
  function ValidarEmail(const pEmail: String): Boolean;
  function RetornaDepois(const pCaracter: String; const pTexto: String):String;

  procedure GerarLog(const Operacao: String);


implementation

uses
    Dialogs, SysUtils, Windows, Vcl.Forms;


function ApenasNumerosString(const pTexto: String):String;
var
  vText : PChar;
begin
  GerarLog('ApenasNumerosString - '+pTexto);
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
  GerarLog('ApenasNumerosString - '+Result);
end;

function ValidarEmail(const pEmail: String): Boolean;
begin
  result := (Pos('@', pEmail)> 1) And (Pos('.', pEmail)> 1) And (Length(pEmail) > 3)
end;

procedure GerarLog(const Operacao: String);
var
  ArqLog: TextFile;
  Diretorio: String;
  LocalizacaoArq, vsTransacao,
  CodFilial, Usuario, DataHora: AnsiString;
begin
   Diretorio := ExtractFileDir(GetCurrentDir)+'\LOG\';

   if not DirectoryExists (Diretorio) then
      ForceDirectories(Diretorio);

  LocalizacaoArq := Diretorio+'LOG_DATA'+FormatDateTime('DDMMYYYY', Date) + '.LOG';
  DataHora := DateTimeToStr(Now);

  try
    if FileExists(LocalizacaoArq) then
    begin
      AssignFile(ArqLog, LocalizacaoArq);{$I-}
      System.Append(ArqLog);
    end
    else
    begin
      AssignFile(ArqLog, LocalizacaoArq);
      ReWrite(ArqLog);
    end;

    WriteLn(ArqLog, Format('%s %s ', [FormatDateTime('DD/MM/YYYY HH:NN:SS,zzz', Now), Operacao]));

    CloseFile(ArqLog);
  except
    on E: Exception do
      CloseFile(ArqLog);
  end;
end;

function RetornaDepois(const pCaracter:String; const pTexto: String):String;
Var
  vPosicao: Integer;
  vNew: String;
begin
  vPosicao := Pos(pCaracter, pTexto)+1;
  vNew := Copy(pTexto, vPosicao, Length(pTexto));
  if StrToIntDef(vNew, 0)<= 0 then
  begin
    Delete(vNew, 1, 1);
    Delete(vNew, Length(vNew), 1);
  end;
  result := vNew;
end;

end.

