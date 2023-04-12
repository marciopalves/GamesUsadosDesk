unit untCadAnunciosView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmCadAnuncios = class(TForm)
    pnlFiltros: TPanel;
    Label1: TLabel;
    edtFiltro: TEdit;
    btnPesquisa: TButton;
    pnlBotoes: TPanel;
    bbConfirmar: TBitBtn;
    bbCancelar: TBitBtn;
    edtValor: TEdit;
    lblValor: TLabel;
    procedure bbConfirmarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function ValidarCampos: Boolean;
    procedure LimparCampos;
  public
    { Public declarations }
  end;

var
  frmCadAnuncios: TfrmCadAnuncios;

implementation

Uses udmAnuncios, untUtils;

{$R *.dfm}

procedure TfrmCadAnuncios.FormCreate(Sender: TObject);
begin
  if DMAnuncios = Nil then
    Application.CreateForm(TDMAnuncios, DMAnuncios);
end;

procedure TfrmCadAnuncios.LimparCampos;
begin
  edtFiltro.Clear;
  edtValor.Clear;
end;

procedure TfrmCadAnuncios.FormShow(Sender: TObject);
begin
  LimparCampos;
  edtFiltro.SetFocus;
end;

function TfrmCadAnuncios.ValidarCampos: Boolean;
var
  msg: String;
begin
  if(StrToIntDef(edtFiltro.Text, 0)< 0) then
  begin
    if msg = EmptyStr then
      msg := 'Erro não foi definido o jogo para cria o anúncio!'
    else msg := msg+sLineBreak+'Erro não foi definido o jogo para criar o anúncio!';
  end;

  if(StrToIntDef(edtValor.Text, 0)< 0) then
  begin
    if msg = EmptyStr then
      msg := 'Erro não foi definido o valor para o anúncio!'
    else msg := msg+sLineBreak+'Erro não foi definido o valor para o anúncio!';
  end;

  if msg <> EmptyStr then
  begin
    GerarLog('Cadastro de Anúncio '+Msg);
    raise Exception.Create(msg);
    edtFiltro.SetFocus;
  end;
  result:= msg = EmptyStr;
end;

procedure TfrmCadAnuncios.bbConfirmarClick(Sender: TObject);
begin
  if ValidarCampos then
  begin
    DMAnuncios.CriarAnuncio(edtFiltro.Text, edtValor.Text);
    ShowMessage('Anúncio criado com sucesso!');
  end;
end;

end.
