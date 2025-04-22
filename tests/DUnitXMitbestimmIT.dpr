program DUnitXMitbestimmIT;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.IOUtils,
  DUnitX.Loggers.Console,
  DUnitX.Loggers.XML.NUnit,
  DUnitX.TestFramework,
  u_testBERBerechnungen in 'u_testBERBerechnungen.pas',
  u_BER_Berechnungen in '..\berechnungen\u_BER_Berechnungen.pas',
  u_BRWahlFristen in '..\berechnungen\u_BRWahlFristen.pas';

{$R *.res}

var
  runner : ITestRunner;
  results : IRunResults;
  logger : ITestLogger;
  nunitLogger : ITestLogger;
  path, fname : string;
begin
  try
    //Create the runner
    runner := TDUnitX.CreateRunner;
    runner.UseRTTI := True;

    //tell the runner how we will log things

    if TDUnitX.Options.ConsoleMode <> TDunitXConsoleMode.Off then
    begin
      logger := TDUnitXConsoleLogger.Create(TDUnitX.Options.ConsoleMode = TDunitXConsoleMode.Quiet);
      runner.AddLogger(logger);
    end;


    path  := TPath.Combine(ExtractFilePath(ParamStr(0)), 'Results');
    fname := ExtractFileName(ParamStr(0));
    SetLength(fname, length(fname)-4);
    fname := fname + '-results.xml';


    TDUnitX.Options.XMLOutputFile := TPath.Combine(path, fname);

    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);

    //Run tests
    results := runner.Execute;

    System.Write('Done.. press <Enter> key to quit.');
    System.Readln;
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
end.

