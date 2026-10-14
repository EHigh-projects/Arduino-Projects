% Program Name : Two Way Traffic Light With Protected and Unprotected Left Turn
% Program Description : Instructs an Arduino Uno to activate pins in a specific order to toggle on and off LEDs of varying colors, mimicing a traffic light assembly

% Name : Ethan High (Ejhigh@mtu.edu)
% Section: L24
% Team : 06
% Date : 10/13/26

% Housekeeping
clear()
clc()

a = arduino()

redpin_int1 = "D10" ;
yellowpin_int1 = "D11" ;
greenpin_int1 = "D12" ;

redpin_int2 = "D9" ;
yellowpin_int2 = "D8" ;
greenpin_int2 = "D7" ;

red = [1, 0, 0] ;
yellow = [0, 1, 0] ;
green = [0, 0, 1] ;
protectedleft = [1, 1, 1] ;
endprotectedleft = [1, 1, 0] ;

lightprogrammingarray = [repmat({red}, 1, 4), repmat({protectedleft}, 1, 6), repmat({endprotectedleft}, 1, 4), repmat({red}, 1, 2), repmat({green}, 1, 2), ...
    {[0, 1, 1], [0, 0, 1], [0, 1, 1], [0, 0, 1], [0, 1, 1], [0, 0, 1], [0, 1, 1], [0, 0, 1]}, repmat({yellow}, 1, 4), repmat({red}, 1 , 2)] ;

    

for i = 1:length(lightprogrammingarray)

    a.writeDigitalPin(redpin_int1, lightprogrammingarray{i}(1))
    a.writeDigitalPin(yellowpin_int1, lightprogrammingarray{i}(2))
    a.writeDigitalPin(greenpin_int1, lightprogrammingarray{i}(3))

    a.writeDigitalPin(redpin_int2, lightprogrammingarray{i}(1))
    a.writeDigitalPin(yellowpin_int2, lightprogrammingarray{i}(2))
    a.writeDigitalPin(greenpin_int2, lightprogrammingarray{i}(3))
    
    pause(.5)

end
  
a.writeDigitalPin(redpin_int1, 0)
a.writeDigitalPin(redpin_int2, 0)