# Oscillator
Based on ADF4351 and Arduino uno.

Currently the code sets the board to 40Mhz and then waits.

## Info
* Based on [dfannin/adf4351](https://github.com/dfannin/adf4351) Arduino library
* [ADF4351 Datasheet](https://www.analog.com/media/en/technical-documentation/data-sheets/adf4351.pdf)
* Board reference 25Mhz
* Maximum 3.3v IO (needs logic level conversion)
* Debug output is over serial at 9600 baud
* I don't think there is any feedback from the board to Arduino?

## Setup
* Follow setup instructions on [dfannin/adf4351](https://github.com/dfannin/adf4351) to install library. This installs ADF4351 and bignumber libraries.

## Connecting

| Arduino Pin | Name       |
|-------------|------------|
|      13     | CLK (SCK)  |
|      11     | DAT (MOSI) |
|      10     | LE (SS)    |

## Programming
### Frequency
set through `vfo.setf(frequency)` e.g. `vfo.setf(40000000UL)` for 40MHz

### Power
set through `vfo.pwrlevel = ` e.g. `vfo.pwrlevel = 3 ;` for max. power (maybe max. is 4??).
There are 4 levels and 0 in the minimum.
