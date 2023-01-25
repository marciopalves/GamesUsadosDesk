unit untManager;

interface

  Type TManager = class
    private
      FName: String;
      FEmail: String;
      FPhone: String;
      FPassword: String;

    public
      property Name: String  read FName write FName;
      property Phone: String read FPhone write FPhone;
      property Email: String read FEmail write FEmail;
      property Password: String read FPassword write FPassword;
  end;

implementation

end.
