unit untLoginView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  System.Actions, Vcl.ActnList;

type
  TfrmLogin = class(TForm)
    Panel1: TPanel;
    edtEmail: TEdit;
    edtPassword: TEdit;
    lblEmail: TLabel;
    lblSenha: TLabel;
    bbConfirmar: TBitBtn;
    bbCancelar: TBitBtn;
    ActionList: TActionList;
    actAdmin: TAction;
    actClear: TAction;
    actGerente: TAction;
    procedure bbConfirmarClick(Sender: TObject);
    procedure actAdminExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
    procedure actGerenteExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses uLoginControl, untPrincipal, untUtils, udmConexao;

procedure TfrmLogin.bbConfirmarClick(Sender: TObject);
Var
  vLoginControl : TLoginControl;
begin
  try
    vLoginControl   := TLoginControl.Create;
    DMConexao.Login := vLoginControl.Logar(edtEmail.Text, edtPassWord.Text);

    if DMConexao.Login.Token <> '' then
    begin
      GerarLog('Usuário Logado com sucesso! Token.:'+DMConexao.Login.Token);
      ShowMessage('Usuário Logado com sucesso!')
    end;

  finally
    FreeAndNil(vLoginControl);
  end;
end;

procedure TfrmLogin.actClearExecute(Sender: TObject);
begin
  edtEmail.Clear;
  edtPassword.Clear;
end;

procedure TfrmLogin.actAdminExecute(Sender: TObject);
begin
  edtEmail.Text    := 'admin@admin.com';
  edtPassword.Text := '123456';
end;

procedure TfrmLogin.actGerenteExecute(Sender: TObject);
begin
  edtEmail.Text    := 'joseemanueldasilva@bol.com.br';
  edtPassword.Text := '123456';
end;

end.
