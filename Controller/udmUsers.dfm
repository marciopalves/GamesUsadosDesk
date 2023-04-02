object DMUsers: TDMUsers
  OldCreateOrder = False
  Height = 150
  Width = 215
  object mtUsers: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 32
    Top = 32
  end
  object dsUsers: TDataSource
    DataSet = mtUsers
    Left = 32
    Top = 88
  end
end
