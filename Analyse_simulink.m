 

x_ref(:,1)=posref(1,1,:);

y_ref(:,1)=posref(1,2,:);

x_cal(:,1)=pos_cal(1,1,:);

y_cal(:,1)=pos_cal(1,2,:);


figure;
plot(x_ref,y_ref,'b','LineWidth',3)
hold on;
plot(x_cal,y_cal,'r--','LineWidth',3)
grid on
xlabel('x(m)');
ylabel('y(m)');
legend('traj-ref','traj_cal');



figure;
plot(temps,beta(:,1),'b','LineWidth',3)
hold on;
plot(temps,beta(:,2),'r--','LineWidth',3)
grid on
xlabel('temps(s)');
ylabel('angle de braquage (rad)');
legend('beta-f','beta_r');

