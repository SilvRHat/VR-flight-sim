This is the default directory for signal files on Prepar3D testbed application

## About signal files
Signals are a programming pattern for signaling seperate code pieces of an event - which then invokes that other code to run. This idea is implemented using files - where Prepar3D will write data to a file (such as parameters to a function). A third party can then read/ monitor this file for data and a 'signal' to run its own functionality.

## Signal Documentation
### Audio Playing - audio.fsig
Signal is invoked by writing one line containing 1 function param with additonal params as function arguments
@param 1 - Requested Function (action to perform)

Example invocation:
write:      'PlayAudio GatePassed.mp3 0'
write:      'StopAudio'

This scheme is setup in the unity audio prompting app.