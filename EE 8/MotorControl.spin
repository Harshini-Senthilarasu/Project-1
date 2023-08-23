{
Name       : Harshini Senthilarasu
Student ID : 2102216
File       : MotorControl
Brief      : This file contains the functions that allow the motors to move
             forward, reverse, right and left

             The fucntions that are being implemeneted are:
             1. Init(msVal,para)
             2. AllMotors(msVal,para)
             3. MotorsInit
             4. StopCore
             5. StopAllMotors
             6. Forward
             7. Reverse
             8. TurnRight
             9. Turnleft
             10. Pause(ms)
}


CON

        Motor1 = 10
        Motor2 = 11
        Motor3 = 12
        Motor4 = 13

        Motor1Zero = 1500
        Motor2Zero = 1500
        Motor3Zero = 1480
        Motor4Zero = 1480

VAR
        long Init1[64]
        long cog2ID
        long _Ms_001

OBJ
   motors      : "Servo8Fast_vZ2.spin"

PUB Init(msVal,para)    'Core 2

  _Ms_001 := msVal      'takes in the Ms value
  StopCore              'stops cog

  cog2ID := cognew(AllMotors(msVal,para),@Init1)     'cog that runs the AllMotors function
  return

PUB AllMotors(msVal,para)

  MotorsInit           'Initialising the motors
  'using case condition to select the parameter required which calls a specific motorcontrol function
  case para
    1:
      Forward
    2:
      Reverse
    3:
      TurnRight
    4:
      TurnLeft



PUB MotorsInit              'Function that inititalises the motors

  Motors.Init
  Motors.AddSlowPin(motor1)
  Motors.AddSlowPin(motor2)
  Motors.AddSlowPin(motor3)
  Motors.AddSlowPin(motor4)
  Motors.Start
  Pause(100)

PUB StopCore   'Stops the cog from running if cog2ID is called

  if cog2ID
   cogstop(cog2ID~)


PUB StopAllMotors    'Function sets the motors to its zero value speed such that they stop

  Motors.Set(motor1, 1500)
  Motors.Set(motor2, 1500)
  Motors.Set(motor3, 1480)
  Motors.Set(motor4, 1480)

PUB Forward | i   'Function allows motors to move forward at increments of 10 from 0 to 200

  repeat i from 0 to 200 step 10
    Motors.Set(motor1, motor1Zero+i)
    Motors.Set(motor2, motor2Zero+i)
    Motors.Set(motor3, motor3Zero+i)
    Motors.Set(motor4, motor4Zero+i)
    Pause(100)


PUB Reverse | i    'Function allows motors to move backwards at increments of 10 from 0 to 200

  repeat i from 0 to 200 step 10
    Motors.Set(motor1, motor1Zero-i)
    Motors.Set(motor2, motor2Zero-i)
    Motors.Set(motor3, motor3Zero-i)
    Motors.Set(motor4, motor4Zero-i)
    Pause(100)



PUB TurnRight | i 'Function allows motors to turn rught at increments of 9 from 0 to 150

  repeat i from 0 to 150 step 9
    Motors.Set(motor1, motor1Zero-i)
    Motors.Set(motor2, motor2Zero+i)
    Motors.Set(motor3, motor3Zero-i)
    Motors.Set(motor4, motor4Zero+i)
    Pause(100)


PUB Turnleft | i   'Function allows motors to turn left at increments of 9 from 0 to 150

  repeat i from 0 to 150 step 10 '10%
    Motors.Set(motor1, motor1Zero+i)
    Motors.Set(motor2, motor2Zero-i)
    Motors.Set(motor3, motor3Zero+i)
    Motors.Set(motor4, motor4Zero-i)
    Pause(100)


PRI Pause(ms) | t    'Pause Function

  t := cnt - 1088
  repeat(ms #> 0)
    waitcnt(t += _Ms_001)
  return