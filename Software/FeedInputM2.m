function [o,o_s,E]=FeedInputM2(w,b,ins,iter)

%Convert 4x3 state to 12x1 vector
in=reshape(ins,numel(ins),1);o=in;
%Initial Energy
E_ini=-0.5*in'*w*in-b*in;
E(1)=E_ini;c=2;o_s{1}=in;
T=1000;
for k=2:iter
    flag=0;
    in=o;
    %Choose a unit at random and update
        r=randi(numel(ins));
        %Annealing Schedule
        T=T*(1/10)^k;
            if o(r)==1
                o(r)=0;
            else 
                o(r)=1;
            end
   %New State's Energy
   Etemp=-0.5*o'*w*o-b*o;
   %If del(E) is negative, accept state
   if Etemp<E(c-1)
        o_s{c}=o;
        E(k)=Etemp;
        c=c+1;
   else %if del(E) is positive, calculate probability of accepting state
       P=exp(-(Etemp-E(c-1))/T);
       if P>=0.7
           o_s{c}=o;
           E(k)=Etemp;
           c=c+1;
       else o=in; E(k)=E(k-1);
       end
   end
end

%Reshape 12x1 vector to 4x3 output state
o=reshape(o_s{end},4,3);

%To show state evolution
temp=[];
for i=1:length(o_s)
temp=horzcat(temp,o_s{i});
end
figure;
imagesc(temp);
xlabel('nth state','FontSize',11);
ylabel('Hopfiel Unit Output, Yellow-ON, Blue-OFF','FontSize',11);
title('State Transition for Map 2','FontSize',11);

clear temp;
