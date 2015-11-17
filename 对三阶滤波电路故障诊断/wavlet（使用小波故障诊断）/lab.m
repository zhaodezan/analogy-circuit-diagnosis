%I am a scientist .I believe in data.
clc
clear
%generate  train data and test data
train_x =[];
train_y= [];
test_x =[];
test_y =[];
indexx = 3;
epoch = 1000;
for i=1:indexx
    code = [0 0 0]';
    code(i) = 1;
    %subplot(1,3,i);
    
    i =num2str(i);
    a=xlsread([i  '.xlsx']);
%     tit = ['第' i '个状态'];
%     title(tit);
%     imshow(a);
%     hold on;
    train_xx =a(:,1:2000); %
    test_xx  = a(:,2001:3000);%
    code = repmat(code,1,3000);
    train_yy =code(:,1:2000);
    test_yy = code(:,2001:3000);
    
    train_x = [train_x train_xx];
    train_y = [train_y train_yy];
    test_x  = [test_x test_xx];
    test_y  = [test_y test_yy];
end

p=[];
for i=1:(2000*indexx)
    caa=[];
    s=train_x(:,i);
    [c,l]=wavedec(s,5,'db2');
    for j=1:5
      ca=detcoef(c,l,j);
      caa=[caa;sum(abs(ca))];
    end
    p=[p caa];
end

p1=[];
for i=1:(1000*indexx)
    caa=[];
    s=test_x(:,i);
    [c,l]=wavedec(s,5,'db2');
    for j=1:5
      ca=detcoef(c,l,j);
      caa=[caa;sum(abs(ca))];
    end
    p1=[p1 caa];
end

P = minmax(p);
T = train_y;
net = newff(P,[30,indexx],{'tansig','purelin'},'traingdx');%若采用gdx则速度回变慢
net.trainParam.epochs =epoch;
net.trainParam.goal =1e-5;
P = p;
net = train(net,P,T); %死的东西，记住



P1 = p1; 
a = sim(net,P1);
[maxa,index]=max(a);

right1 = 0;
for i=1:1000
    if index(i)==1
        right1 =right1 +1;
    end
end
rate1 = right1/1000;

right2=0;
for i=1001:2000
    if index(i)==2
        right2 =right2 +1;
    end
end
rate2 = right2/1000;

right3=0;
for i=2001:3000
    if index(i)==3
        right3 =right3 +1;
    end
end
rate3 = right3/1000;

% right4=0;
% for i=3001:4000
%     if index(i)==4
%         right4 =right4 +1;
%     end
% end
% rate4 = right4/1000;
% 
% right5=0;
% for i=4001:5000
%     if index(i)==5
%         right5 =right5 +1;
%     end
% end
% rate5 = right5/1000;

% right6=0;
% for i=5001:6000
%     if index(i)==6
%         right6 =right6 +1;
%     end
% end
% rate6 = right6/1000;
% 
% right7=0;
% for i=6001:7000
%     if index(i)==7
%         right7 =right7 +1;
%     end
% end
% rate7 = right7/1000;
% 
% right8=0;
% for i=7001:8000
%     if index(i)==8
%         right8 =right8 +1;
%     end
% end
% rate8 = right8/1000;
% 
% right9=0;
% for i=8001:9000
%     if index(i)==9
%         right9 =right9 +1;
%     end
% end
% rate9 = right9/1000;

% rate = (right1+right2+right3+right4+right5+right6+right7+right8+right9)/(1000*9);
fid = fopen('result.txt','w');
fprintf(fid,'rate1 = %f\n',rate1);
fprintf(fid,'rate2 = %f\n',rate2);
fprintf(fid,'rate3 = %f\n',rate3);
% fprintf(fid,'rate4 = %f\n',rate4);
% fprintf(fid,'rate5 = %f\n',rate5);
% fprintf(fid,'rate6 = %f\n',rate6);
% fprintf(fid,'rate7 = %f\n',rate7);
% fprintf(fid,'rate8 = %f\n',rate8);
% fprintf(fid,'rate9 = %f\n',rate9);
% fprintf(fid,'rate = %f\n',rate);
