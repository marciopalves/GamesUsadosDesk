unit untGame;

interface

  Type TGame = class
    private
      FPlataforma: String;
      FImage: String;
      FTitle: String;
      FId: Integer;
      FCreatedBy: String;

    public
      property Id: Integer read FId write FId;
      property Title: String read FTitle write FTitle;
      property Plataforma: String read FPlataforma write FPlataforma;
      property Image: String read FImage write FImage;
      property CreatedBy: String read FCreatedBy write FCreatedBy;

  end;

implementation

end.
