unit untAnunciosView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Actions, Vcl.ActnList, Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TfrmAnuncios = class(TForm)
    pnlFiltros: TPanel;
    edtFiltro: TEdit;
    Label1: TLabel;
    btnPesquisa: TButton;
    actAnuncios: TActionList;
    actBuscarGames: TAction;
    dbgAnuncios: TDBGrid;
    procedure actBuscarGamesExecute(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure Pesquisar;
  public
    { Public declarations }
  end;

var
  frmAnuncios: TfrmAnuncios;

implementation

{$R *.dfm}

Uses untGamesView, udmAnuncios, untUtils;

procedure TfrmAnuncios.FormCreate(Sender: TObject);
begin
  if DMAnuncios = Nil then
    Application.CreateForm(TDMAnuncios, DMAnuncios);

  dbgAnuncios.DataSource := DMAnuncios.dsAnuncios;
end;

procedure TfrmAnuncios.actBuscarGamesExecute(Sender: TObject);
begin
  try
    GerarLog('Chamando Form de Games');
    if frmGamesView = nil then
      Application.CreateForm(TfrmGamesView, frmGamesView);

    frmGamesView.FormCall := 'frmAnuncios';
    frmGamesView.ShowModal;
  finally
    if frmGamesView.IdGameSelected <> EmptyStr then
      edtFiltro.Text := frmGamesView.IdGameSelected;
  end;
end;

procedure TfrmAnuncios.btnPesquisaClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmAnuncios.Pesquisar;
begin
  if StrToIntDef(edtFiltro.Text, 0)> 0 then
    DMAnuncios.ListarAnunciosJogo(edtFiltro.Text)
  else
    DMAnuncios.ListarMeusAnuncios;

  Refresh;
end;

end.
