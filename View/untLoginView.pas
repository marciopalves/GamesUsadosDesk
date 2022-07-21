unit untLoginView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmLogin = class(TForm)
    Panel1: TPanel;
    edtEmail: TEdit;
    edtPassword: TEdit;
    lblEmail: TLabel;
    lblSenha: TLabel;
    bbConfirmar: TBitBtn;
    bbCancelar: TBitBtn;
    procedure bbConfirmarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses uLoginControl, untPrincipal;

procedure TfrmLogin.bbConfirmarClick(Sender: TObject);
Var
  vLoginControl : TLoginControl;
begin
  try
    vLoginControl := TLoginControl.Create;
    frmPrincipal.vLogin := vLoginControl.Logar(edtEmail.Text, edtPassWord.Text);

    if frmPrincipal.vLogin.Token <> '' then
    begin
      frmPrincipal.HabilitarDesabilitarMenus;
      ShowMessage('Usu�rio Logado com sucesso!')
    end;

  finally
    FreeAndNil(vLoginControl);
  end;
end;

end.
