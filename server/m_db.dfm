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
    Left = 144
    Top = 112
  end
end
