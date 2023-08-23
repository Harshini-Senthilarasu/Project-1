{
Name       : Harshini Senthilarasu
Student ID : 2102216
File       : MyLiteKit
Brief      : This file contains the main file that controls the movements of the lite kit based on the
             following object files
             1.MotorControl
             2.SensorControl
             3.CommControl

             Functions that are being implemented are:
             1. Main function
             2. Pause(ms)

}

CON
        _clkmode     = xtal1 + pll16x                                               'Standard clock mode * crystal frequency = 80 MHz
        _xinfreq     = 5_000_000
        _ConClkFreq = ((_clkmode - xtal1) >> 6) + _xinfreq
        _Ms_001      = _ConClkFreq / 1_000

        'Creating safe values
        ultrasafe = 500  'safe value for ultrasonic sensors where value returned needs to be greater than this
        tofsafe   = 200  'safe value for tof sensors where value returned needs to be lesser than this

VAR    'Global Variables
  long  mainToFVal1, mainToFVal2, mainUltraVal1, mainUltraVal2, rxVal
  long  Val
  long  para

OBJ
  Term      : "FullDuplexSerial.spin"   'UART communication for debugging
  Sensor    : "SensorControl.spin"      '<-- Object / Blackbox
  Motor     : "MotorControl.spin"
  Comm      : "CommControl.spin"

PUB Main

  'Declaration and Initialisation
  'Term.Start(31,30,0,115200)
  Pause(3000) 'wait 3 seconds

  {Main function declares variables and using the addresses, the function in Sensor
  Control will perform the actions and send back the values}
  Sensor.Start(_Ms_001, @mainToFVal1, @mainToFVal2, @mainUltraVal1, @mainUltraVal2)
  Comm.Start(_Ms_001, @Val)
  Motor.Start(_Ms_001, @para)

  repeat
    'If the values from sensors are within the limits...
    if (((mainUltraVal1 > ultrasafe) and mainToFVal1 < 250) or ((mainUltraVal2 > ultrasafe) and mainToFVal2 < 250))
      case Val
        10:                      'Motors move forward
          Motor.Start(_Ms_001,1)
        11:                      'Motors move reverse
          Motor.Start(_Ms_001,2)
        12:                      'Lite Kit turns Right
          Motor.Start(_Ms_001,3)
        13:                      'Lite Kit turns Left
          Motor.Start(_Ms_001,4)
        14:                      'Lite Kit stops all motors
          Motor.Start(_Ms_001,5)

      'If the values from sensors are not within the limit...
    elseif((mainUltraVal1 < ultrasafe) and mainToFVal1 > 250) or ((mainUltraVal2 < ultrasafe) and mainToFVal2 > 250)

        Motor.Start(_Ms_001, 5)          'Stop all motors and stop lite kite





PRI Pause(ms) | t    'Pause Function

  t := cnt - 1088
  repeat(ms #> 0)
    waitcnt(t += _Ms_001)
  return
