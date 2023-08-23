{
Name       : Harshini Senthilarasu
Student ID : 2102216
File       : CommControl
Brief      :

}


CON
  'Pin numbers
  RxPin         = 20
  TxPin         = 21
  CommBaud      = 9600



VAR
  long  cog3ID
  long  cogStack[128]

OBJ
  Comm      : "FullDuplexSerial.spin"

PUB Init(rxAdd)       'Core 3

  StopCore      'stops cog
  Comm.Start(TxPin,RxPin,0,CommBaud)    'terminal for your receiver and transmitter

  cog3ID := cognew(ValueGiven(rxAdd),@cogStack)   'cog that runs the ValueGiven function

  return
PUB StopCore       'Stops cog if cog3ID is called

  if cog3ID
    cogstop(cog3ID)

PUB ValueGiven(rxAdd)    'Function that stores bytes given by the user

  'pointer which stores the value given by the user
  long[rxAdd] := Comm.RxCheck
