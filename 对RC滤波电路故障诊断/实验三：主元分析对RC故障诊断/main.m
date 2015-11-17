clc
clear
train_x =[];
train_y= [];
test_x =[];
test_y =[];
for i=1:3
    code = [0 0 0]';
    code(i) = 1;
    %subplot(1,3,i);
    
    i =num2str(i);
    a=xlsread([i  '.xlsx']);
%     tit = ['第' i '个状态'];
%     title(tit);
%     imshow(a);
%     hold on;
    train_xx =a(:,1:40);
    test_xx  = a(:,41:60);
    code = repmat(code,1,60);
    train_yy =code(:,1:40);
    test_yy = code(:,41:60);
    
    train_x = [train_x train_xx];
    train_y = [train_y train_yy];
    test_x  = [test_x test_xx];
    test_y  = [test_y test_yy];
end
train_x =pca(train_x,3);
test_x =pca(test_x,3);


train_xxx =train_x;
train_yyy = train_y;
test_xxx = test_x;
test_yyy = test_y;

train_xxx=mapminmax(train_xxx);
P = minmax(train_xxx);
T = train_yyy;
%net = newff(P,[40,9],{'tansig','logsig'},'trainlm');%若采用gdx则速度回变慢
net = newff(P,[15,3],{'tansig','purelin'},'trainlm');%若采用gdx则速度回变慢
 % view(net);
net.trainParam.epochs =1000;
net.trainParam.goal =1e-5;
P = train_xxx;
net = train(net,P,T); %死的东西，记住

P = mapminmax(test_xxx); 
a = sim(net,P);
[maxa,index]=max(a);

right1 = 0;
for i=1:20
    if index(i)==1
        right1 =right1 +1;
    end
end
rate1 = right1/20;

right2=0;
for i=21:40
    if index(i)==2
        right2 =right2 +1;
    end
end
rate2 = right2/20;

right3=0;
for i=41:60
    if index(i)==3
        right3 =right3 +1;
    end
end
rate3 = right3/20;
rate = (right1+right2+right3)/60;




fid = fopen('result.txt','w');
fprintf(fid,'rate1 = %f\n',rate1);
fprintf(fid,'rate2 = %f\n',rate2);
fprintf(fid,'rate3 = %f\n',rate3);
fprintf(fid,'rate = %f\n',rate);

%第一次正确率为73.3%
%第二次正确率为86.67%
%第三次正确率为73.%



