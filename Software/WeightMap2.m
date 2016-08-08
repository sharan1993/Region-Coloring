function [w,ib,wEA,wEB,wEC]=WeightMap2(A,B,C,CostMat)

%Each value represents a member of the set {Region,Color}
R=linspace(1,12,12);

%Calculate weight matrix
for i=1:length(R)
    for j=1:length(R)
        delR=0;delCol=0;
            if i==j %if same region and color
                delR=1;delCol=1;
                %if same color
            elseif sum(ismember([i,j],[1 2 3 4]))==2 ||sum(ismember([i,j],[5 6 7 8]))==2 ||sum(ismember([i,j],[9 10 11 12]))==2
                delCol=1;
                %if same region
            elseif sum(ismember([i,j],[1 5 9]))==2 ||sum(ismember([i,j],[2 6 10]))==2||sum(ismember([i,j],[3 7 11]))==2||sum(ismember([i,j],[4 8 12]))==2
                delR=1;
            end
            if ismember(i,[1 5 9])
                R1=1;
            elseif ismember(i,[2 6 10])
                R1=2;
            elseif ismember(i,[3 7 11])
                R1=3;
            else R1=4;
            end
            if ismember(j,[1 5 9])
                R2=1;
            elseif ismember(j,[2 6 10])
                R2=2;
            elseif ismember(j,[3 7 11])
                R2=3;
            else R2=4;
            end
           w(i,j)=-A*delR*(1-delCol)-B*CostMat(R1,R2)*delCol*(1-delR)-C;%(1-delRplus)*(1-delRminus)-D*delCol*(1-delR);
           wEA(i,j)=-A*delR*(1-delCol);wEB(i,j)=-B*CostMat(R1,R2)*delCol*(1-delR);wEC(i,j)=-C;
           if i==j
               w(i,j)=0;wEA(i,j)=0;wEB(i,j)=0;wEC(i,j)=0;
           end
           %bias
           ib(i)=C*4;
    end
end