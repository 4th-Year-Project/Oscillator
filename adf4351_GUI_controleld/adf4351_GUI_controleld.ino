/*!
   ADF4351 example program
*/

#include <Arduino.h>
#include "adf4351.h"

#define SWVERSION "1.0"

#define PIN_SS 10  ///< SPI slave select pin, default value

ADF4351  vfo(PIN_SS, SPI_MODE0, 1000000UL , MSBFIRST) ;

/*
   SCK 13
   MOSI 11
   LE (SS) 10
*/

unsigned long frequency = 0;
byte input[4];

void setup()
{
  Serial.begin(9600) ;
  Wire.begin() ;
  /*!
     setup the chip (for a 10 mhz ref freq)
     most of these are defaults
  */
  vfo.pwrlevel = 3 ; ///< sets to -4 dBm output (0-3) 0 is -4dBm
  vfo.RD2refdouble = 0 ; ///< ref doubler off
  vfo.RD1Rdiv2 = 0 ;   ///< ref divider off
  vfo.ClkDiv = 150 ;
  vfo.BandSelClock = 80 ;
  vfo.RCounter = 1 ;  ///< R counter to 1 (no division)
  vfo.ChanStep = steps[2] ;  ///< set to 10 kHz steps

  vfo.setrf(25000000UL);

  /*!
     initialize the chip
  */
  vfo.init() ;

  /*!
     disable frequency output
  */

}



void loop()
{

  if (Serial.available()) {      // If anything comes in Serial (USB),
    
    input[0] = Serial.read(); //read in a long made of bytes
    delay(10);
    input[1] = Serial.read();
    delay(10);
    input[2] = Serial.read();
    delay(10);
    input[3] = Serial.read();

    frequency = (unsigned long) (input[3] * 16777216 + input[2] * 65536 + input[1] * 256 + input[0] ); //out the bytes into a long

    vfo.enable();

    if ( vfo.setf(frequency) == 0 ) {
      Serial.print("success freq:") ;
      Serial.println(vfo.cfreq) ;
    } else {
      Serial.println("error") ;
    }
  }
}
