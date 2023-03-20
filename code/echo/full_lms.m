function [e,w] = full_lms(x,d,N,w0,mu)
%[e,w] = full_lms(x,d,N,w0,mu) implements the full-update LMS algorithm.
%   ----------------
%   input parameters
%   ----------------
%   x : Lx1 input signal
%   d : Lx1 desired response 
%   N : filter length
%   w0 : Nx1 initialization
%   mu : step-size parameter
%   ----------------
%   function outputs
%   ----------------
%   w : LxN evolution of coefficients
%   e : Lx1 error vector

% x = x(:);
% d = d(:);
% w0 = w0(:);

x = x';
d = d';
w0 = w0';


L = length(x);
w = zeros(L,N);
e = zeros(L,1);


w(1,:) = w0';
xvec = zeros(N,1);


for i = 1:L-1
    xvec = [x(i);xvec(1:N-1)];
    e(i) = d(i)-w(i,:)*xvec;
    upd = (mu*e(i)*xvec);
    w(i+1,:) = w(i,:) + upd';
end

xvec = [x(L);xvec(1:N-1)];
e(L) = d(L)-w(L,:)*xvec;

