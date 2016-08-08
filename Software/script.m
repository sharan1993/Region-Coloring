%Map 1

%Initial State
insMap1=round(rand(3,3));

%Weight and Bias determination
[w_Map1,bias_Map1]=WeightMap1(0.6,0.6,0.6);

%Coloring
[oM1,o_sM1,E_M1]=FeedInputM1(w_Map1,bias_Map1,insMap1,1000);
Output_For_Map1=oM1
figure;
plot(E_M1);
xlabel('No. of Iterations','FontSize',11);
ylabel('Energy of Hopfield Net State','FontSize',11);
title('Energy plot for Map 1','FontSize',11);

%Map 2

%Initial State
insMap2=round(rand(4,3));
CostMat=[0 1 1 0;1 0 1 1;1 1 0 0;0 1 0 0]; %Adjaceny Matrix

%Weight and Bias determination
[w_Map2,bias_Map2]=WeightMap2(0.6,0.6,0.6,CostMat);

%Coloring
[oM2,o_sM2,E_M2]=FeedInputM2(w_Map2,bias_Map2,insMap2,1000);
Output_For_Map2=oM2
figure;
plot(E_M2);
xlabel('No. of Iterations','FontSize',11);
ylabel('Energy of Hopfield Net State','FontSize',11);
title('Energy plot for Map 2','FontSize',11);

