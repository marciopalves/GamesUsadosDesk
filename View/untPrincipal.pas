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
    Logar3: TMenuItem;
    Logar4: TMenuItem;
    Logar1: TMenuItem;
    actParametros: TAction;
    Configuraes1: TMenuItem;
    actAnuncios: TAction;
    actPlataformas: TAction;
    Plataformas2: TMenuItem;
    Listar1: TMenuItem;
    Games1: TMenuItem;
    actListarUsers: TAction;
    ListarUsurios1: TMenuItem;
    Anncios1: TMenuItem;
    actCadAnuncios: TAction;
    CadastrodeAnncios1: TMenuItem;
    procedure actLoginExecute(Sender: TObject);
    procedure actGerentesExecute(Sender: TObject);
    procedure actGamesExecute(Sender: TObject);
    procedure actParametrosExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actPlataformasExecute(Sender: TObject);
    procedure actListarUsersExecute(Sender: TObject);
    procedure actAnunciosExecute(Sender: TObject);
    procedure actCadAnunciosExecute(Sender: TObject);
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
      untPlataformasView, untUsuersView, untAnunciosView, untCadAnunciosView;

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
  actLogin.Enabled         := True;
  actDeslogar.Enabled      := DMConexao.Login.Token <> '';
  actGerentes.Enabled      := (DMConexao.Login.Token <> '') And (DMConexao.Login.UserType = 'ADMIN');
  actGames.Enabled         := True;
  actPlataformas.Enabled   := True;
  actAnuncios.Enabled      := DMConexao.Login.Token <> '';
  actListarUsers.Enabled   := DMConexao.Login.Token <> '';
end;

procedure TfrmPrincipal.DefinirStatusBar;
begin
  if DMConexao.Login.UserType <> '' then
    StatusBar.panels[0].Text := 'Usuário.: '+DMConexao.Login.UserType
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

procedure TfrmPrincipal.actListarUsersExecute(Sender: TObject);
begin
  if frmUsers = Nil then
     Application.CreateForm(TfrmUsers, frmUsers);

  frmUsers.ShowModal;
end;

procedure TfrmPrincipal.actAnunciosExecute(Sender: TObject);
begin
  if frmAnuncios = Nil then
     Application.CreateForm(TfrmAnuncios, frmAnuncios);

  frmAnuncios.ShowModal;
end;

procedure TfrmPrincipal.actCadAnunciosExecute(Sender: TObject);
begin
  if frmCadAnuncios = Nil then
    Application.CreateForm(TfrmCadAnuncios, frmCadAnuncios);

  frmCadAnuncios.ShowModal;
end;

end.
