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
    DBGrid1: TDBGrid;
    procedure actBuscarGamesExecute(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
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

procedure TfrmAnuncios.actBuscarGamesExecute(Sender: TObject);
begin
  if frmGamesView = nil then
    Application.CreateForm(TfrmGamesView, frmGamesView);

  frmGamesView.FormCall := 'frmAnuncios';
  frmGamesView.ShowModal;
  edtFiltro.Text := frmGamesView.IdGameSelected;
end;

procedure TfrmAnuncios.btnPesquisaClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmAnuncios.Pesquisar;
begin
  if StrToIntDef(edtFiltro.Text, 0)> 0 then
  begin
    DMAnuncios.ListarAnunciosJogo(edtFiltro.Text);
  end
  else
  begin
    DMAnuncios.ListarMeusAnuncios;
    //DMAnuncios.BuscarMeusAnuncios
  end;
end;

end.
