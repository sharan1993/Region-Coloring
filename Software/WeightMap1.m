function [w,ib,wE_A,wE_B,wE_C]=WeightMap1(A,B,C)

%Each value represents a member of {region,color}
R=linspace(1,9,9);

%Calculates weight
for i=1:length(R)
    for j=1:length(R)
        delR=0;delCol=0;
            if i==j %if same region and color
                delR=1;delCol=1;
                %if same color
            elseif sum(ismember([i,j],[1 2 3]))==2 ||sum(ismember([i,j],[4 5 6]))==2 ||sum(ismember([i,j],[7 8 9]))==2
                delCol=1;
                %if same region
            elseif sum(ismember([i,j],[1 4 7]))==2 ||sum(ismember([i,j],[2 5 8]))==2||sum(ismember([i,j],[3 6 9]))==2
                delR=1;
            end
           w(i,j)=-A*delR*(1-delCol)-B*delCol*(1-delR)-C;
           wE_A(i,j)=-A*delR*(1-delCol);wE_B(i,j)=-B*delCol*(1-delR);wE_C(i,j)=-C;
           if i==j
               w(i,j)=0;wE_A(i,j)=0;wE_B(i,j)=0;wE_C(i,j)=0;
           end
           %bias
           ib(i)=C*3;
    end
end