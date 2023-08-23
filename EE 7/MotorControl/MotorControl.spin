{

  Project: EE-7 assignment
  Platform: Parallax Project USB Board, Lit Kit
  Revision: 1.1
  Author: Harshini
  Date: 15th Nov 2021
  Log:
        Motors work using cog function.

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

        motor1Zero = 1500 'Zero: 1460-1490 Forward: 1000-1450 Backward: 1500-1900
        motor2Zero = 1500 'Zero: 1460-1490 Forward: 1000-1450 Backward: 1500-1900
        motor3Zero = 1480 'Zero: 1460-1490 Forward: 1000-1450 Backward: 1500-1900
        motor4Zero = 1480 'Zero: 1460-1490 Forward: 1000-1450 Backward: 1500-1900

VAR
        long Init1[64], Init2[64]
        long cog1ID, cog2ID
        long mainCmdAdd

OBJ
  motors      : "Servo8Fast_vZ2.spin"
  term        : "FullDuplexSerial.spin"



PUB Init(para)  | i          ' this function initializes or starts the motor pins

  Motors.Init
  Motors.AddSlowPin(motor1)
  Motors.AddSlowPin(motor2)
  Motors.AddSlowPin(motor3)
  Motors.AddSlowPin(motor4)
  Motors.Start
  Pause(100)

   case (para)
    1:
      cog1ID := cognew(Forward, @Init1)
    2:
      cog1ID := cognew(Reverse, @Init1)

PUB StopCore   'this function takes in a parameter that stops the cog from running

   cogstop(cog1ID)



PUB StopAllMotors    'this function stores the zero values of all the motors. when this function is called, it stops the motors

  Motors.Set(motor1, 1500)
  Motors.Set(motor2, 1500)
  Motors.Set(motor3, 1480)
  Motors.Set(motor4, 1480)

PUB Forward | i   'this function moves the wheels from 0 to 200 with a increment of 10, hence the step is 5% (200/100*)

  repeat  1
    repeat i from 0 to 200 step 10
      Motors.Set(motor1, motor1Zero+i)
      Motors.Set(motor2, motor2Zero+i)
      Motors.Set(motor3, motor3Zero+i)
      Motors.Set(motor4, motor4Zero+i)
      'Pause(100)

  'Pause(1000)

PUB  TurnRight(para) | i   'this function makes the wheels turn right from 0 to 150 with a increment of 9, hence the step is 6%

  if para == 0

    repeat
        repeat i from 0 to 200 step 10
          Motors.Set(motor1, motor1Zero-i)
          Motors.Set(motor2, motor2Zero+i)
          Motors.Set(motor3, motor3Zero-i)
          Motors.Set(motor4, motor4Zero+i)
          Pause(100)




  if para == 1
        repeat
            repeat i from 0 to 200 step 10
              Motors.Set(motor1, motor1Zero-i)
              Motors.Set(motor2, motor2Zero+i)
              Motors.Set(motor3, motor3Zero-i)
              Motors.Set(motor4, motor4Zero+i)
              Pause(100)

  Pause(1000)



PUB TurnLeft(para) | i     'this function makes the wheels turn left from 0 to 150 with a increment of 10, hence the step is 6.6667%

  if para == 0
    repeat
            repeat i from 0 to 200 step 10 '10%
              Motors.Set(motor1, motor1Zero+i)
              Motors.Set(motor2, motor2Zero-i)
              Motors.Set(motor3, motor3Zero+i)
              Motors.Set(motor4, motor4Zero-i)
              Pause(100)


  if para == 1
    repeat 1
            repeat i from 0 to 200 step 10
              Motors.Set(motor1, motor1Zero+i)
              Motors.Set(motor2, motor2Zero-i)
              Motors.Set(motor3, motor3Zero+i)
              Motors.Set(motor4, motor4Zero-i)
              Pause(100)

  Pause(1000)



PUB Reverse | i    'this function makes the wheels turn in reverse from 0 to 200 with a step of 10, hence the step is 5%

  repeat 1
      repeat i from 0 to 300 step 15
        Motors.Set(motor1, motor1Zero-i)
        Motors.Set(motor2, motor2Zero-i)
        Motors.Set(motor3, motor3Zero-i)
        Motors.Set(motor4, motor4Zero-i)
        Pause(100)

  Pause(1000)




PRI Pause(ms) | t

  t := cnt - 1088
  repeat(ms #> 0)
    waitcnt(t += _Ms_001)
  return