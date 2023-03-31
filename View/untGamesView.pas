unit untGamesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls, FireDAC.Stan.Intf,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.DBScope, Vcl.DBGrids,
  Vcl.Bind.Grid, Data.Bind.Grid, Data.DB, Datasnap.DBClient;

type
  TfrmGamesView = class(TForm)
    pnlGrid: TPanel;
    pnlBotoes: TPanel;
    btnPesqGames: TButton;
    dbgGames: TDBGrid;
    cdsGames: TClientDataSet;
    dsGames: TDataSource;
    cdsGamesId: TIntegerField;
    cdsGamesPlataforma: TStringField;
    cdsGamesTitle: TStringField;
    cdsGamesImage: TStringField;
    procedure btnPesqGamesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure CarregarGamesApi;
    procedure CarregarGamesMemoria;
    procedure CarregarGamesBancoDados;
  public
    { Public declarations }
  end;

var
  frmGamesView: TfrmGamesView;

implementation

Uses udmConexao, udmGames, untUtils, System.JSON, Rest.Json,
     untGame;

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
      CarregarGamesMemoria;
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

procedure TfrmGamesView.CarregarGamesMemoria;
Var
  vObjetoJson,
  vSubObjJson: TJsonObject;

  vJsonValor,
  vJsonItem: TJsonValue;

  vArrayGames,
  vArrayFields: TJSonArray;

  vCont, i: Integer;
  vGame: TGame;
begin
  vObjetoJson := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(DMGames.ListaJsonGames), 0) as TJsonObject;

  vJsonValor  := vObjetoJson.Get('content').JsonValue;
  vArrayGames := vJsonValor as TJSONArray;

  for vCont := 0 to vArrayGames.Size -1 do
  begin
    vSubObjJson  := (vArrayGames.Get(vCont) as TJsonObject);

    cdsGames.Insert;
    cdsGamesId.AsInteger         :=  StrToIntDef(RetornaDepois(':', vSubObjJson.Pairs[0].ToString), 0);
    cdsGamesTitle.AsString       :=  RetornaDepois(':', vSubObjJson.Pairs[1].ToString);
    cdsGamesPlataforma.AsString  :=  RetornaDepois(':', vSubObjJson.Pairs[2].ToString);
    cdsGamesImage.AsString       :=  RetornaDepois(':', vSubObjJson.Pairs[4].ToString);

    cdsGames.Post;
  end;


end;

procedure TfrmGamesView.FormCreate(Sender: TObject);
begin
  if DMGames = Nil then
    Application.CreateForm(TDMGames, DMGames);

  cdsGames.CreateDataSet;
  //dbgGames.DataSource := DMGames.dsGames;
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
