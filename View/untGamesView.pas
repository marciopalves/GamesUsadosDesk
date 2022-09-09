unit untGamesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls,
  REST.Response.Adapter, Vcl.StdCtrls, Vcl.ComCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.DBScope, Vcl.DBGrids;

type
  TfrmGamesView = class(TForm)
    pnlGrid: TPanel;
    pnlBotoes: TPanel;
    btnPesqGames: TButton;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
    FDMemTable: TFDMemTable;
    FDMemTableid: TFloatField;
    FDMemTabletitle: TWideStringField;
    FDMemTableplatform: TWideStringField;
    FDMemTableimage: TWideStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    DBGrid1: TDBGrid;
    DataSource: TDataSource;
    procedure btnPesqGamesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGamesView: TfrmGamesView;

implementation

{$R *.dfm}

procedure TfrmGamesView.btnPesqGamesClick(Sender: TObject);
Var
  row : String;
begin
  RestRequest.ClearBody;
  RestRequest.Execute;

end;

end.
