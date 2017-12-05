function decodedBits = decode(bits,flag)

states = [0 0; 0 1; 1 0; 1 1];
pathMetric = zeros(4,1);
survivor = zeros(4,N/2);
switch flag
    case 0                  % Uncoded
        decodedBits=bits;
    case 1                  % G(D) = [1+D^2 1+D+D^2]
        
        for i = 1:length(bits)/2
            % Start by calculating the hamming distance between 2 coded bits and
            % the possible combinations.
            
            codedBits = bits(i:i+1)';
            repeatBits = repmat(codedBits,4,1);
            tmp = bitxor(states,repeatBits);
            hDist = sum(tmp~=0,2);                      % Vector containing distances to states
            
            if i == 1 || i == 2
                % First 2 iterations we make no decisions
                p1 = hDist(1) + pathMetric(1,1);                % Reaching state 00
                s1 = 1;
                p2 = hDist(3) + pathMetric(3,1);                % Reaching state 01
                s2 = 3;
                p3 = hDist(4) + pathMetric(1,1);                % Reaching state 10
                s3 = 1;
                p4 = hDist(2) + pathMetric(3,1);                % Reaching state 11
                s4 = 3;
                
                pathMetric = [p1 p2 p3 p4]';                  % Update path
                survivor(:,i) = [s1 s2 s3 s4]';                 % Place survivors in the i:th column
                
                
            else
                
                % On the third iteration and onwards we start terminating
                % paths. Each state can be reached by two paths. 
            end
            
            
            
            
            
        end
        
        
    case 2
        
    case 3
        
    case 4
        
        
end




end