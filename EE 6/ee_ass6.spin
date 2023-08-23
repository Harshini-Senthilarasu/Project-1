{

  Project: EE-6 Assignment
  Platform: Parallax Project USB Board, Lit Kit
  Revision: 1.1
  Author: Harshini
  Date: 7th Nov 2021
  Log:

}


CON
        _clkmode = xtal1 + pll16x                                               'Standard clock mode * crystal frequency = 80 MHz
        _xinfreq = 5_000_000

        _ConClkFreq = ((_clkmode - xtal1) >> 6) * _xinfreq
        _Ms_001 = _ConClkFreq / 1_000

        motor1 = 10
        motor2 = 11
        motor3 = 12
        motor4 = 13

        motor1Zero = 1500
        motor2Zero = 1500
        motor3Zero = 1480
        motor4Zero = 1480

VAR
  long  motor1CoreStack[64], motor2CoreStack[64], motor3CoreStack[64], motor4CoreStack[64]
  long  cog1ID, cog2ID, cog3ID, cog4ID

OBJ
  Motors      : "Servo8Fast_vZ2.spin"
  Term        : "FullDuplexSerial.spin"

PUB Main      |i,k

  Motors.AddSlowPin(motor1)
  Motors.AddSlowPin(motor2)
  Motors.AddSlowPin(motor3)
  Motors.AddSlowPin(motor4)

  Init

  Motors.Start

  StopAllMotors

  Pause(100)
  repeat k from 0 to 9
    case(k)
      0:
        Forward
      1:
        TurnRight(i)
      2:
        Forward
      3:
        TurnLeft(i)
      4:
        Forward
      5:
        Reverse
      6:
        TurnRight(-i)
      7:
        Reverse
      8:
        TurnLeft(-i)
      9:
        Reverse

  StopAllMotors
  StopCore


PUB Init

  cog1ID := cognew(motor1Set, @motor1CoreStack) + 1
  cog2ID := cognew(motor2Set, @motor2CoreStack) + 1
  cog3ID := cognew(motor3Set, @motor3CoreStack) + 1
  cog4ID := cognew(motor4Set, @motor4CoreStack) + 1

PUB motor1Set
Motors.Set(motor1, motor1Zero)

PUB motor2Set
Motors.Set(motor2, motor2Zero)

PUB motor3Set
Motors.Set(motor3, motor3Zero)

PUB motor4Set
Motors.Set(motor4, motor4Zero)

PUB Forward | i
  repeat i from 0 to 300 step 15
    Motors.Set(motor1, motor1Zero+i)
    Motors.Set(motor2, motor2Zero+i)
    Motors.Set(motor3, motor3Zero+i)
    Motors.Set(motor4, motor4Zero+i)
  Pause(1000)
  StopAllMotors

PUB TurnRight(i)
  repeat i from 0 to 200 step 20 '10%
    Motors.Set(motor1, motor1Zero-i)
    Motors.Set(motor2, motor2Zero+i)
    Motors.Set(motor3, motor3Zero-i)
    Motors.Set(motor4, motor4Zero+i)

  Pause(1000)
  StopAllMotors

PUB TurnLeft(i)


    repeat i from 0 to 200 step 20 '10%
      Motors.Set(motor1, motor1Zero+i)
      Motors.Set(motor2, motor2Zero-i)
      Motors.Set(motor3, motor3Zero+i)
      Motors.Set(motor4, motor4Zero-i)

  Pause(1000)
  StopAllMotors

PUB Reverse   | i

    repeat i from 0 to 300 step 15 '10%
      Motors.Set(motor1, motor1Zero-i)
      Motors.Set(motor2, motor2Zero-i)
      Motors.Set(motor3, motor3Zero-i)
      Motors.Set(motor4, motor4Zero-i)

  Pause(1000)
  StopAllMotors

PUB StopAllMotors

  Motors.Set(motor1, motor1Zero)
  Motors.Set(motor2, motor2Zero)
  Motors.Set(motor3, motor3Zero)
  Motors.Set(motor4, motor4Zero)
  Pause(1000)

PUB StopCore
  cogstop(cog1ID)
  cogstop(cog2ID)
  cogstop(cog3ID)
  cogstop(cog4ID)

PRI Pause(ms) | t
  t := cnt - 1088
  repeat (ms #> 0)
    waitcnt(t += _MS_001)
  return


