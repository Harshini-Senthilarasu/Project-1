{
Name       : Harshini Senthilarasu
Student ID : 2102216
File       : CommControl
Brief      : This file contains the functions for transmitting data and recieving data
             using the zigbee transmittor and receiver

             Functions that are being implemented are:
             1.Start(msVal, Val)
             2.StopCore
             3.CommCommands(Val)
             4.Pause(ms)
}


CON
  'Pin numbers
  RxPin         = 21 'DOUT
  TxPin         = 20 'DIN
  CommBaud      = 9600

  'Comm Hex Keys
  CommStart     = $7A
  CommStopAll   = $AA
  CommForward   = $01
  CommReverse   = $02
  CommLeft      = $03
  CommRight     = $04

VAR
  long  cogID3, cogStack[128]
  long  rxValue, _Ms_001

OBJ
  Comm      : "FullDuplexSerial.spin"

PUB Start(msVal, Val)       'Core 3

   _Ms_001 := MSVal   'stores number of milliseconds which will be used by Pause function

  StopCore      'stops cog
  Comm.Start(TxPin,RxPin,0,CommBaud)    'terminal for your receiver and transmitter
  Pause(3000) 'wait 3 seconds

  cogID3 := cognew(CommCommands(Val),@cogStack)   'cog that runs the ValueGiven function

  return

PUB StopCore       'Stops cog if cog3ID is called

  if cogID3
    cogstop(cogID3)

PUB CommCommands(Val)

  repeat
   ' rxValue := Comm.Rx  '<- Wait at this statement for a byte
    rxValue := Comm.RxCheck '<- Check if byte but not wait
    if (rxValue == CommStart)
      rxValue := Comm.RxCheck
      case rxValue
        commForward:
        ' 'Motors move forward
          long[Val] := 10
        commReverse:
          'Motors move backwards
          long[Val] := 11
        commLeft:
          'Turn vehicle to the left
          long[Val] := 12
        commRight:
          'Turn vehicle to the right
          long[Val] := 13
        commStopAll:
          'Stop all the motors from working
          long[Val] := 14


PRI Pause(ms) | t    'Pause Function

  t := cnt - 1088
  repeat(ms #> 0)
    waitcnt(t += _Ms_001)
  return
