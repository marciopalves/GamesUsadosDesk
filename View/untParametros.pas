unit untParametros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, System.IniFiles;

type
  TfrmParametros = class(TForm)
    edtBaseUrl: TEdit;
    Label1: TLabel;
    bSalvar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure bSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Config: TIniFile;
    FBaseUrl: String;
    procedure CarregaParametros;
    procedure SetaParametros;
  public
    { Public declarations }
    Property BaseUrl: String Read FBaseUrl Write FBaseUrl;
  end;

var
  frmParametros: TfrmParametros;

implementation

{$R *.dfm}

uses untUtils;

procedure TfrmParametros.FormCreate(Sender: TObject);
begin
  Config := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Config.ini');
end;

procedure TfrmParametros.FormShow(Sender: TObject);
begin
  CarregaParametros;
end;

procedure TfrmParametros.CarregaParametros;
begin
  GerarLog('Carregar parametros ...');
  BaseUrl         := Config.ReadString('PARAMETROS', 'BASEURL', '');
  edtBaseUrl.Text := BaseUrl;
  GerarLog('BaseUrl .:'+BaseUrl);
end;

procedure TfrmParametros.SetaParametros;
begin
  GerarLog('Setar parametros ...');
  BaseUrl := edtBaseUrl.Text;
  Config.WriteString('PARAMETROS', 'BASEURL', BaseUrl);
  GerarLog('BaseUrl .:'+BaseUrl);
end;

procedure TfrmParametros.bSalvarClick(Sender: TObject);
begin
  SetaParametros;
end;

end.
