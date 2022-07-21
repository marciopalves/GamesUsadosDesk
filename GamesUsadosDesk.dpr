program GamesUsadosDesk;

uses
  Vcl.Forms,
  untPrincipal in 'View\untPrincipal.pas' {frmPrincipal},
  untLogin in 'Model\untLogin.pas',
  uILogin in 'Controller\uILogin.pas',
  uLoginControl in 'Controller\uLoginControl.pas',
  untUser in 'Model\untUser.pas',
  untLoginView in 'View\untLoginView.pas' {frmLogin},
  udmConexao in 'Controller\udmConexao.pas' {DMConexao: TDataModule},
  untManager in 'Model\untManager.pas',
  UIManager in 'Controller\UIManager.pas',
  uManagerControl in 'Controller\uManagerControl.pas',
  untManagerView in 'View\untManagerView.pas' {frmManager},
  untUtils in 'Controller\untUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMConexao, DMConexao);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
