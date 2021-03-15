%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Math 285 Project Function: MDS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%INPUT: X = distance matrix, assumed to be symmetric.
% k = target dimension; Y = new (lower) coordinates in dimension k
% d = distance of new point with n original points as a row vector.
function [Y, y_x, stress] = outofsampleMDS(X,d,k)
n = size(X,1); D = X.^2;
meanD = mean(D,1); mmeanD = mean(meanD);
%D_tilde = 0.5(-D + ones(n,n)*D/n + D*ones(n,n)/n - ones(n,n)*D*ones(n,n)
D_tilde = 0.5*(repmat(meanD', 1, n) + repmat(meanD, n, 1) - D - mmeanD);
% Constructing matrix Y
[U,S] = eig(D_tilde,'vector');
[~,indx] = sort(S,'descend');
S = S(indx); S = abs(diag(S));
U = U(:,indx);
Y = U(:,1:k)*sqrt(S(1:k,1:k));
% Computing stress: stress = sqrt(sum(sum(x,1))/(n^2*l_dotdot));
stress = sqrt(2*sum((squareform(X) - pdist(Y)).^2)/mmeanD)/n;
% Out-of-sample extension
d = d'.^2;
% b = d - ones(n,n)*d/n - D*ones(n,1)/n + ones(n,n)*D*ones(n,1)/n^2;
b = -0.5*(d - mean(d) - mean(D,2) + mmeanD);
y_x = b'*Y/S(1:k,1:k); % (sqrt(S)U'b)'; return as row vector