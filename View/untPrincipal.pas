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
    actGames: TAction;
    Image1: TImage;
    StatusBar: TStatusBar;
    pnlTopo: TPanel;
    Anncios1: TMenuItem;
    Logar3: TMenuItem;
    Logar4: TMenuItem;
    Logar1: TMenuItem;
    procedure actLoginExecute(Sender: TObject);
    procedure actGerentesExecute(Sender: TObject);
    procedure actGamesExecute(Sender: TObject);
  private
    { Private declarations }
    procedure DefinirStatusBar;
  public
    { Public declarations }
    procedure HabilitarDesabilitarMenus;
  end;

var
  frmPrincipal: TfrmPrincipal;


implementation

{$R *.dfm}

uses untLoginView, untManagerView, udmConexao, untGamesView;

procedure TfrmPrincipal.actLoginExecute(Sender: TObject);
begin
  if frmLogin = nil then
    Application.CreateForm(TfrmLogin, frmLogin);

  frmLogin.ShowModal;
  HabilitarDesabilitarMenus;
end;

procedure TfrmPrincipal.HabilitarDesabilitarMenus;
begin
  actLogin.Enabled    := DMConexao.Login.Token = '';
  actDeslogar.Enabled := DMConexao.Login.Token <> '';
  actGerentes.Enabled := (DMConexao.Login.Token <> '') And (DMConexao.Login.UserType = 'ADMIN');
  actGames.Enabled    := (DMConexao.Login.Token <> '') And (DMConexao.Login.UserType = 'ADMIN');
  DefinirStatusBar;
end;

procedure TfrmPrincipal.DefinirStatusBar;
begin
  StatusBar.panels[0].Text := DMConexao.Login.Tipo;
end;

procedure TfrmPrincipal.actGerentesExecute(Sender: TObject);
begin
  if frmManager = nil then
    Application.CreateForm(TfrmManager, frmManager);

  frmManager.ShowModal;
end;

procedure TfrmPrincipal.actGamesExecute(Sender: TObject);
begin
  if frmGamesView = nil then
    Application.CreateForm(TfrmGamesView, frmGamesView);

  frmGamesView.ShowModal;
end;

end.
