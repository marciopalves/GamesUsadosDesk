unit untUsuersView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmUsers = class(TForm)
    pnlBotoes: TPanel;
    btnPesqGames: TButton;
    pnlGrid: TPanel;
    dbgUsers: TDBGrid;
    procedure btnPesqGamesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUsers: TfrmUsers;

implementation

{$R *.dfm}

Uses untUtils, udmUsers;

procedure TfrmUsers.FormCreate(Sender: TObject);
begin
  if DMUsers = Nil then
    Application.CreateForm(TDMUsers, DMUsers);

  dbgUsers.DataSource := DMUsers.dsUsers;
end;

procedure TfrmUsers.FormShow(Sender: TObject);
begin
  btnPesqGamesClick(self);
end;

procedure TfrmUsers.btnPesqGamesClick(Sender: TObject);
begin
  GerarLog('Listar Usuários');
  DMUsers.ListarUsuarios;
end;

end.
