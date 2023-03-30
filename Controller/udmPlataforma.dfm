object DMPlataforma: TDMPlataforma
  OldCreateOrder = False
  Height = 150
  Width = 215
  object mtPlataforma: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 56
    Top = 32
  end
  object dsPlataforma: TDataSource
    DataSet = mtPlataforma
    Left = 56
    Top = 88
  end
end
