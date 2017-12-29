% Decoding with manually implemented Viterbi. 

function decodedBits = decode(bits)

N= length(bits);
states = [0 0; 0 1; 1 0; 1 1];
pathMetric = zeros(4,1);
survivor = zeros(4,N/2);


for i = 1:N/2
    % Start by calculating the hamming distance between 2 coded bits and
    % the possible combinations.
    
    codedBits = bits(2*i-1:2*i);               % Save bits pair-wise 
    repeatBits = repmat(codedBits,1,4)';       % Repeat to get same dimension as the states-matrix
    tmp = bitxor(states,repeatBits);
    hDist = sum(tmp~=0,2);                     % Vector containing distances to states
    
    if i == 1 || i == 2                                 % First two iterations no decisions are made.
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
    else
        % On the third iteration and onwards we start terminating
        % paths. Each state can be reached by two paths.
        
        p1 = hDist(1) + pathMetric(1,1);                % Reaching state 00
        p2 = hDist(4) + pathMetric(2,1);
        [path1, s1] = min([p1 p2]);                     % Terminate the longest path
        % Survivor = 1 or 2
        
        
        p1 = hDist(2) + pathMetric(3);                  % Reaching state 01
        p2 = hDist(3) + pathMetric(4);
        [path2, s2] = min([p1 p2]);
        % Survivor 3 or 4
        
                                                        % Reaching state 10
        p1 = hDist(4) + pathMetric(1);
        p2 = hDist(1) + pathMetric(2);
        [path3, s3] = min([p1 p2]);
        % Survivor 1 or 2
        
        
        p1 = hDist(3) + pathMetric(3);
        p2 = hDist(2) + pathMetric(4);                  % Reaching state 11
        [path4, s4] = min([p1 p2]);
        % Survivor 3 or 4
        
        
        survivor(:,i) = [s1 (s2+2) s3 (s4+2)]';         % State 2 and 4 can only be reached from state 3 and 4. Hence (s+2).
        pathMetric = [path1 path2 path3 path4]';
        
    end   
end

[~,currentState] = min(pathMetric);     % Last state in survivor-matrix. We loop from end to beginning.
for i=N/2:-1:1
    if (currentState == 1 ) || (currentState  == 2)     % Decoding rule given by Trellis diagram.
        decodedBits(i) = 0;
    else
        decodedBits(i) = 1;
    end
    
    previousState = survivor(currentState,i);
    currentState = previousState;                       % Update current state. We go "backwards" in the Trellis.
    
end
decodedBits = decodedBits';                             

end