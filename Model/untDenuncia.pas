unit untDenuncia;

interface

  Type
    TDenuncia = Class
    private
      FId: String;
      FDescription: String;
    public
      property Id: String read FId write FId;
      property Description: String read FDescription write FDescription;
    End;

implementation

end.
