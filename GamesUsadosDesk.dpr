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
  untParametros in 'View\untParametros.pas' {frmParametros},
  untAnunciosView in 'View\untAnunciosView.pas' {frmAnuncios},
  untPlataforma in 'Model\untPlataforma.pas',
  udmPlataforma in 'Controller\udmPlataforma.pas' {DMPlataforma: TDataModule},
  udmGames in 'Controller\udmGames.pas' {DMGames: TDataModule},
  untPlataformasView in 'View\untPlataformasView.pas' {frmPlataformas},
  udmAnuncios in 'Controller\udmAnuncios.pas' {DMAnuncios: TDataModule},
  untGame in 'untGame.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMConexao, DMConexao);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmPlataformas, frmPlataformas);
  Application.CreateForm(TDMAnuncios, DMAnuncios);
  Application.Run;
end.
