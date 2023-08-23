{
Name       : Harshini Senthilarasu
Student ID : 2102216
File       : MyLiteKit
Brief      : This file uses the object files CommControl, SensorControl and MotorControl to
             move the lite kit forward, reverse, turn right and turn left and stop if the sensors
             detect a value that exceeds the limits.

             This file implements the function:
             1. Main
             2. ForwardMotion
             3. ReverseMotion
             4. LeftMotion
             5. RightMotion
             6. Pause(ms)
}


CON
        _clkmode = xtal1 + pll16x                                               'Standard clock mode * crystal frequency = 80 MHz
        _xinfreq = 5_000_000

        _ConClkFreq = ((_clkmode - xtal1) >> 6) * _xinfreq
        _Ms_001 = _ConClkFreq / 1_000

        CommStart     = $7A
        CommStop      = $AA
        CommForward   = $01
        CommReverse   = $02
        CommLeft      = $03
        CommRight     = $04

VAR
  long  mainToFVal1, mainToFVal2, mainUltraVal1, mainUltraVal2, rxVal

OBJ
  Sensor         : "SensorControl.spin"
  MotorCtrl      : "MotorControl.spin"
  Comm           : "CommControl.spin"

PUB Main | vals            'Core 0

  Comm.Init(@rxVal)

  repeat
    if (rxVal == CommStart)
      case rxVal

        CommForward:        'Calling ForwardMotion function when CommForward value from CommControl is given by user
          ForwardMotion

        CommReverse:
          ReverseMotion     'Calling ReverseMotion function when CommReverse value from CommControl is given by user

        CommLeft:
          LeftMotion       'Calling LeftMotion function when CommLeft value from CommControl is given by user

        CommRight:
          RightMotion     'Calling RightMotion function when CommRight value from CommControl is given by user

        CommStop:
          MotorCtrl.StopAllMotors 'Calling MotorCtrl.StopAllMotors from MotorControl when CommStop value from CommControl is given by user

PUB ForwardMotion      'Moving forward and stopping if the limits are exceeded

  MotorCtrl.Init(_Ms_001,1)
  Sensor.Init(_Ms_001, @mainToFVal1, @mainToFVal2, @mainUltraVal1, @mainUltraVal2)

  repeat
    Pause(200)
    if mainUltraVal1 > 10 and mainUltraVal1 < 100   'if these limits are exceeded, stop motors
      MotorCtrl.StopAllMotors
      quit
    elseif mainToFVal1 > 200         'if these limits are exceeded, stop motors
      MotorCtrl.StopAllMotors
      quit

PUB ReverseMotion           'Moving backwards and stopping if the limits are exceeded

  MotorCtrl.Init(_Ms_001,2)
  Sensor.Init(_Ms_001, @mainToFVal1, @mainToFVal2, @mainUltraVal1, @mainUltraVal2)

  repeat
    Pause(200)
    if mainUltraVal2 > 10 and mainUltraVal2 < 100   'if these limits are exceeded, stop motors
      MotorCtrl.StopAllMotors
      quit
    elseif mainToFVal2 > 200    'if these limits are exceeded, stop motors
      MotorCtrl.StopAllMotors
      quit

PUB LeftMotion                  'Moving left and stopping if the limits are exceeded

  MotorCtrl.Init(_Ms_001,4)
  Sensor.Init(_Ms_001, @mainToFVal1, @mainToFVal2, @mainUltraVal1, @mainUltraVal2)

  repeat
    Pause(200)
    if mainUltraVal1 > 10 and mainUltraVal1 < 100    'if these limits are exceeded, stop motors
      MotorCtrl.StopAllMotors
      quit
    elseif mainToFVal1 > 200       'if these limits are exceeded, stop motors
      MotorCtrl.StopAllMotors
      quit

PUB RightMotion                'Moving right and stopping if the limits are exceeded

  MotorCtrl.Init(_Ms_001,3)
  Sensor.Init(_Ms_001, @mainToFVal1, @mainToFVal2, @mainUltraVal1, @mainUltraVal2)

  repeat
    Pause(200)
    if mainUltraVal1 > 10 and mainUltraVal1 < 100    'if these limits are exceeded, stop motors
      MotorCtrl.StopAllMotors
      quit
    elseif mainToFVal1 > 200       'if these limits are exceeded, stop motors
      MotorCtrl.StopAllMotors
      quit

PRI Pause(ms) | t

  t := cnt - 1088
  repeat(ms #> 0)
    waitcnt(t += _Ms_001)
  return
