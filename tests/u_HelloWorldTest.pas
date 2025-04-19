unit u_HelloWorldTest;

interface

uses
  DUnitX.TestFramework;

type
  [TestFixture]
  THelloWorldTest = class
  public
    [Test]
    procedure TestHelloWorld;
  end;

implementation

uses
  System.SysUtils;

[Test]
procedure THelloWorldTest.TestHelloWorld;
begin
  Assert.AreEqual('Hello, World!', 'Hello, World!');
end;

initialization
  TDUnitX.RegisterTestFixture(THelloWorldTest);
end.