function [xTitle] = pca( x,k )
%PCA Summary of this function goes here
%   Detailed explanation goes here
avg = mean(x,1);
x = x-repmat(avg,size(x,1),1);
sigma = x*x'/size(x,2);
[U,S,V] = svd(sigma);
xRot = U'* x;
xTitle = U(:,1:k)'*x;
%xPCAwhite = diag(1./sqrt(diag(S)+epsilon))*U'*x;
%xZCAwhite = U * diag(1./sqrt(diag(S)+epsilon))*U'*x';
end

