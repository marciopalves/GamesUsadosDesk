unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, System.Actions, Vcl.ActnList, untLogin,
  Vcl.ComCtrls, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    ActionList: TActionList;
    actLogin: TAction;
    actDeslogar: TAction;
    actGerentes: TAction;
    MainMenu: TMainMenu;
    Cadastro1: TMenuItem;
    CadastrodeGerentes1: TMenuItem;
    actAnuncios: TAction;
    Image1: TImage;
    StatusBar: TStatusBar;
    pnlTopo: TPanel;
    Anncios1: TMenuItem;
    Logar3: TMenuItem;
    Logar4: TMenuItem;
    Logar1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure actLoginExecute(Sender: TObject);
    procedure actGerentesExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure DefinirStatusBar;
  public
    { Public declarations }
    vLogin: TLogin;
    procedure HabilitarDesabilitarMenus;
  end;

var
  frmPrincipal: TfrmPrincipal;


implementation

{$R *.dfm}

uses untLoginView, untManagerView;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  vLogin := TLogin.Create;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  vLogin.Free;
end;

procedure TfrmPrincipal.actLoginExecute(Sender: TObject);
begin
  if frmLogin = nil then
    Application.CreateForm(TfrmLogin, frmLogin);

  frmLogin.ShowModal;
  HabilitarDesabilitarMenus;
end;

procedure TfrmPrincipal.HabilitarDesabilitarMenus;
begin
  actLogin.Enabled    := vLogin.Token = '';
  actDeslogar.Enabled := vLogin.Token <> '';
  actGerentes.Enabled := (vLogin.Token <> '') And (vLogin.UserType = 'ADMIN');
  actAnuncios.Enabled := vLogin.Token <> '';
  DefinirStatusBar;
end;

procedure TfrmPrincipal.DefinirStatusBar;
begin
  StatusBar.panels[0].Text := vLogin.Tipo;
end;

procedure TfrmPrincipal.actGerentesExecute(Sender: TObject);
begin
  if frmManager = nil then
    Application.CreateForm(TfrmManager, frmManager);

  frmManager.ShowModal;
end;

end.
