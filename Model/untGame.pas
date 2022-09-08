unit untGame;

interface
  Type TGame = class

    private
      FId: Integer;
      FTitle: String;
      FPlataform: String;
      FImage: String;

    public
      property Id: Integer Read FId Write FId;
      property Title: String Read FTitle Write FTitle;
      property Plataform: String Read FPlataform Write FPlataform;
      property Image: String Read FImage Write FImage;

  end;

implementation

end.
