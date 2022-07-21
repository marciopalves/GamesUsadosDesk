unit uILogin;

interface

uses untLogin;

Type ILogin = interface

  function Logar(const pEmail: String; const pPassword: String): TLogin;
  procedure Deslogar;
end;

implementation



end.
