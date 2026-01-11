object DBMod: TDBMod
  Height = 480
  Width = 640
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'RoleName=APPUSER'
      'Database=D:\DelphiBin\MitbestimmIT\Setup\db\WAHL2026.FDB'
      'DriverID=FB')
    LoginPrompt = False
    Transaction = FDTransaction1
    Left = 64
    Top = 32
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConnection1
    Left = 56
    Top = 96
  end
end
