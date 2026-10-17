% Housekeeping

clear()
clc()
desired_diving_depth = input("Diving Depth (meters) = "); % Take user input of the desired diving depth in meters (this is almost the exact same as python except we dont have to convert the input to an integer or floating point because matlab handles that automatically)

% Certification Logic 

disp("Certification Level Needed: ") % Header to give context to output

% Here I use a series of nested if statements to determine which certification is needed for a user's provided desired depth 
if desired_diving_depth <= 12 % Use an if statement to check if the user's desired diving depth is less than or equal to 12 meters
    disp("Supervised Scuba Diver") % If this is true, we display the string "Supervised Scuba Diver"
elseif desired_diving_depth <= 18 % We use the same structure for the next 10 or so lines.
    disp("Open Water Diver")
elseif desired_diving_depth <= 30
    disp("Advanced Open Water Diver")
elseif desired_diving_depth <= 40
    disp("Deep Diver Specialty")
elseif desired_diving_depth > 40
    disp("WARNING: Technical Diving Level Required")
end

% Note: Because a greater than or equal to / less than or equal to condition is binary, meaning that a number can only be either greater than or equal to or not greater than or equal to (less than) we do not have to check if a number is less than the threshold established by the previous if condition.
% I.E. If the desired depth is 16 meters, the program first checks if the desired depth is less than 12 meters, therefore we do not have to check if the desired depth lies in the range 12 meters to 18 meters because we know already that the desired depth is greater than 12. We only need to check if it is less than 18.