object DBMod: TDBMod
  Height = 480
  Width = 640
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'RoleName=APPADMIN'
      'DriverID=FB')
    Left = 144
    Top = 112
  end
end
