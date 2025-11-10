unit u_msgID;

interface

uses
  Winapi.Messages;

const
  MSG_BASE        = WM_USER  + 100;
  msgConnected    = MSG_BASE + 1;
  msgDisconnected = MSG_BASE + 2;

implementation

end.
