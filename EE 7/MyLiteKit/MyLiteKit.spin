{

  Project: EE-7 assignment
  Platform: Parallax Project USB Board, Lit Kit
  Revision: 1.1
  Author: Harshini
  Date: 15th Nov 2021
  Log:

}


CON
        _clkmode = xtal1 + pll16x                                               'Standard clock mode * crystal frequency = 80 MHz
        _xinfreq = 5_000_000

        _ConClkFreq = ((_clkmode - xtal1) >> 6) * _xinfreq
        _Ms_001 = _ConClkFreq / 1_000

VAR
  long  Init1[64], Init2[64], Init3[64]
  long  cog1ID, cog2ID, cog3ID

OBJ
  SensorCtrl      : "SensorControl.spin"
  MotorCtrl       : "MotorControl.spin"
  Term     : "FullDuplexSerial.spin"

PUB Main | vals

  'Term.Start(31,30,0,115200)
  'Pause(3000)

  MotorCtrl.Init(1)

  vals := SensorCtrl.Init(1)

  if vals < 60
    MotorCtrl.StopAllMotors
    MotorCtrl.StopCore





PRI Pause(ms) | t

  t := cnt - 1088
  repeat(ms #> 0)
    waitcnt(t += _Ms_001)
  return