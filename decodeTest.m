% decodingTest
clc
clf
clear all
close all

states = [0 0; 0 1; 1 0; 1 1];
N = 1e2;
codeType = 1;
bits = randi([0 1],N,1);
code = encode(bits,codeType);

% branchMetric = zeros(1,4);
pathMetric = zeros(4,1);
survivor = zeros(4,N/2);
for i = 1:N/2
    % Start by calculating the hamming distance between 2 coded bits and
    % the states.
    
    codedBits = code(i:i+1);
    repeatBits = repmat(codedBits,4,1);
    tmp = bitxor(states,repeatBits);
    hDist = sum(tmp~=0,2);                     % Vector containing distances between codedBits and all 4 possible combinations.
    
    if i == 1 || i == 2     % First 4 bits are processed manually by using the Trellis diagram
        
        p1 = hDist(1) + pathMetric(1,1);                % Reaching state 00
        s1 = 1;
        p2 = hDist(3) + pathMetric(3,1);                % Reaching state 01
        s2 = 3;
        p3 = hDist(4) + pathMetric(1,1);                % Reaching state 10
        s3 = 1;
        p4 = hDist(2) + pathMetric(3,1);                % Reaching state 11
        s4 = 3;
        pathMetric = [p1; p2; p3; p4];                  % Update path
        survivor(:,i) = [s1; s2; s3; s4];               % Place survivors in the i:th column
        
    else                                                % On the third iteration and onwards we start terminating paths. Each state can be reached by 2 paths. 
        p1 = hDist(1) + pathMetric(1,1);                % Reaching state 00
        p2 = hDist(4) + pathMetric(2,1); 
        [pathMetric(1,1),index] = min([p1,p2]);                   % Terminate the longest path
        s1 = index;
        
        p1 = hDist(3) + pathMetric(3,1);                % Reaching state 01
        p2 = hDist(2) + pathMetric(4,1); 
        [pathMetric(2,1),index] = min([p1,p2]); 
        s2 = index + 2; 
        
        p1 = hDist(1) + pathMetric(2,1);                % Reaching state 10
        p2 = hDist(4) + pathMetric(1,1); 
        [pathMetric(3,1),index] = min([p1,p2]); 
        s3 = index; 
        
        p1 = hDist(3) + pathMetric(4,1);                % Reaching state 11
        p2 = hDist(2) + pathMetric(3,1); 
        [pathMetric(4,1),index] = min([p1,p2]);
        s4 = index + 2; 
        
        survivor(:,i) = [s1; s2; s3; s4];  
        
        
        
        
        
        

        
    end
    
    
    
    
    
    
end
