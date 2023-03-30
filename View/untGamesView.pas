unit untGamesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls, FireDAC.Stan.Intf,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.DBScope, Vcl.DBGrids,
  Vcl.Bind.Grid, Data.Bind.Grid, Data.DB;

type
  TfrmGamesView = class(TForm)
    pnlGrid: TPanel;
    pnlBotoes: TPanel;
    btnPesqGames: TButton;
    dbgGames: TDBGrid;
    procedure btnPesqGamesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure CarregarGamesApi;
    procedure CarregarGamesBancoDados;
  public
    { Public declarations }
  end;

var
  frmGamesView: TfrmGamesView;

implementation

Uses udmConexao, udmGames, untUtils;

{$R *.dfm}

procedure TfrmGamesView.btnPesqGamesClick(Sender: TObject);
begin
  CarregarGamesApi;
end;

procedure TfrmGamesView.CarregarGamesApi;
begin
  if (DMConexao.BaseUrl <> EmptyStr) then
  begin
    try
      DMGames.ListarGames;

    except
      on E: exception do
      begin
        GerarLog('Erro ao acessar endpoint games - ' + E.ToString);
        raise exception.Create('Erro acessar API ' + E.ToString);
      end;
    end;
  end
  else
  begin
    GerarLog('Informações insuficientes para acessar API.' + ' - BaseUrl.:' +
      DMConexao.BaseUrl + sLineBreak + ' - Token.:' + DMConexao.Login.Token +
      sLineBreak);
    raise exception.Create('Erro informações insuficientes para acessar API.');
  end;
end;

procedure TfrmGamesView.CarregarGamesBancoDados;
begin
  //
end;

procedure TfrmGamesView.FormCreate(Sender: TObject);
begin
  if DMGames = Nil then
    Application.CreateForm(TDMGames, DMGames);
end;

procedure TfrmGamesView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DMGames <> Nil then
  begin
    DmGames.mtGames.Close;
    DMGames.Free;
  end;
end;

end.
