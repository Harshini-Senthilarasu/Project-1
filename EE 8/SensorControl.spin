{
Name       : Harshini Senthilarasu
Student ID : 2102216
File       : SensorControl
Brief      : This file contains the functions for intialising the sensors and reading
             the values from the ultrasonic sensors and time of flights

             Functions that are being implemented are:
             1. Start(mainMSVal,mainToFAdd1, mainToFAdd2, mainUltraAdd1, mainUltraAdd2)
             2. Sensors(mainToFAdd1, mainToFAdd2, mainUltraAdd1, mainUltraAdd2)
             3. StopCore
             4. Init_ToF
             5. ReadUltraSonic(mainUltraAdd1, mainultraAdd2)
             6. ReadToF(mainToFAdd1, mainToFAdd2)
             7. Pause(ms)
}

CON
        'Pin numbers
        ultrascl1 = 6
        ultrasda1 = 7

        ultrascl2 = 8
        ultrasda2 = 9

        tofscl1 = 0
        tofsda1 = 1
        tofgp1  = 14

        tofscl2 = 2
        tofsda2 = 3
        tofgp2  = 15
        tofadd  = $29

VAR
  long  cogStack[256]
  long  cog1ID
  long  _Ms_001

OBJ
  ultra         : "EE-7_Ultra_v2.spin"
  ToF[2]        : "EE-7_ToF.spin"

PUB Init(mainMSVal,mainToFAdd1, mainToFAdd2, mainUltraAdd1, mainUltraAdd2)        'Core 1

  _Ms_001 := mainMSVal       'Ms Value for Pause function
  StopCore                   'Stops cog

  cog1ID := cognew(Sensors(mainToFAdd1, mainToFAdd2, mainUltraAdd1, mainUltraAdd2),@cogStack)   'cog that runs the Sensors function

  return

PUB Sensors(mainToFAdd1, mainToFAdd2, mainUltraAdd1, mainUltraAdd2)               'Sensor function

  Init_ToF

  repeat
    ReadUltraSonic(mainUltraAdd1, mainUltraAdd2)         'reads values from ultrasonic sensor
    ReadToF(mainToFAdd1, mainToFAdd2)                    'reads values from time of flight
    Pause(50)

PUB StopCore               'if it is cog1ID then it will stop

  if cog1ID
    cogstop(cog1ID~)

PUB Init_ToF                 'initialisation of time of flights

  ToF[0].Init(tofscl1, tofsda1, tofgp1)
  ToF[0].ChipReset(1)
  Pause(1000)
  ToF[0].FreshReset(tofadd)
  ToF[0].MandatoryLoad(tofadd)
  ToF[0].RecommendedLoad(tofadd)
  ToF[0].FreshReset(tofadd)

  ToF[1].Init(tofscl2, tofsda2, tofgp2)
  ToF[1].ChipReset(1)
  Pause(1000)
  ToF[1].FreshReset(tofadd)
  ToF[1].MandatoryLoad(tofadd)
  ToF[1].RecommendedLoad(tofadd)
  ToF[1].FreshReset(tofadd)


PUB ReadUltraSonic(mainUltraAdd1, mainultraAdd2)         'Function that initialises and reads ultrasonic sensors

  'Initialisation of ultrasonic sensors
  Ultra.Init(ultrascl1,ultrasda1,0)
  Pause(50)
  Ultra.Init(ultrascl2,ultrasda2,1)

  'pointers which store the values that are read by the ultrasonic sensors
  long[mainUltraAdd1] := Ultra.readSensor(0)
  long[mainultraAdd2] := Ultra.readSensor(1)

PUB ReadToF(mainToFAdd1, mainToFAdd2)                   'Function that reads time of flights

'pointers which store the values that are read by the time of flights
  long[mainToFAdd1] := ToF[0].GetSingleRange(tofadd)
  long[mainToFAdd2] := ToF[1].GetSingleRange(tofadd)

PRI Pause(ms) | t             'Pause Function

  t := cnt - 1088
  repeat(ms #> 0)
    waitcnt(t += _Ms_001)
  return
