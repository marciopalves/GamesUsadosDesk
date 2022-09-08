program GamesUsadosDesk;

uses
  Vcl.Forms,
  udmConexao in 'Controller\udmConexao.pas' {DMConexao: TDataModule},
  untUser in 'Model\untUser.pas',
  uILogin in 'Controller\uILogin.pas',
  untLogin in 'Model\untLogin.pas',
  uLoginControl in 'Controller\uLoginControl.pas',
  untLoginView in 'View\untLoginView.pas' {frmLogin},
  untPrincipal in 'View\untPrincipal.pas' {frmPrincipal},
  UIManager in 'Controller\UIManager.pas',
  untManager in 'Model\untManager.pas',
  uManagerControl in 'Controller\uManagerControl.pas',
  untManagerView in 'View\untManagerView.pas' {frmManager},
  untUtils in 'Controller\untUtils.pas',
  untGamesView in 'View\untGamesView.pas' {frmGamesView},
  untGame in 'Model\untGame.pas',
  udmGames in 'Controller\udmGames.pas' {DMGames: TDataModule},
  udmManager in 'Controller\udmManager.pas' {DMManager: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMConexao, DMConexao);
  Application.CreateForm(TDMGames, DMGames);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDMManager, DMManager);
  Application.Run;
end.
