unit untUser;

interface
  Type TUser = class
    private
    FEmail: String;
    FPassword: String;

    public
      property Email: String read FEmail write FEmail;
      property Password: String read FPassword write FPassword;
  end;

implementation

{ TUser }



end.
