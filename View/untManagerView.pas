unit untManagerView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  Vcl.ExtCtrls;

type
  TfrmManager = class(TForm)
    pnlEdits: TPanel;
    edtNome: TEdit;
    lblNome: TLabel;
    edtMaskTel: TMaskEdit;
    Label1: TLabel;
    edtEmail: TEdit;
    lblEmail: TLabel;
    edtPassword: TEdit;
    lblSenha: TLabel;
    pnlBotoes: TPanel;
    bbConfirmar: TBitBtn;
    bbCancelar: TBitBtn;
    cbbUserType: TComboBox;
    lblTipo: TLabel;
    procedure FormShow(Sender: TObject);
    procedure bbConfirmarClick(Sender: TObject);
  private
    { Private declarations }
    Procedure LimparTela;
  public
    { Public declarations }
  end;

var
  frmManager: TfrmManager;

implementation

Uses  untManager, uManagerControl, untUtils;

{$R *.dfm}

procedure TfrmManager.bbConfirmarClick(Sender: TObject);
Var
  vManager: TManager;
  vManagerControl: TManagerControl;
begin
  if(edtNome.Text <> '') And (ValidarEmail(edtEmail.Text)) then
  begin
    try
      vManager := TManager.Create();
      vManager.Name     := edtNome.Text;
      vManager.Phone    := ApenasNumerosString(edtMaskTel.Text);
      vManager.Email    := edtEmail.Text;
      vManager.Password := edtPassword.Text;
      vManagerControl   := TManagerControl.Create();

      GerarLog('Objeto Manager Criado em memória');

      if (vManagerControl.Criar(vManager)) then
        ShowMessage('Gerente cadastrado com sucesso!');

    finally
      FreeAndNil(vManager);
      FreeAndNil(vManagerControl);
    end;
  end;
end;

procedure TfrmManager.FormShow(Sender: TObject);
begin
  LimparTela;
end;

procedure TfrmManager.LimparTela;
Var
  vCont: Integer;
begin
  edtNome.Clear;
  edtMaskTel.Clear;
  edtEmail.Clear;
  edtPassword.Clear;
end;

end.
