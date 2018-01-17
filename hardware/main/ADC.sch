EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:xilinx-spartan6
LIBS:active_components_lib
LIBS:my
LIBS:main-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 3 5
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L AD92x8 U301
U 1 1 55E6BC54
P 1800 1700
F 0 "U301" H 2200 750 60  0000 C CNN
F 1 "AD92x8" H 1500 2600 60  0000 C CNN
F 2 "Housings_QFP:LQFP-64_7x7mm_Pitch0.4mm" H 1850 2000 60  0001 C CNN
F 3 "" H 1850 2000 60  0000 C CNN
	1    1800 1700
	1    0    0    -1  
$EndComp
$Comp
L AD92x8 U301
U 2 1 55E6BD23
P 1800 3950
F 0 "U301" H 2200 3000 60  0000 C CNN
F 1 "AD92x8" H 1500 4850 60  0000 C CNN
F 2 "Housings_QFP:LQFP-64_7x7mm_Pitch0.4mm" H 1850 4250 60  0001 C CNN
F 3 "" H 1850 4250 60  0000 C CNN
	2    1800 3950
	1    0    0    -1  
$EndComp
$Comp
L AD92x8 U301
U 3 1 55E6BDEC
P 2300 6550
F 0 "U301" H 2950 5950 60  0000 C CNN
F 1 "AD92x8" H 2350 7200 60  0000 C CNN
F 2 "Housings_QFP:LQFP-64_7x7mm_Pitch0.4mm" H 2350 6850 60  0001 C CNN
F 3 "" H 2350 6850 60  0000 C CNN
	3    2300 6550
	1    0    0    -1  
$EndComp
$Comp
L GNDA #PWR025
U 1 1 55E6C933
P 1900 7350
F 0 "#PWR025" H 1900 7100 50  0001 C CNN
F 1 "GNDA" H 1900 7200 50  0000 C CNN
F 2 "" H 1900 7350 60  0000 C CNN
F 3 "" H 1900 7350 60  0000 C CNN
	1    1900 7350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR026
U 1 1 55E6C9E1
P 2600 7350
F 0 "#PWR026" H 2600 7100 50  0001 C CNN
F 1 "GND" H 2600 7200 50  0000 C CNN
F 2 "" H 2600 7350 60  0000 C CNN
F 3 "" H 2600 7350 60  0000 C CNN
	1    2600 7350
	1    0    0    -1  
$EndComp
$Comp
L +3.3VADC #PWR027
U 1 1 55E6CB6B
P 1850 5650
F 0 "#PWR027" H 2000 5600 50  0001 C CNN
F 1 "+3.3VADC" H 1850 5750 50  0000 C CNN
F 2 "" H 1850 5650 60  0000 C CNN
F 3 "" H 1850 5650 60  0000 C CNN
	1    1850 5650
	1    0    0    -1  
$EndComp
$Comp
L GNDA #PWR028
U 1 1 55E6D9F6
P 1150 7250
F 0 "#PWR028" H 1150 7000 50  0001 C CNN
F 1 "GNDA" H 1150 7100 50  0000 C CNN
F 2 "" H 1150 7250 60  0000 C CNN
F 3 "" H 1150 7250 60  0000 C CNN
	1    1150 7250
	1    0    0    -1  
$EndComp
$Comp
L C C306
U 1 1 55E6DBEE
P 1150 6900
F 0 "C306" H 1175 7000 50  0000 L CNN
F 1 "4.7u" H 1175 6800 50  0000 L CNN
F 2 "Resistors_SMD:R_0805" H 1188 6750 30  0001 C CNN
F 3 "" H 1150 6900 60  0000 C CNN
	1    1150 6900
	1    0    0    -1  
$EndComp
$Comp
L C C304
U 1 1 55E6DC4D
P 900 6900
F 0 "C304" H 925 7000 50  0000 L CNN
F 1 "0.47u" H 925 6800 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 938 6750 30  0001 C CNN
F 3 "" H 900 6900 60  0000 C CNN
	1    900  6900
	1    0    0    -1  
$EndComp
$Comp
L R R301
U 1 1 55E6DD09
P 1400 7000
F 0 "R301" V 1480 7000 50  0000 C CNN
F 1 "100k" V 1400 7000 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 1330 7000 30  0001 C CNN
F 3 "" H 1400 7000 30  0000 C CNN
	1    1400 7000
	1    0    0    -1  
$EndComp
$Comp
L C C302
U 1 1 55E6E2AF
P 650 6900
F 0 "C302" H 675 7000 50  0000 L CNN
F 1 "0.47u" H 675 6800 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 688 6750 30  0001 C CNN
F 3 "" H 650 6900 60  0000 C CNN
	1    650  6900
	1    0    0    -1  
$EndComp
$Comp
L C C301
U 1 1 55E6E373
P 650 6400
F 0 "C301" H 675 6500 50  0000 L CNN
F 1 "0.47u" H 675 6300 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 688 6250 30  0001 C CNN
F 3 "" H 650 6400 60  0000 C CNN
	1    650  6400
	1    0    0    -1  
$EndComp
$Comp
L C C303
U 1 1 55E6E3D9
P 900 6400
F 0 "C303" H 925 6500 50  0000 L CNN
F 1 "0.47u" H 925 6300 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 938 6250 30  0001 C CNN
F 3 "" H 900 6400 60  0000 C CNN
	1    900  6400
	1    0    0    -1  
$EndComp
$Comp
L C C305
U 1 1 55E6E423
P 1150 6400
F 0 "C305" H 1175 6500 50  0000 L CNN
F 1 "4.7u" H 1175 6300 50  0000 L CNN
F 2 "Resistors_SMD:R_0805" H 1188 6250 30  0001 C CNN
F 3 "" H 1150 6400 60  0000 C CNN
	1    1150 6400
	1    0    0    -1  
$EndComp
$Comp
L R R302
U 1 1 55E6EBE1
P 3300 5900
F 0 "R302" V 3380 5900 50  0000 C CNN
F 1 "100k" V 3300 5900 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 3230 5900 30  0001 C CNN
F 3 "" H 3300 5900 30  0000 C CNN
	1    3300 5900
	1    0    0    -1  
$EndComp
$Comp
L R R303
U 1 1 55E708B0
P 3500 5900
F 0 "R303" V 3580 5900 50  0000 C CNN
F 1 "100k" V 3500 5900 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 3430 5900 30  0001 C CNN
F 3 "" H 3500 5900 30  0000 C CNN
	1    3500 5900
	1    0    0    -1  
$EndComp
Text Notes 3400 6250 0    60   ~ 0
Termination required
$Comp
L +3.3VADC #PWR029
U 1 1 55E86E4C
P 3300 5600
F 0 "#PWR029" H 3450 5550 50  0001 C CNN
F 1 "+3.3VADC" H 3300 5700 50  0000 C CNN
F 2 "" H 3300 5600 60  0000 C CNN
F 3 "" H 3300 5600 60  0000 C CNN
	1    3300 5600
	1    0    0    -1  
$EndComp
Text Notes 700  2700 0    60   ~ 0
Termination required
$Comp
L XC6SLX25-FTG256 U203
U 2 1 55F1C736
P 7150 3600
F 0 "U203" H 7150 3650 50  0000 C CNN
F 1 "XC6SLX25-FTG256" H 7150 3550 50  0000 C CNN
F 2 "my:BGA-256_pitch1mm_dia0.4mm" H 7150 3600 50  0001 C CNN
F 3 "" H 7150 3600 50  0000 C CNN
	2    7150 3600
	-1   0    0    -1  
$EndComp
Text GLabel 1050 2500 0    40   Input ~ 0
ADC_CLK_A
Text GLabel 1050 4750 0    40   Input ~ 0
ADC_CLK_B
Text Label 2600 1200 0    60   ~ 0
D_A0
Text Label 2600 1300 0    60   ~ 0
D_A1
Text Label 2600 1400 0    60   ~ 0
D_A2
Text Label 2600 1500 0    60   ~ 0
D_A3
Text Label 2600 1600 0    60   ~ 0
D_A4
Text Label 2600 1700 0    60   ~ 0
D_A5
Text Label 2600 1800 0    60   ~ 0
D_A6
Text Label 2600 1900 0    60   ~ 0
D_A7
Text Label 2600 2000 0    60   ~ 0
D_A8
Text Label 2600 2100 0    60   ~ 0
D_A9
Text Label 2600 2200 0    60   ~ 0
D_A10
Text Label 2600 2300 0    60   ~ 0
D_A11
Text Label 2600 2400 0    60   ~ 0
D_A12
Text Label 2600 2500 0    60   ~ 0
D_A13
Text Label 4600 3500 0    60   ~ 0
D_A0
Text Label 4600 3400 0    60   ~ 0
D_A1
Text Label 4600 3700 0    60   ~ 0
D_A2
Text Label 4600 3600 0    60   ~ 0
D_A3
Text Label 4600 4900 0    60   ~ 0
D_A4
Text Label 4600 4800 0    60   ~ 0
D_A5
Text Label 4600 5500 0    60   ~ 0
D_A6
Text Label 4600 5600 0    60   ~ 0
D_A7
Text Label 4600 5300 0    60   ~ 0
D_A8
Text Label 4600 5700 0    60   ~ 0
D_A9
Text Label 4600 6000 0    60   ~ 0
D_A10
Text Label 4600 6100 0    60   ~ 0
D_A11
Text Label 4600 6800 0    60   ~ 0
D_A12
Text Label 4600 6900 0    60   ~ 0
D_A13
Text Label 2600 3250 0    60   ~ 0
OTR_B
Text Label 2600 3450 0    60   ~ 0
D_B0
Text Label 2600 3550 0    60   ~ 0
D_B1
Text Label 2600 3650 0    60   ~ 0
D_B2
Text Label 2600 3750 0    60   ~ 0
D_B3
Text Label 2600 3850 0    60   ~ 0
D_B4
Text Label 2600 3950 0    60   ~ 0
D_B5
Text Label 2600 4050 0    60   ~ 0
D_B6
Text Label 2600 4150 0    60   ~ 0
D_B7
Text Label 2600 4250 0    60   ~ 0
D_B8
Text Label 2600 4350 0    60   ~ 0
D_B9
Text Label 2600 4450 0    60   ~ 0
D_B10
Text Label 2600 4550 0    60   ~ 0
D_B11
Text Label 2600 4650 0    60   ~ 0
D_B12
Text Label 2600 4750 0    60   ~ 0
D_B13
Text Label 4600 6300 0    60   ~ 0
OTR_B
Text Label 4600 2000 0    60   ~ 0
D_B0
Text Label 4600 2100 0    60   ~ 0
D_B1
Text Label 4600 2200 0    60   ~ 0
D_B2
Text Label 4600 2300 0    60   ~ 0
D_B3
Text Label 4600 2500 0    60   ~ 0
D_B4
Text Label 4600 2400 0    60   ~ 0
D_B5
Text Label 4600 2700 0    60   ~ 0
D_B6
Text Label 4600 2600 0    60   ~ 0
D_B7
Text Label 4600 2900 0    60   ~ 0
D_B8
Text Label 4600 4000 0    60   ~ 0
D_B9
Text Label 4600 3100 0    60   ~ 0
D_B10
Text Label 4600 3000 0    60   ~ 0
D_B11
Text Label 4600 3300 0    60   ~ 0
D_B12
Text Label 4600 3200 0    60   ~ 0
D_B13
Text GLabel 4600 3800 0    40   Input ~ 0
ADC_CLK_FPGA
Text Label 9250 4200 0    60   ~ 0
DCS
Text Label 9250 4300 0    60   ~ 0
DFS
Text Label 9250 4900 0    60   ~ 0
OEB_B
Text Label 9250 4800 0    60   ~ 0
PDWN_B
Text Notes 2550 3300 0    60   ~ 0
Termination required
Text Label 1050 4550 2    60   ~ 0
PDWN_B
Text Label 1050 4650 2    60   ~ 0
OEB_B
Text Label 3600 6350 0    60   ~ 0
DCS
Text Label 3600 6650 0    60   ~ 0
DFS
$Comp
L C C310
U 1 1 55EEF23C
P 4700 950
F 0 "C310" H 4725 1050 50  0000 L CNN
F 1 "0.47u" H 4725 850 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 4738 800 30  0001 C CNN
F 3 "" H 4700 950 60  0000 C CNN
	1    4700 950 
	1    0    0    -1  
$EndComp
$Comp
L C C309
U 1 1 55EEF2DD
P 4450 950
F 0 "C309" H 4475 1050 50  0000 L CNN
F 1 "0.47u" H 4475 850 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 4488 800 30  0001 C CNN
F 3 "" H 4450 950 60  0000 C CNN
	1    4450 950 
	1    0    0    -1  
$EndComp
$Comp
L C C308
U 1 1 55EEF333
P 4200 950
F 0 "C308" H 4225 1050 50  0000 L CNN
F 1 "0.47u" H 4225 850 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 4238 800 30  0001 C CNN
F 3 "" H 4200 950 60  0000 C CNN
	1    4200 950 
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR030
U 1 1 55EEF87F
P 4200 1200
F 0 "#PWR030" H 4200 950 50  0001 C CNN
F 1 "GND" H 4200 1050 50  0000 C CNN
F 2 "" H 4200 1200 60  0000 C CNN
F 3 "" H 4200 1200 60  0000 C CNN
	1    4200 1200
	1    0    0    -1  
$EndComp
$Comp
L C C314
U 1 1 55EF0F2A
P 9300 950
F 0 "C314" H 9325 1050 50  0000 L CNN
F 1 "0.47u" H 9325 850 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 9338 800 30  0001 C CNN
F 3 "" H 9300 950 60  0000 C CNN
	1    9300 950 
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR031
U 1 1 55EF0F3C
P 9300 1200
F 0 "#PWR031" H 9300 950 50  0001 C CNN
F 1 "GND" H 9300 1050 50  0000 C CNN
F 2 "" H 9300 1200 60  0000 C CNN
F 3 "" H 9300 1200 60  0000 C CNN
	1    9300 1200
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR032
U 1 1 55EF18DA
P 8450 700
F 0 "#PWR032" H 8450 550 50  0001 C CNN
F 1 "+3.3V" H 8450 840 50  0000 C CNN
F 2 "" H 8450 700 60  0000 C CNN
F 3 "" H 8450 700 60  0000 C CNN
	1    8450 700 
	1    0    0    -1  
$EndComp
$Comp
L 25_Serial_Flash_8_Pin U302
U 1 1 55EF7FC5
P 10300 5900
F 0 "U302" H 10550 5600 60  0000 C CNN
F 1 "25_Serial_Flash_8_Pin" H 10300 6200 60  0000 C CNN
F 2 "Housings_SOIC:SOIJ-8_5.3x5.3mm_Pitch1.27mm" H 10300 5900 60  0001 C CNN
F 3 "" H 10300 5900 60  0000 C CNN
	1    10300 5900
	-1   0    0    1   
$EndComp
$Comp
L +3.3V #PWR033
U 1 1 55EFAA37
P 10950 6150
F 0 "#PWR033" H 10950 6000 50  0001 C CNN
F 1 "+3.3V" H 10950 6290 50  0000 C CNN
F 2 "" H 10950 6150 60  0000 C CNN
F 3 "" H 10950 6150 60  0000 C CNN
	1    10950 6150
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR034
U 1 1 55EFAC22
P 10950 5650
F 0 "#PWR034" H 10950 5400 50  0001 C CNN
F 1 "GND" H 10950 5500 50  0000 C CNN
F 2 "" H 10950 5650 60  0000 C CNN
F 3 "" H 10950 5650 60  0000 C CNN
	1    10950 5650
	-1   0    0    1   
$EndComp
$Comp
L C C316
U 1 1 55EFAF6E
P 11100 5900
F 0 "C316" H 11125 6000 50  0000 L CNN
F 1 "0.47u" H 11125 5800 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 11138 5750 30  0001 C CNN
F 3 "" H 11100 5900 60  0000 C CNN
	1    11100 5900
	1    0    0    -1  
$EndComp
Text Notes 10050 6350 0    60   ~ 0
6Meg bits +
$Comp
L R R305
U 1 1 55EFFF5D
P 9500 5850
F 0 "R305" V 9580 5850 50  0000 C CNN
F 1 "100" V 9500 5850 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 9430 5850 30  0001 C CNN
F 3 "" H 9500 5850 30  0000 C CNN
	1    9500 5850
	0    1    1    0   
$EndComp
$Comp
L R R308
U 1 1 55F00741
P 11000 4300
F 0 "R308" V 11080 4300 50  0000 C CNN
F 1 "2.4k" V 11000 4300 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 10930 4300 30  0001 C CNN
F 3 "" H 11000 4300 30  0000 C CNN
	1    11000 4300
	-1   0    0    1   
$EndComp
$Comp
L R R309
U 1 1 55F008CD
P 11000 4700
F 0 "R309" V 11080 4700 50  0000 C CNN
F 1 "2.4k" V 11000 4700 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 10930 4700 30  0001 C CNN
F 3 "" H 11000 4700 30  0000 C CNN
	1    11000 4700
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR035
U 1 1 55F0147F
P 11000 4900
F 0 "#PWR035" H 11000 4650 50  0001 C CNN
F 1 "GND" H 11000 4750 50  0000 C CNN
F 2 "" H 11000 4900 60  0000 C CNN
F 3 "" H 11000 4900 60  0000 C CNN
	1    11000 4900
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR036
U 1 1 55F015DE
P 11000 4050
F 0 "#PWR036" H 11000 3900 50  0001 C CNN
F 1 "+3.3V" H 11000 4190 50  0000 C CNN
F 2 "" H 11000 4050 60  0000 C CNN
F 3 "" H 11000 4050 60  0000 C CNN
	1    11000 4050
	1    0    0    -1  
$EndComp
Text Label 9200 1600 0    60   ~ 0
CLK
Text Label 9200 2000 0    60   ~ 0
DO
Text Label 9200 2100 0    60   ~ 0
DI
Text Label 9750 6050 2    60   ~ 0
CS
Text Label 9200 5300 0    60   ~ 0
CS
Text Label 9750 5950 2    60   ~ 0
CLK
Text Label 9750 5750 2    60   ~ 0
DI
Text Label 9300 5850 2    60   ~ 0
DO
Text Label 11000 4500 0    60   ~ 0
CLK
Text Notes 9750 5500 0    60   ~ 0
CLK Term Res\nDO Term Res\nNeed close to FLASH
Text Label 9200 5200 0    60   ~ 0
INIT_B
Text Label 9200 2400 0    60   ~ 0
M1
Text Label 9200 1700 0    60   ~ 0
M0
NoConn ~ 5150 4200
NoConn ~ 5150 4300
NoConn ~ 5150 4400
NoConn ~ 5150 4500
NoConn ~ 5150 4700
NoConn ~ 5150 4600
$Comp
L GND #PWR037
U 1 1 55EE62B6
P 10800 3350
F 0 "#PWR037" H 10800 3100 50  0001 C CNN
F 1 "GND" H 10800 3200 50  0000 C CNN
F 2 "" H 10800 3350 60  0000 C CNN
F 3 "" H 10800 3350 60  0000 C CNN
	1    10800 3350
	1    0    0    -1  
$EndComp
Text Label 10800 2900 0    60   ~ 0
M1
Text Label 11000 2900 0    60   ~ 0
M0
$Comp
L LED D301
U 1 1 55EEAB2A
P 10900 2000
F 0 "D301" H 10900 2100 50  0000 C CNN
F 1 "LED" H 10900 1900 50  0000 C CNN
F 2 "LEDs:LED-0805" H 10900 2000 60  0001 C CNN
F 3 "" H 10900 2000 60  0000 C CNN
	1    10900 2000
	0    -1   -1   0   
$EndComp
$Comp
L R R306
U 1 1 55EEC3F9
P 10900 1600
F 0 "R306" V 10980 1600 50  0000 C CNN
F 1 "560" V 10900 1600 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 10830 1600 30  0001 C CNN
F 3 "" H 10900 1600 30  0000 C CNN
	1    10900 1600
	-1   0    0    1   
$EndComp
$Comp
L +3.3V #PWR038
U 1 1 55EEC492
P 10900 1400
F 0 "#PWR038" H 10900 1250 50  0001 C CNN
F 1 "+3.3V" H 10900 1540 50  0000 C CNN
F 2 "" H 10900 1400 60  0000 C CNN
F 3 "" H 10900 1400 60  0000 C CNN
	1    10900 1400
	1    0    0    -1  
$EndComp
Text Label 10900 2250 0    60   ~ 0
INIT_B
Text GLabel 3900 6450 2    40   Input ~ 0
ADC_CLK_A
$Comp
L R R304
U 1 1 55EF348C
P 3700 6450
F 0 "R304" V 3780 6450 50  0000 C CNN
F 1 "0" V 3700 6450 50  0000 C CNN
F 2 "Resistors_SMD:R_0402" V 3630 6450 30  0001 C CNN
F 3 "" H 3700 6450 30  0000 C CNN
	1    3700 6450
	0    1    1    0   
$EndComp
Text GLabel 4600 3900 0    40   Input ~ 0
FPGA_CLKOUT_ADC
NoConn ~ 9150 1800
NoConn ~ 9150 1900
NoConn ~ 9150 2200
NoConn ~ 9150 2300
NoConn ~ 9150 2500
NoConn ~ 9150 2600
NoConn ~ 9150 2700
NoConn ~ 9150 2800
NoConn ~ 9150 2900
NoConn ~ 9150 3200
NoConn ~ 9150 3300
NoConn ~ 9150 3400
NoConn ~ 9150 3700
NoConn ~ 9150 4400
NoConn ~ 9150 4500
NoConn ~ 9150 4600
NoConn ~ 9150 4700
NoConn ~ 9150 5000
NoConn ~ 9150 5100
NoConn ~ 5150 6700
NoConn ~ 5150 6600
NoConn ~ 5150 6400
NoConn ~ 5150 6200
NoConn ~ 5150 5900
NoConn ~ 5150 5800
NoConn ~ 5150 5000
NoConn ~ 5150 5100
NoConn ~ 5150 1800
NoConn ~ 5150 1600
$Comp
L C C307
U 1 1 55F76E56
P 3950 950
F 0 "C307" H 3975 1050 50  0000 L CNN
F 1 "4.7u" H 3975 850 50  0000 L CNN
F 2 "Resistors_SMD:R_0805" H 3988 800 30  0001 C CNN
F 3 "" H 3950 950 60  0000 C CNN
	1    3950 950 
	1    0    0    -1  
$EndComp
$Comp
L C C318
U 1 1 55F0536D
P 3650 7450
F 0 "C318" H 3675 7550 50  0000 L CNN
F 1 "0.47u" H 3675 7350 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 3688 7300 30  0001 C CNN
F 3 "" H 3650 7450 60  0000 C CNN
	1    3650 7450
	1    0    0    -1  
$EndComp
$Comp
L C C317
U 1 1 55F0540B
P 3450 7450
F 0 "C317" H 3475 7550 50  0000 L CNN
F 1 "4.7u" H 3475 7350 50  0000 L CNN
F 2 "Resistors_SMD:R_0805" H 3488 7300 30  0001 C CNN
F 3 "" H 3450 7450 60  0000 C CNN
	1    3450 7450
	1    0    0    -1  
$EndComp
$Comp
L C C319
U 1 1 55F05D5C
P 3850 7450
F 0 "C319" H 3875 7550 50  0000 L CNN
F 1 "0.47u" H 3875 7350 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 3888 7300 30  0001 C CNN
F 3 "" H 3850 7450 60  0000 C CNN
	1    3850 7450
	1    0    0    -1  
$EndComp
$Comp
L C C320
U 1 1 55F0642D
P 4050 7450
F 0 "C320" H 4075 7550 50  0000 L CNN
F 1 "0.47u" H 4075 7350 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 4088 7300 30  0001 C CNN
F 3 "" H 4050 7450 60  0000 C CNN
	1    4050 7450
	1    0    0    -1  
$EndComp
$Comp
L C C321
U 1 1 55F064BA
P 4250 7450
F 0 "C321" H 4275 7550 50  0000 L CNN
F 1 "0.47u" H 4275 7350 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 4288 7300 30  0001 C CNN
F 3 "" H 4250 7450 60  0000 C CNN
	1    4250 7450
	1    0    0    -1  
$EndComp
$Comp
L C C322
U 1 1 55F07BB2
P 4650 7450
F 0 "C322" H 4675 7550 50  0000 L CNN
F 1 "0.47u" H 4675 7350 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 4688 7300 30  0001 C CNN
F 3 "" H 4650 7450 60  0000 C CNN
	1    4650 7450
	1    0    0    -1  
$EndComp
$Comp
L C C323
U 1 1 55F07C49
P 4850 7450
F 0 "C323" H 4875 7550 50  0000 L CNN
F 1 "0.47u" H 4875 7350 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 4888 7300 30  0001 C CNN
F 3 "" H 4850 7450 60  0000 C CNN
	1    4850 7450
	1    0    0    -1  
$EndComp
$Comp
L C C324
U 1 1 55F07CED
P 5050 7450
F 0 "C324" H 5075 7550 50  0000 L CNN
F 1 "0.47u" H 5075 7350 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 5088 7300 30  0001 C CNN
F 3 "" H 5050 7450 60  0000 C CNN
	1    5050 7450
	1    0    0    -1  
$EndComp
$Comp
L C C325
U 1 1 55F07D94
P 5250 7450
F 0 "C325" H 5275 7550 50  0000 L CNN
F 1 "4.7u" H 5275 7350 50  0000 L CNN
F 2 "Resistors_SMD:R_0805" H 5288 7300 30  0001 C CNN
F 3 "" H 5250 7450 60  0000 C CNN
	1    5250 7450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR039
U 1 1 55F0813A
P 3450 7700
F 0 "#PWR039" H 3450 7450 50  0001 C CNN
F 1 "GND" H 3450 7550 50  0000 C CNN
F 2 "" H 3450 7700 60  0000 C CNN
F 3 "" H 3450 7700 60  0000 C CNN
	1    3450 7700
	1    0    0    -1  
$EndComp
$Comp
L +3.3VADC #PWR040
U 1 1 55F094C3
P 3450 7200
F 0 "#PWR040" H 3600 7150 50  0001 C CNN
F 1 "+3.3VADC" H 3450 7300 50  0000 C CNN
F 2 "" H 3450 7200 60  0000 C CNN
F 3 "" H 3450 7200 60  0000 C CNN
	1    3450 7200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR041
U 1 1 55F0A11E
P 4650 7700
F 0 "#PWR041" H 4650 7450 50  0001 C CNN
F 1 "GND" H 4650 7550 50  0000 C CNN
F 2 "" H 4650 7700 60  0000 C CNN
F 3 "" H 4650 7700 60  0000 C CNN
	1    4650 7700
	1    0    0    -1  
$EndComp
$Comp
L R R307
U 1 1 55F14284
P 10800 3100
F 0 "R307" V 10880 3100 50  0000 C CNN
F 1 "2.4k" V 10800 3100 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 10730 3100 30  0001 C CNN
F 3 "" H 10800 3100 30  0000 C CNN
	1    10800 3100
	-1   0    0    1   
$EndComp
$Comp
L R R310
U 1 1 55F14EE1
P 11000 3100
F 0 "R310" V 11080 3100 50  0000 C CNN
F 1 "2.4k" V 11000 3100 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 10930 3100 30  0001 C CNN
F 3 "" H 11000 3100 30  0000 C CNN
	1    11000 3100
	-1   0    0    1   
$EndComp
$Comp
L +3.3V #PWR042
U 1 1 55F54BD4
P 5550 700
F 0 "#PWR042" H 5550 550 50  0001 C CNN
F 1 "+3.3V" H 5550 840 50  0000 C CNN
F 2 "" H 5550 700 60  0000 C CNN
F 3 "" H 5550 700 60  0000 C CNN
	1    5550 700 
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR043
U 1 1 55F55D03
P 2800 5650
F 0 "#PWR043" H 2800 5500 50  0001 C CNN
F 1 "+3.3V" H 2800 5790 50  0000 C CNN
F 2 "" H 2800 5650 60  0000 C CNN
F 3 "" H 2800 5650 60  0000 C CNN
	1    2800 5650
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR044
U 1 1 55F56658
P 4650 7200
F 0 "#PWR044" H 4650 7050 50  0001 C CNN
F 1 "+3.3V" H 4650 7340 50  0000 C CNN
F 2 "" H 4650 7200 60  0000 C CNN
F 3 "" H 4650 7200 60  0000 C CNN
	1    4650 7200
	1    0    0    -1  
$EndComp
Text GLabel 1050 1150 0    40   Input ~ 0
ADC_VIN_P_A
Text GLabel 1050 1500 0    40   Input ~ 0
ADC_VIN_N_A
Text GLabel 1050 3400 0    40   Input ~ 0
ADC_VIN_P_B
Text GLabel 1050 3750 0    40   Input ~ 0
ADC_VIN_N_B
$Comp
L C C311
U 1 1 55F455B3
P 4950 950
F 0 "C311" H 4975 1050 50  0000 L CNN
F 1 "0.47u" H 4975 850 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 4988 800 30  0001 C CNN
F 3 "" H 4950 950 60  0000 C CNN
	1    4950 950 
	1    0    0    -1  
$EndComp
Text GLabel 2600 1000 2    40   Input ~ 0
ADC_OTR_A
Text GLabel 1050 2300 0    40   Input ~ 0
ADC_PWDN_A
Text GLabel 1050 2400 0    40   Input ~ 0
ADC_OEB_A
NoConn ~ 5150 2800
NoConn ~ 5150 1700
NoConn ~ 5150 1900
NoConn ~ 5150 4100
NoConn ~ 5150 5200
NoConn ~ 5150 5400
NoConn ~ 5150 6500
Text GLabel 9250 3800 2    40   Input ~ 0
DAC_BCK
Text GLabel 9250 3500 2    40   Input ~ 0
DAC_WS
Text GLabel 9250 3100 2    40   Input ~ 0
DAC_PLL
Text GLabel 9250 3000 2    40   Input ~ 0
DAC_DATAI
Text GLabel 9250 3900 2    40   Input ~ 0
DAC_DEEM
NoConn ~ 9150 4000
Wire Wire Line
	1900 7250 1900 7350
Connection ~ 1900 7300
Wire Wire Line
	2200 7300 2200 7250
Wire Wire Line
	1900 7300 2800 7300
Wire Wire Line
	2000 7250 2000 7300
Connection ~ 2000 7300
Wire Wire Line
	2100 7250 2100 7300
Connection ~ 2100 7300
Wire Wire Line
	2600 7250 2600 7350
Wire Wire Line
	2800 7300 2800 7250
Connection ~ 2600 7300
Wire Wire Line
	2700 7250 2700 7300
Connection ~ 2700 7300
Wire Wire Line
	2800 5650 2800 5750
Wire Wire Line
	2600 5750 2600 5700
Connection ~ 2800 5700
Wire Wire Line
	2700 5750 2700 5700
Connection ~ 2700 5700
Wire Wire Line
	1850 5650 1850 5750
Wire Wire Line
	2150 5700 2150 5750
Wire Wire Line
	1850 5700 2150 5700
Connection ~ 1850 5700
Wire Wire Line
	1950 5750 1950 5700
Connection ~ 1950 5700
Wire Wire Line
	2050 5750 2050 5700
Connection ~ 2050 5700
Wire Wire Line
	1400 6250 1400 6550
Wire Wire Line
	1400 6550 1500 6550
Wire Wire Line
	1500 6350 1350 6350
Wire Wire Line
	1350 6350 1350 6450
Wire Wire Line
	1350 6450 1500 6450
Wire Wire Line
	3300 6050 3300 6550
Wire Wire Line
	3300 6550 3150 6550
Wire Wire Line
	1500 6750 1400 6750
Wire Wire Line
	900  6650 1500 6650
Wire Wire Line
	900  6650 900  6750
Wire Wire Line
	1150 6750 1150 6650
Connection ~ 1150 6650
Wire Wire Line
	1400 7200 1400 7150
Wire Wire Line
	500  7200 1400 7200
Wire Wire Line
	1150 7050 1150 7250
Wire Wire Line
	1400 6750 1400 6850
Connection ~ 1150 7200
Wire Wire Line
	900  7050 900  7200
Connection ~ 1400 6250
Wire Wire Line
	650  6250 1500 6250
Connection ~ 1150 6250
Wire Wire Line
	800  6550 1300 6550
Wire Wire Line
	1300 6550 1300 6400
Wire Wire Line
	1300 6400 1350 6400
Connection ~ 1350 6400
Connection ~ 1150 6550
Connection ~ 900  6250
Wire Wire Line
	800  6550 800  6750
Wire Wire Line
	800  6750 650  6750
Connection ~ 900  6550
Wire Wire Line
	650  6550 650  6650
Wire Wire Line
	650  6650 500  6650
Wire Wire Line
	500  6650 500  7200
Connection ~ 900  7200
Wire Wire Line
	650  7050 650  7200
Connection ~ 650  7200
Wire Wire Line
	3300 5600 3300 5750
Wire Wire Line
	3500 6450 3500 6050
Wire Wire Line
	3500 5700 3500 5750
Connection ~ 3300 5700
Connection ~ 3500 6450
Wire Wire Line
	3600 6350 3150 6350
Wire Wire Line
	3600 6650 3150 6650
Wire Wire Line
	1100 4650 1050 4650
Wire Wire Line
	1050 4550 1100 4550
Wire Wire Line
	1050 2300 1100 2300
Wire Wire Line
	1050 2400 1100 2400
Wire Wire Line
	2600 5700 2800 5700
Wire Wire Line
	3500 5700 3300 5700
Wire Wire Line
	5550 700  5550 800 
Wire Wire Line
	5650 750  5650 800 
Wire Wire Line
	3950 750  5950 750 
Connection ~ 5550 750 
Wire Wire Line
	5950 750  5950 800 
Connection ~ 5650 750 
Wire Wire Line
	5850 800  5850 750 
Connection ~ 5850 750 
Wire Wire Line
	5750 800  5750 750 
Connection ~ 5750 750 
Wire Wire Line
	1050 2500 1100 2500
Wire Wire Line
	1050 4750 1100 4750
Wire Wire Line
	2500 1000 2600 1000
Wire Wire Line
	2600 1200 2500 1200
Wire Wire Line
	2500 1300 2600 1300
Wire Wire Line
	2600 1400 2500 1400
Wire Wire Line
	2500 1500 2600 1500
Wire Wire Line
	2600 1600 2500 1600
Wire Wire Line
	2500 1700 2600 1700
Wire Wire Line
	2500 1800 2600 1800
Wire Wire Line
	2600 1900 2500 1900
Wire Wire Line
	2500 2000 2600 2000
Wire Wire Line
	2600 2100 2500 2100
Wire Wire Line
	2500 2200 2600 2200
Wire Wire Line
	2600 2300 2500 2300
Wire Wire Line
	2500 2400 2600 2400
Wire Wire Line
	2600 2500 2500 2500
Wire Wire Line
	2500 3250 2600 3250
Wire Wire Line
	2600 3450 2500 3450
Wire Wire Line
	2500 3550 2600 3550
Wire Wire Line
	2600 3650 2500 3650
Wire Wire Line
	2500 3750 2600 3750
Wire Wire Line
	2600 3850 2500 3850
Wire Wire Line
	2500 3950 2600 3950
Wire Wire Line
	2600 4050 2500 4050
Wire Wire Line
	2500 4150 2600 4150
Wire Wire Line
	2600 4250 2500 4250
Wire Wire Line
	2500 4350 2600 4350
Wire Wire Line
	2600 4450 2500 4450
Wire Wire Line
	2500 4550 2600 4550
Wire Wire Line
	2600 4650 2500 4650
Wire Wire Line
	2500 4750 2600 4750
Wire Wire Line
	4600 3500 5150 3500
Wire Wire Line
	5150 3600 4600 3600
Wire Wire Line
	5150 3700 4600 3700
Wire Wire Line
	5150 6300 4600 6300
Wire Wire Line
	4600 4800 5150 4800
Wire Wire Line
	5150 4900 4600 4900
Wire Wire Line
	4600 5500 5150 5500
Wire Wire Line
	5150 5300 4600 5300
Wire Wire Line
	5150 5600 4600 5600
Wire Wire Line
	5150 6800 4600 6800
Wire Wire Line
	5150 6000 4600 6000
Wire Wire Line
	4600 2400 5150 2400
Wire Wire Line
	4600 2500 5150 2500
Wire Wire Line
	5150 2600 4600 2600
Wire Wire Line
	5150 2700 4600 2700
Wire Wire Line
	5150 2900 4600 2900
Wire Wire Line
	5150 4000 4600 4000
Wire Wire Line
	5150 3000 4600 3000
Wire Wire Line
	5150 3100 4600 3100
Wire Wire Line
	5150 3200 4600 3200
Wire Wire Line
	5150 3300 4600 3300
Wire Wire Line
	4600 3900 5150 3900
Wire Wire Line
	5150 2000 4600 2000
Wire Wire Line
	4600 2100 5150 2100
Wire Wire Line
	4600 6900 5150 6900
Wire Wire Line
	4600 2300 5150 2300
Wire Wire Line
	4600 5700 5150 5700
Wire Wire Line
	5150 3400 4600 3400
Wire Wire Line
	4600 6100 5150 6100
Wire Wire Line
	4600 2200 5150 2200
Wire Wire Line
	4200 1100 4200 1200
Wire Wire Line
	3950 1150 4950 1150
Connection ~ 4200 1150
Wire Wire Line
	4700 1150 4700 1100
Wire Wire Line
	4450 1100 4450 1150
Connection ~ 4450 1150
Wire Wire Line
	4200 800  4200 750 
Wire Wire Line
	4700 800  4700 750 
Connection ~ 4700 750 
Wire Wire Line
	4450 800  4450 750 
Connection ~ 4450 750 
Wire Wire Line
	8450 700  8450 800 
Wire Wire Line
	8550 750  8550 800 
Connection ~ 8450 750 
Wire Wire Line
	8650 750  8650 800 
Connection ~ 8550 750 
Wire Wire Line
	8750 750  8750 800 
Connection ~ 8650 750 
Connection ~ 8750 750 
Wire Wire Line
	10850 5750 11100 5750
Wire Wire Line
	10950 5850 10950 6150
Wire Wire Line
	10850 6050 11100 6050
Connection ~ 10950 6050
Wire Wire Line
	9750 5750 9800 5750
Wire Wire Line
	9150 1600 9200 1600
Wire Wire Line
	10850 5950 10950 5950
Wire Wire Line
	10850 5850 10950 5850
Connection ~ 10950 5950
Wire Wire Line
	9650 5850 9800 5850
Wire Wire Line
	11000 4450 11000 4550
Wire Wire Line
	11000 4850 11000 4900
Wire Wire Line
	11000 4050 11000 4150
Wire Wire Line
	9200 2000 9150 2000
Wire Wire Line
	9200 2100 9150 2100
Wire Wire Line
	9750 6050 9800 6050
Wire Wire Line
	9200 5300 9150 5300
Wire Wire Line
	9350 5850 9300 5850
Connection ~ 11000 4100
Wire Wire Line
	9800 5950 9750 5950
Wire Wire Line
	9200 1700 9150 1700
Wire Wire Line
	9200 2400 9150 2400
Wire Wire Line
	10800 3300 11000 3300
Wire Wire Line
	11000 3300 11000 3250
Connection ~ 10800 3300
Wire Wire Line
	10800 2950 10800 2900
Wire Wire Line
	11000 2900 11000 2950
Wire Wire Line
	10900 1400 10900 1450
Wire Wire Line
	10900 1750 10900 1800
Wire Wire Line
	9200 5200 9150 5200
Wire Wire Line
	10900 2200 10900 2250
Wire Wire Line
	3150 6450 3550 6450
Wire Wire Line
	3850 6450 3900 6450
Wire Wire Line
	4600 3800 5150 3800
Wire Wire Line
	10950 5650 10950 5750
Connection ~ 10950 5750
Connection ~ 2200 7300
Wire Wire Line
	3950 800  3950 750 
Connection ~ 4200 750 
Wire Wire Line
	3950 1150 3950 1100
Wire Wire Line
	3450 7600 3450 7700
Wire Wire Line
	3450 7650 4250 7650
Wire Wire Line
	3650 7650 3650 7600
Connection ~ 3450 7650
Wire Wire Line
	3850 7650 3850 7600
Connection ~ 3650 7650
Wire Wire Line
	4050 7650 4050 7600
Connection ~ 3850 7650
Wire Wire Line
	4250 7650 4250 7600
Connection ~ 4050 7650
Wire Wire Line
	3450 7200 3450 7300
Wire Wire Line
	3450 7250 4250 7250
Wire Wire Line
	4250 7250 4250 7300
Connection ~ 3450 7250
Wire Wire Line
	4050 7300 4050 7250
Connection ~ 4050 7250
Wire Wire Line
	3850 7300 3850 7250
Connection ~ 3850 7250
Wire Wire Line
	3650 7300 3650 7250
Connection ~ 3650 7250
Wire Wire Line
	4650 7200 4650 7300
Wire Wire Line
	4650 7250 5250 7250
Wire Wire Line
	5250 7250 5250 7300
Connection ~ 4650 7250
Wire Wire Line
	5050 7300 5050 7250
Connection ~ 5050 7250
Wire Wire Line
	4850 7300 4850 7250
Connection ~ 4850 7250
Wire Wire Line
	4650 7600 4650 7700
Wire Wire Line
	4650 7650 5250 7650
Wire Wire Line
	4850 7650 4850 7600
Connection ~ 4650 7650
Wire Wire Line
	5050 7650 5050 7600
Connection ~ 4850 7650
Wire Wire Line
	5250 7650 5250 7600
Connection ~ 5050 7650
Wire Wire Line
	10800 3250 10800 3350
Wire Wire Line
	1050 1150 1100 1150
Wire Wire Line
	1100 1500 1050 1500
Wire Wire Line
	1100 3400 1050 3400
Wire Wire Line
	1050 3750 1100 3750
Wire Wire Line
	8450 750  9300 750 
Wire Wire Line
	9300 1100 9300 1200
Wire Wire Line
	9300 750  9300 800 
Wire Wire Line
	4950 800  4950 750 
Connection ~ 4950 750 
Wire Wire Line
	4950 1150 4950 1100
Connection ~ 4700 1150
Wire Wire Line
	9250 4900 9150 4900
Wire Wire Line
	9250 4800 9150 4800
Wire Wire Line
	9250 4300 9150 4300
Wire Wire Line
	9250 4200 9150 4200
Wire Wire Line
	9250 3900 9150 3900
Wire Wire Line
	9250 3800 9150 3800
Wire Wire Line
	9250 3500 9150 3500
Wire Wire Line
	9250 3000 9150 3000
Wire Wire Line
	9250 3100 9150 3100
Text GLabel 9250 3600 2    40   Input ~ 0
FPGA_CLKIN
Wire Wire Line
	9150 3600 9250 3600
$Comp
L LED D302
U 1 1 5609B271
P 10500 2000
F 0 "D302" H 10500 2100 50  0000 C CNN
F 1 "LED" H 10500 1900 50  0000 C CNN
F 2 "LEDs:LED-0805" H 10500 2000 60  0001 C CNN
F 3 "" H 10500 2000 60  0000 C CNN
	1    10500 2000
	0    -1   -1   0   
$EndComp
$Comp
L R R311
U 1 1 5609B277
P 10500 1600
F 0 "R311" V 10580 1600 50  0000 C CNN
F 1 "560" V 10500 1600 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 10430 1600 30  0001 C CNN
F 3 "" H 10500 1600 30  0000 C CNN
	1    10500 1600
	-1   0    0    1   
$EndComp
$Comp
L +3.3V #PWR045
U 1 1 5609B27D
P 10500 1400
F 0 "#PWR045" H 10500 1250 50  0001 C CNN
F 1 "+3.3V" H 10500 1540 50  0000 C CNN
F 2 "" H 10500 1400 60  0000 C CNN
F 3 "" H 10500 1400 60  0000 C CNN
	1    10500 1400
	1    0    0    -1  
$EndComp
Text Label 10500 2250 0    60   ~ 0
DEBUG_LED
Wire Wire Line
	10500 1400 10500 1450
Wire Wire Line
	10500 1750 10500 1800
Wire Wire Line
	10500 2200 10500 2250
Text Label 9250 4100 0    60   ~ 0
DEBUG_LED
Wire Wire Line
	9250 4100 9150 4100
$EndSCHEMATC
