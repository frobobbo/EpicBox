import RPi.GPIO as GPIO
import os
import time
import subprocess

GPIOPin = 5

GPIO.setmode(GPIO.BOARD)
GPIO.setup(GPIOPin, GPIO.IN)

BUTTON_PRESSED = 0

heldSeconds = 0
while True:
   #get Button State
   buttonState = GPIO.input(GPIOPin)
   if buttonState == BUTTON_PRESSED:
      while buttonState == BUTTON_PRESSED:
         print ("Button Pressed")
         time.sleep(.5)
         heldSeconds += .5
         buttonState = GPIO.input(GPIOPin)
         if buttonState != BUTTON_PRESSED:
            print (f"Button released after {heldSeconds} seconds")
            if heldSeconds > 1 and heldSeconds < 5:
               print ("reboot")
            elif heldSeconds >= 5 and heldSeconds < 10:
               print ("download photos")
            elif heldSeconds >= 10:
               print ("reset wifi")
            heldSeconds = 0
            break
   else:
      print ("Button Not Pressed")
   time.sleep(1)
