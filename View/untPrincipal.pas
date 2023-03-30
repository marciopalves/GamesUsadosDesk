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
    actParametros: TAction;
    Configuraes1: TMenuItem;
    actAnuncios: TAction;
    Anncios2: TMenuItem;
    actPlataformas: TAction;
    Plataformas2: TMenuItem;
    procedure actLoginExecute(Sender: TObject);
    procedure actGerentesExecute(Sender: TObject);
    procedure actGamesExecute(Sender: TObject);
    procedure actParametrosExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actPlataformasExecute(Sender: TObject);
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

uses  untLoginView, untManagerView, udmConexao, untGamesView, untParametros,
      untPlataformasView;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  HabilitarDesabilitarMenus;
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
  DefinirStatusBar;
  actLogin.Enabled       := True;
  actDeslogar.Enabled    := DMConexao.Login.Token <> '';
  actGerentes.Enabled    := (DMConexao.Login.Token <> '') And (DMConexao.Login.UserType = 'ADMIN');
  actGames.Enabled       := (DMConexao.Login.Token <> '') And (DMConexao.Login.UserType = 'ADMIN');
  actPlataformas.Enabled := True;
  actAnuncios.Enabled    := True;
end;

procedure TfrmPrincipal.DefinirStatusBar;
begin
  if DMConexao.Login.UserType <> '' then
    StatusBar.panels[0].Text := 'Usuário.: '+ DMConexao.Login.UserType
  else StatusBar.panels[0].Text := 'Usuário.: Não conectado';
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

procedure TfrmPrincipal.actParametrosExecute(Sender: TObject);
begin
  if frmParametros = nil then
     Application.CreateForm(TfrmParametros, frmParametros);

  frmParametros.ShowModal;
end;

procedure TfrmPrincipal.actPlataformasExecute(Sender: TObject);
begin
  if frmPlataformas = Nil then
     Application.CreateForm(TfrmPlataformas, frmPlataformas);

  frmPlataformas.ShowModal;
end;

end.
