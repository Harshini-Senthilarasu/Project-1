{

  Project: EE-7 assignment
  Platform: Parallax Project USB Board, Lit Kit
  Revision: 1.1
  Author: Harshini
  Date: 15th Nov 2021
  Log:
        Sensors work using cog

}

CON
        _clkmode = xtal1 + pll16x                                               'Standard clock mode * crystal frequency = 80 MHz
        _xinfreq = 5_000_000

        _ConClkFreq = ((_clkmode - xtal1) >> 6) * _xinfreq
        _Ms_001 = _ConClkFreq / 1_000

        ultrascl1 = 6
        ultrascl2 = 8

        ultrasda1 = 7
        ultrasda2 = 9

        tofscl1 = 0
        tofscl2 = 2

        tofsda1 = 1
        tofsda2 = 3

        tofgp1  = 14
        tofgp2  = 15

        tofadd  = $29

VAR
  long  Init1[64]
  long  cog1ID

OBJ
  ultra         : "EE-7_Ultra_v2.spin"
  Term          : "FullDuplexSerial.spin"
  ToF[2]        : "EE-7_ToF.spin"

PUB Init(para)

    case(para)
      1:
        cog1ID := cognew(ReadUltraSensor(0),@Init1)
      2:
        cog1ID := cognew(ReadUltraSensor(1),@Init1)
      3:
        cog1ID := cognew(ReadToF(0),@Init1)
      4:
        cog1ID := cognew(ReadToF(1),@Init1)


PUB StopCore

  cogstop(cog1ID)

PUB ReadUltraSensor(para) | testVal1, testVal2

  Term.Start(31,30,0,115200)
  Pause(3000)

  if para == 0
      ultra.Init(ultrascl1, ultrasda1, 0)
      testVal1 := ultra.readSensor(0)
      Term.Str(String(13,"Ultra 1 "))
      Term.Dec(testVal1)
      Pause(50)
      return testval1

  if para == 1
      ultra.Init(ultrascl2, ultrasda2, 1)
      testVal2 := ultra.readSensor(1)
      Term.Str(String(13,"Ultra 2 "))
      Term.Dec(testVal2)
      Pause(50)
      return testval2

PUB ReadToF(para) | tofVal1, tofVal2

  Term.Start(31,30,0,115200)
  Pause(3000)

  if para == 0
      ToF[0].Init(tofscl1, tofsda1, tofgp1)
      ToF[0].ChipReset(1)
      Pause(1000)
      ToF[0].FreshReset(tofadd)
      ToF[0].MandatoryLoad(tofadd)
      ToF[0].RecommendedLoad(tofadd)
      ToF[0].FreshReset(tofadd)
      tofVal1 := ToF[0].GetSingleRange(tofadd)
      Term.Str(String(13, "Tof value 1: "))
      Term.Dec(tofVal1)
      Pause(50)
      return tofVal1

  if para == 1
    ToF[1].Init(tofscl2, tofsda2, tofgp2)
    ToF[1].ChipReset(1)
    Pause(1000)
    ToF[1].FreshReset(tofadd)
    ToF[1].MandatoryLoad(tofadd)
    ToF[1].RecommendedLoad(tofadd)
    ToF[1].FreshReset(tofadd)
    tofVal2 := ToF[1].GetSingleRange(tofadd)
    Term.Str(String(13, "Tof value 2: "))
    Term.Dec(tofVal2)
    Pause(50)
    return tofVal2

PRI Pause(ms) | t

  t := cnt - 1088
  repeat(ms #> 0)
    waitcnt(t += _Ms_001)
  return