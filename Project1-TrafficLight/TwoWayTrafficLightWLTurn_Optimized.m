clear()
clc()

% define arduino object

a = arduino() ;

% All pins 5V
% Define which pins connect to each LED

red = "D13" ;
yellow = "D12" ;
green = "D11" ;
red_turn_arrow = "D10" ;
yellow_turn_arrow = "D9" ;
green_turn_arrow = "D8" ;

function[out] = traffic(signal, time, freq, blink) % Outputs a list of vectors depending on which light is on and if it blinks
    
    if freq > time
        out = "Error: non integer number of iterations (update frequency is greater than time interval)" ;
        return
    end

    N = time * (1 / freq); 

    red_vector_array = repmat({[1,0,0,0,0,0]}, 1, N) ;
    yellow_vector_array = repmat({[0,1,0,0,0,0]}, 1, N) ;
    green_vector_array = repmat({[0,0,1,0,0,0]}, 1, N) ;

    red_blink = repmat({[1,0,0,0,0,0],[0,0,0,0,0,0]}, 1, N/2) ;
    yellow_blink = repmat({[0,1,0,0,0,0],[0,0,0,0,0,0]}, 1, N/2) ;
    green_blink = repmat({[0,0,1,0,0,0],[0,0,0,0,0,0]}, 1, N/2) ;

    red_arrow_array = repmat({[0,0,0,1,0,0]}, 1, N) ;
    yellow_arrow_array = repmat({[0,0,0,0,1,0]}, 1, N) ;
    green_arrow_array = repmat({[0,0,0,0,0,1]}, 1, N) ;

    red_arrow_blink = repmat({[0,0,0,1,0,0],[0,0,0,0,0,0]},1, N/2) ;
    yellow_arrow_blink = repmat({[0,0,0,0,1,0],[0,0,0,0,0,0]}, 1, N/2) ;
    green_arrow_blink = repmat({[0,0,0,0,0,1],[0,0,0,0,0,0]}, 1, N/2) ;

    if signal == "D13"
        if blink == true
            out = red_blink ;
            return
        end
        out = red_vector_array ;
    elseif signal == "D12"
        if blink == true 
            out = yellow_blink ;
            return 
        end
        out = yellow_vector_array ;
    elseif signal == "D11"
        if blink == true 
            out = green_blink ;
            return 
        end
        out = green_vector_array ;
    elseif signal == "D10"
        if blink == true
            out = red_arrow_blink ;
            return
        end
        out = red_arrow_array ;
    elseif signal == "D9"
        if blink == true
            out = yellow_arrow_blink ;
            return 
        end 
        out = yellow_arrow_array ;
    elseif signal == "D8"
        if blink == true
            out = green_arrow_blink ;
            return 
        end
        out = green_arrow_array ;
    end
end

function[out] = combine(array1, array2) % Combines two vector arrays of same dimension so you can turn more than one light on or off at once 

    combined_array = cell(length(array1), 1) ;

    for i = 1:length(array1)
       combined_array{i} = array1{i} + array2{i} ;
    end

    combined_array_transpose = combined_array.' ;
    out = combined_array_transpose ; 

end

function[out] = arrow_and_light(duration, freq, signal1, signal2, blink1, blink2) % Combines two signals, one for the left turn arrow lights and one for the main traffic lights
    out = combine(traffic(signal1, duration, freq, blink1), traffic(signal2, duration, freq, blink2)) ;
end

end_light_array = {[0,0,0,0,0,0]} ; % Turns the circut off at the end of the programmed sequence 

update_frequency = input("Update frequency (seconds) = "); % User input for update frequency (Time must be evenly divisible by update frequency)

light_programming_array = [arrow_and_light(3, update_frequency, red, red_turn_arrow, false, false), ... % This array is used to program the traffic light sequence
    arrow_and_light(3, update_frequency, red, green_turn_arrow, false, false), ...
    arrow_and_light(2, update_frequency, red, yellow_turn_arrow, false, false), ...
    arrow_and_light(1, update_frequency, red, red_turn_arrow, false, false), ...
    arrow_and_light(1, update_frequency, green, red_turn_arrow, false, false), ... 
    arrow_and_light(3, update_frequency, green, yellow_turn_arrow, false, true), ... 
    arrow_and_light(2, update_frequency, yellow, yellow_turn_arrow, false, false), ...
    arrow_and_light(2, update_frequency, red, red_turn_arrow, false, false), ...
    end_light_array] ;

for vector = light_programming_array % Loops through the light programming array and turns each LED on or off accordingly 
   
    a.writeDigitalPin(red, vector{1}(1))
    a.writeDigitalPin(yellow, vector{1}(2))
    a.writeDigitalPin(green, vector{1}(3))

    a.writeDigitalPin(red_turn_arrow, vector{1}(4))
    a.writeDigitalPin(yellow_turn_arrow, vector{1}(5))
    a.writeDigitalPin(green_turn_arrow, vector{1}(6))

    pause(update_frequency)

end