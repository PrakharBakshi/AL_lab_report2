% LAB ASSIGNMENT - 9
% PROBLEM - 2 & 3
% GROUP - BOTS

STEPS = 10000;
REWARDS = zeros(STEPS, 2);
TOTAL = zeros(STEPS);
ACTION_COUNT = zeros(10);

iter = 1;
for e = [0.01, 0.1, 0.3]
    TOTAL(:,iter) = 0;
    REWARDS(:, :, iter) = 0;
    step = 1;
    ACTION_COUNT(:,iter) = 0;
    
    while step <= STEPS
        % EXPLORATION
       
        if rand < e || step == 1
            action = randi(10);
            value = bandit(action);
            TOTAL(step,iter) = value;
            if step > 1
                TOTAL(step,iter) = TOTAL(step,iter) + TOTAL(step - 1,iter);
            end
            REWARDS(step, :, iter) = [value, action];
            
        % EXPLOITATION
        else
            actions = zeros(10, 2);
            
            for s = 1:(step-1)
                actions(REWARDS(s,2,iter), 1) = actions(REWARDS(s,2,iter),1)+REWARDS(s,1,iter);
                actions(REWARDS(s,2,iter), 2) = actions(REWARDS(s,2,iter),2)+1;
            end
            
            action = 1;
            expReturn = 0;
            a = 1;
            for aa = actions
                temp = aa(1) / aa(2);
                if temp > expReturn
                    expReturn = temp;
                    action = a;
                end
                a = a + 1;
            end
            
            value = bandit(action);
            TOTAL(step,iter) = value + TOTAL(step - 1,iter);
            REWARDS(step, :, iter) = [value, action];
            ACTION_COUNT(:,iter) = actions(:,2);
        end    
        
        step = step + 1;
    end
    
    iter = iter + 1;
end

figure(1);
plot(REWARDS(:,2,2));
xlabel('Time STEPS')
ylabel('Actions')
title('10 armed Bandit - (e = 0.1)')
 
figure(2);
scatter(1:10,ACTION_COUNT(:,2));
xlabel('Actions')
ylabel('# times taken')
title('10 armed Bandit - (e = 0.1)')

figure(3);
plot(TOTAL(:,2))
xlabel('Time STEPS')
ylabel('Total Value Received')
title('10 armed Bandit - (e = 0.1)')

avgReward = zeros(STEPS);
for iter = 1:STEPS
    avgReward(iter) = TOTAL(iter,2) / iter;
end

figure(4);
plot(avgReward(:,1));
xlabel('Time STEPS')
ylabel('Average Reward')
title('10 armed Bandit - (e = 0.1)')
plot(TOTAL(:,1))
hold on
plot(TOTAL(:,2))
plot(TOTAL(:,3))
hold off
xlabel('Time STEPS')
ylabel('Total Successes')
title('10 armed Bandit - (e = 0.1)')