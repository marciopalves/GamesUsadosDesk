unit untLogin;

interface
  Type TLogin = class
  private
    FTipo: String;
    FUserType: String;
    FToken: String;

  public
    property Token: String read FToken write FToken;
    property UserType: String read FUserType write FUserType;
    property Tipo: String read FTipo write FTipo;
  end;

implementation



end.
