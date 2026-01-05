unit u_msgID;

interface

uses
  Winapi.Messages;

const
  MSG_BASE        = WM_USER  + 50;
  msgConnected    = MSG_BASE + 1;
  msgDisconnected = MSG_BASE + 2;
  msgSimulation   = MSG_BASE + 3;

implementation

end.
