unit untPlataformasView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls, FireDAC.Stan.Intf,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.DBScope, Vcl.DBGrids,
  Vcl.Bind.Grid, Data.Bind.Grid, Data.DB;

type
  TfrmPlataformas = class(TForm)
    pnlGrid: TPanel;
    pnlBotoes: TPanel;
    dbgPlataformas: TDBGrid;
    btnPesquisarPlataformas: TButton;
    gbCadPlataforma: TGroupBox;
    edtPlataforma: TEdit;
    btnCadastrarPlataforma: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnCadastrarPlataformaClick(Sender: TObject);
    procedure btnPesquisarPlataformasClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure LoadPlataformas;
    procedure Clear;
  public
    { Public declarations }
  end;

var
  frmPlataformas: TfrmPlataformas;

implementation

Uses udmConexao, udmPlataforma, untUtils;

{$R *.dfm}

procedure TfrmPlataformas.FormCreate(Sender: TObject);
begin
  if DMPlataforma = Nil then
     Application.CreateForm(TDMPlataforma, DMPlataforma);

  dbgPlataformas.DataSource := DMPlataforma.dsPlataforma;
end;

procedure TfrmPlataformas.LoadPlataformas;
begin
  DMPlataforma.ListarPlataformas;
end;

procedure TfrmPlataformas.btnCadastrarPlataformaClick(Sender: TObject);
begin
  if Trim(edtPlataforma.Text) <> '' then
  begin
    DMPlataforma.CriarNovaPlataforma(edtPlataforma.Text);
    LoadPlataformas;
    Clear;
  end
  else
  begin
    raise Exception.Create('Voc� precisa definir um nome para criar o registro!');
    edtPlataforma.SetFocus;
  end;
end;

procedure TfrmPlataformas.btnPesquisarPlataformasClick(Sender: TObject);
begin
  LoadPlataformas;
end;

procedure TfrmPlataformas.Clear;
begin
  edtPlataforma.Clear;
end;

procedure TfrmPlataformas.FormShow(Sender: TObject);
begin
  Clear;
  gbCadPlataforma.Enabled := (DMConexao.Login.Token <> '') And (DMConexao.Login.UserType = 'MANAGER');
end;

end.
