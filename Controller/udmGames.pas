unit udmGames;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDMGames = class(TDataModule)
    mtGames: TFDMemTable;
    mtGamesId: TIntegerField;
    mtGamesTitle: TStringField;
    mtGamesPlataforma: TStringField;
    mtGamesImage: TStringField;
    dsGames: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ListarGames;
  end;

var
  DMGames: TDMGames;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

Uses untUtils, udmConexao,
     REST.Types, REST.JsonReflect, RESTRequest4D;

Const
  RESOURCE = '/games?page=0';

{ TDMGames }

procedure TDMGames.ListarGames;
begin
  TRequest.New
       .BaseURL(DMConexao.BaseUrl)
       .Resource(RESOURCE)
       .Accept(REST.Types.CONTENTTYPE_APPLICATION_JSON)
       .DataSetAdapter(mtGames)
       .Get;

end;

end.
