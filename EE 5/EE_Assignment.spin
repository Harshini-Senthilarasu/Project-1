{

  Project: EE-5 Assignment
  Platform: Parallax Project USE Board
  Revision: 1.1
  Author: Harshini
  Date: 25th Oct 2021
  Log:
        Date: Desc
        25/10/2021: Adding the 7-segment and displaying
        numbers from 0 to 9 with a pause period of 300ms
}


CON
        _clkmode = xtal1 + pll16x                                               'Standard clock mode * crystal frequency = 80 MHz
        _xinfreq = 5_000_000


OBJ
  Full: "FullDuplexSerial.spin"

PUB Main

  DIRA[0..7]~~
  OUTA[0..7]~

  Full.Start(31, 30, 0, 115200)

  repeat
    waitcnt(cnt + (clkfreq / 10)*3)
    OUTA[0..7] := %11111100           '0
    waitcnt(cnt + (clkfreq / 10)*3)
    OUTA[0..7] := %01100000           '1
    waitcnt(cnt + (clkfreq / 10)*3)
    OUTA[0..7] := %11011010           '2
    waitcnt(cnt + (clkfreq / 10)*3)
    OUTA[0..7] := %11110010           '3
    waitcnt(cnt + (clkfreq / 10)*3)
    OUTA[0..7] := %01100110           '4
    waitcnt(cnt + (clkfreq / 10)*3)
    OUTA[0..7] := %10110110           '5
    waitcnt(cnt + (clkfreq / 10)*3)
    OUTA[0..7] := %10111110           '6
    waitcnt(cnt + (clkfreq / 10)*3)
    OUTA[0..7] := %11100000           '7
    waitcnt(cnt + (clkfreq / 10)*3)
    OUTA[0..7] := %11111110           '8
    waitcnt(cnt + (clkfreq / 10)*3)
    OUTA[0..7] := %11110110           '9



