%%% Aditay Tripathi
%%% MT15084
%%% Machine Learning Assignment #1

function [newCentroid,lables,evaluationMatrix,objectiveFunction] = my_kMeans(X,initial_centroids,max_iters)
groundTruth = X(:,end);
X2 = X(:,1:end-1);
numOfIterations = max_iters;
%[N,D] = size(irisDataset);
[N,D] = size(X);
D = D-1;
[numOfCentroids,k] = size(initial_centroids);
Centroids = initial_centroids;

%% Finding Assignments
for iter = 1:numOfIterations
    EuDis = [];
    R = zeros(N,numOfCentroids);
    for i = 1:N
        for j = 1:numOfCentroids
            EuDis(j) = sqrt(sum((X2(i,:)-Centroids(j,:)).^2));
        end
        [v,k] = min(EuDis);
        R(i,k) = 1;
    end
    for data = 1:N
       for cen = 1: numOfCentroids
          Cost(data,cen) = sqrt(sum(X2(data,:) - Centroids(cen,:)).^2); 
       end
    end
    objectiveFunction = sum(diag(R'*Cost))
%% Finding New Mean

    for i = 1:numOfCentroids
        Centroids(i,:) = (R(:,i)'*X2)/sum(R(:,i)); 
    end
end
newCentroid = Centroids;
[i,l] = find(R==1);
lables = l;
NMI = nmi(groundTruth,lables);
AMI = ami(groundTruth,lables);
[AR,RI,MI,HI] = valid_RandIndex(groundTruth,lables);
evaluationMatrix = [NMI,AMI,RI,AR];
tsne(X2,lables);
%title('Color Coded Clustered Data');
figure;
tsne(X2,groundTruth);
%title('Color Coded GroundTruth Data');
end