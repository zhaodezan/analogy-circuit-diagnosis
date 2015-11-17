%I am a scientist .I believe in data.
clc
clear
%generate  train data and test data
train_x =[];
train_y= [];
test_x =[];
test_y =[];
for i=1:3
    code = [0 0 0]';
    code(i) = 1;
    subplot(1,3,i);
    
    i =num2str(i);
    a=xlsread([i  '.xlsx']);
    tit = ['第' i '个状态'];
    title(tit);
    imshow(a);
    hold on;
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
train_x1 = train_x(4000,:)';
train_x2 = train_x(4500,:)';
train_x3 = train_x(5000,:)';
train_xxx =[train_x1 train_x2 train_x3]';
train_yyy = train_y;

test_x1 = test_x(4000,:)';
test_x2 = test_x(4500,:)';
test_x3 = test_x(5000,:)';
test_xxx = [test_x1 test_x2 test_x3]';
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
right = 0;
for i=1:20
    if index(i)==1
        right =right +1;
    end
end
for i=21:40
    if index(i)==2
        right =right +1;
    end
end
for i=41:60
    if index(i)==3
        right =right +1;
    end
end
rate = right/60;
%得正确率 rate = 91.67%
% p=[];
% for i=1:120
%     z=train_x(:,i);
%     [c,l]=wavedec(z,5,'haar');
%     caa =[];
%     for j=1:5
%         ca=detcoef(c,l,j);
%         caa=[caa;sum(abs(ca))];
%     end 
%     c=sqrt(sum(caa.^2));
%     caaa = caa/c;
%     p=[p caaa];
% end

 
