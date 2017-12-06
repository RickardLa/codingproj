% decodingTest
clc
clf
clear all
close all

states = [0 0; 0 1; 1 0; 1 1];
<<<<<<< HEAD
N = 200;
=======
N = 50;
>>>>>>> 74deb8c19e94e911c259943d8bc3217960861ff2
codeType = 1;
bits = randi([0 1],N,1);
code = encode(bits,codeType);
decodedBits = zeros(1,N); 

<<<<<<< HEAD
=======
% decodedBits = zeros(N,1);
>>>>>>> 74deb8c19e94e911c259943d8bc3217960861ff2
pathMetric = zeros(4,1);
pathMetric2 = zeros(4,1); 
survivor = zeros(4,N/2);
<<<<<<< HEAD
for i = 1:N
=======
ipLUT = [ 0   0   0   0;...
    0   0   0   0;...
    1   1   0   0;...
    0   0   1   1 ];
for i = 1:N/2
>>>>>>> 74deb8c19e94e911c259943d8bc3217960861ff2
    % Start by calculating the hamming distance between 2 coded bits and
    % the states.
    
    codedBits = code(2*i-1:2*i);
    repeatBits = repmat(codedBits,4,1);
    tmp = bitxor(states,repeatBits);
    hDist = sum(tmp~=0,2);                     % Vector containing distances between codedBits and all 4 possible combinations.
    
    if i == 1 || i == 2     % First 4 bits are processed manually by using the Trellis diagram
        
        p1 = hDist(1) + pathMetric(1,1);                % Reaching state 00
        s1 = 1;
        p2 = hDist(2) + pathMetric(3,1);                % Reaching state 01
        s2 = 3;
        p3 = hDist(4) + pathMetric(1,1);                % Reaching state 10
        s3 = 1;
        p4 = hDist(3) + pathMetric(3,1);                % Reaching state 11
        s4 = 3;
        
        pathMetric = [p1 p2 p3 p4]';                    % Update path
        survivor(:,i) = [s1 s2 s3 s4]';                 % Place survivors in the i:th column
        
    else                                                % On the third iteration and onwards we start terminating paths. Each state can be reached by 2 paths.
        
        p1 = hDist(1) + pathMetric(1,1);                % Reaching state 00
<<<<<<< HEAD
        p2 = hDist(4) + pathMetric(2,1); 
        [path1, s1] = min([p1 p2]);                   % Terminate the longest path
        % Survivor = 1 or 2
        
        
        p1 = hDist(2) + pathMetric(3);                % Reaching state 01
        p2 = hDist(3) + pathMetric(4); 
        [path2, s2] = min([p1 p2]); 
        % Survivor 3 or 4
        
                                                        % Reaching state 10
        p1 = hDist(4) + pathMetric(1); 
        p2 = hDist(1) + pathMetric(2);
        [path3, s3] = min([p1 p2]);
        % Survivor 1 or 2
        
        
        p1 = hDist(3) + pathMetric(3);
        p2 = hDist(2) + pathMetric(4);                % Reaching state 11
        [path4, s4] = min([p1 p2]);
        % Survivor 3 or 4
        
=======
        p2 = hDist(4) + pathMetric(2,1);
        [pathMetric(1,1), s1] = min([p1 p2]);                   % Terminate the longest path
        % Survivor = 1 or 2
        
        
        p1 = hDist(2) + pathMetric(3,1);                % Reaching state 01
        p2 = hDist(3) + pathMetric(4,1);
        [pathMetric(2,1), s2] = min([p1 p2]);
        % Survivor 3 or 4
        
        % Reaching state 10
        p1 = hDist(4) + pathMetric(1,1);
        p2 = hDist(1) + pathMetric(2,1);
        [pathMetric(3,1), s3] = min([p1 p2]);
        % Survivor 1 or 2
        
        
        p1 = hDist(3) + pathMetric(3,1);
        p2 = hDist(2) + pathMetric(4,1);                % Reaching state 11
        [pathMetric(4,1), s4] = min([p1 p2]);
        % Survivor 3 or 4
        
        
        survivor(:,i) = [s1 (s2+2) s3 (s4+2)]';
>>>>>>> 74deb8c19e94e911c259943d8bc3217960861ff2
        
        survivor(:,i) = [s1 (s2+2) s3 (s4+2)]';  
        
<<<<<<< HEAD
        pathMetric = [path1 path2 path3 path4]';
        

=======
        
>>>>>>> 74deb8c19e94e911c259943d8bc3217960861ff2
        
    end
    
    
    % The survivor-matrix is completed. Time to back-trace and decode. We
    % assume it ends at the all zero state. 
    
    
    
   
    
    
    
    
end
survivor;
[~,currentState] = min(pathMetric);     % Last state in survivor-matrix. We loop from end to beginning.

for i=N/2:-1:1
    
end

<<<<<<< HEAD
[~,currentState] = min(pathMetric);     % Last state in survivor-matrix. We loop from end to beginning.

currentState = double(currentState); 
for i=N:-1:1
   
    if currentState == 1 || currentState == 2
        decodedBits(i) = 0;
    else
        decodedBits(i) = 1;
    end
    
    
    previousState = survivor(currentState,i);
    currentState = previousState; 
   
end
=======









>>>>>>> 74deb8c19e94e911c259943d8bc3217960861ff2



