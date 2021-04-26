% LAB ASSIGNMENT - 9
% PROBLEM - 1(B)
% GROUP - BOTS

STEPS = 50;
REWARDS = zeros(STEPS, 2);
TOTAL = zeros(STEPS);

iter = 1;
for e = [0.01, 0.1, 0.3]
    REWARDS(:, :, iter) = 0;
    step = 1;
    
    while step <= STEPS
        % EXPLORATION
        
        if rand < e || step == 1
            action = randi(2);
            value = binaryBanditB(action);
            TOTAL(step,iter) = value;
            if step > 1
                TOTAL(step,iter) = TOTAL(step,iter) + TOTAL(step - 1,iter);
            end
            REWARDS(step, :, iter) = [value, action];
            
        else
            % EXPLOITATION
            a1 = 0;
            a2 = 0;
            
            for s = 1:step
                
                if REWARDS(s, 1, iter) == 1
                    if REWARDS(s, 2, iter) == 1
                        a1 = a1 + 1;
                    else
                        a2 = a2 + 1;
                    end
                end
                
            end
            
            action = 1;
            if a2 > a1
                action = 2;
            end
            
            value = binaryBanditB(action);
            TOTAL(step,iter) = value + TOTAL(step - 1,iter);
            REWARDS(step, :, iter) = [value, action];
        end
        
        step = step + 1;
    end
    
    iter = iter + 1;
end

figure(1)
plot(REWARDS(:,1,1))
hold on
plot(REWARDS(:,1,2))
plot(REWARDS(:,1,3))
hold off
ylim([-1,2])
xlabel('Time Steps')
ylabel('Reward')
legend('e = 0.01','e = 0.1', 'e = 0.3','Location','northwest')

figure(2)
plot(TOTAL(:,1))
hold on
plot(TOTAL(:,2))
plot(TOTAL(:,3))
hold off
ylim([0,50])
xlabel('Time Steps')
ylabel('Total Successes')
legend('e = 0.01','e = 0.1', 'e = 0.3','Location','northwest')
title('Binary Bandit B - (e = 0.01, 0.1, 0.3)')