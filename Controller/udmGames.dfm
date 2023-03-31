object DMGames: TDMGames
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 133
  Width = 173
  object mtGames: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 32
    Top = 16
  end
  object dsGames: TDataSource
    DataSet = mtGames
    Left = 32
    Top = 72
  end
end
