function [o,o_s,E]=FeedInputM1(w,b,ins,iter)
%Convert 3x3 input state to 9x1 vector
in=reshape(ins,1,numel(ins))';o=in;
%Initial Energy
E_ini=-0.5*in'*w*in-b*in;
E(1)=E_ini;c=2;o_s{1}=in;
T=100;
for k=2:iter
    flag=0;
    in=o;
    %Choose a unit at random
        r=randi(9);
        %Annealing schedule
        T=T*(1/10)^k;
            if o(r)==1
                o(r)=0;
            else 
                o(r)=1;
            end
   %Energy of new state
   Etemp=-0.5*o'*w*o-b*o;
   %if new energy state is lower, accept. else calculate probability of
   %acceptance
   if Etemp<E(c-1)
        o_s{c}=o;
        E(k)=Etemp;
        c=c+1;
   else
       P=exp(-(Etemp-E(c-1))/T);
       if P>=0.75
           o_s{c}=o;
           E(k)=Etemp;
           c=c+1;
       else o=in;E(k)=E(k-1);
       end
   end
end

%reshape 9x1 vector to 3x3 output state
o=reshape(o_s{end},3,3)';

temp=[];
for i=1:length(o_s)
temp=horzcat(temp,o_s{i});
end

figure;
imagesc(temp);
xlabel('nth state','FontSize',11);
ylabel('Hopfiel Unit Output, Yellow-ON, Blue-OFF','FontSize',11);
title('State Transition for Map 1','FontSize',11);
clear temp;