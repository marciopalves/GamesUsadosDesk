unit untGamesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls,
  REST.Response.Adapter, Vcl.StdCtrls, Vcl.ComCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.DBScope, Vcl.DBGrids,
  Vcl.Bind.Grid, Data.Bind.Grid;

type
  TfrmGamesView = class(TForm)
    pnlGrid: TPanel;
    pnlBotoes: TPanel;
    btnPesqGames: TButton;
    FDMemGames: TFDMemTable;
    mmGames: TMemo;
    FDMemGamesId: TIntegerField;
    FDMemGamesTitle: TStringField;
    FDMemGamesPlataforma: TStringField;
    FDMemGamesImage: TStringField;
    dsGames: TDataSource;
    dbgGames: TDBGrid;
    procedure btnPesqGamesClick(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarGamesApi;
    procedure CarregarGamesBancoDados;
  public
    { Public declarations }
  end;

var
  frmGamesView: TfrmGamesView;

implementation

Uses udmConexao, untUtils, RESTRequest4D, Rest.JSON, System.JSON;

{$R *.dfm}

CONST
  RESOURCE = '/games?page=0';

procedure TfrmGamesView.btnPesqGamesClick(Sender: TObject);
begin
  CarregarGamesApi;
end;

procedure TfrmGamesView.CarregarGamesApi;
Var
  vResp: IResponse;
  vJson: TJsonValue;
begin
  if (DMConexao.BaseUrl <> EmptyStr) then
  begin
    try
      vResp := TRequest.New.BaseUrl(DMConexao.BaseUrl).RESOURCE(RESOURCE)
        .Accept(REST.Types.CONTENTTYPE_APPLICATION_JSON)
        .DataSetAdapter(FDMemGames).GET;

      if vResp.StatusCode = 200 then
      begin
        GerarLog(' Listar Games sucess');
        vJson := TJSONObject.ParseJSONValue(vResp.Content) as TJSONValue;
        mmGames.Lines.Clear;
        mmGames.Lines.Add(TJson.Format(vJson));
      end;

    except
      on E: exception do
      begin
        GerarLog('Erro ao acessar endpoint criar Gerente - ' + E.ToString +
          sLineBreak + 'URL.:' + DMConexao.BaseUrl + RESOURCE);
        raise exception.Create('Erro acessar API ' + E.ToString);
      end;
    end;
  end
  else
  begin
    GerarLog('Informações insuficientes para acessar API.' + ' - BaseUrl.:' +
      DMConexao.BaseUrl + sLineBreak + ' - Token.:' + DMConexao.Login.Token +
      sLineBreak);
    raise exception.Create('Erro informações insuficientes para acessar API.');
  end;
end;

procedure TfrmGamesView.CarregarGamesBancoDados;
begin
  //
end;

end.
