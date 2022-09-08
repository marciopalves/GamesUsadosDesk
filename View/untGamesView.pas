unit untGamesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls,
  REST.Response.Adapter, Vcl.StdCtrls;

type
  TfrmGamesView = class(TForm)
    pnlGrid: TPanel;
    pnlBotoes: TPanel;
    strgGames: TStringGrid;
    brnPesqGames: TButton;
    mmTeste: TMemo;
    procedure brnPesqGamesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGamesView: TfrmGamesView;

implementation

{$R *.dfm}

uses udmGames;

procedure TfrmGamesView.brnPesqGamesClick(Sender: TObject);
begin
  DMGames.RestRequest.ClearBody;
  DMGames.RestRequest.Execute;

  mmTeste.Lines.Add(DMGames.RestResponse.Content);
end;

end.
