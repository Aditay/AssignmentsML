%%% Aditay Tripathi
%%% MT15084
%%% Machine Learning Assignment #1
%%% The code will run out of the box. All the datasets has been
%%% preprocessed. You just have to write the name of the desired datasets
%%% at the required places.

clear all;
close all;
%% Image Segmentation Dataset Preprocessing
fid3 = fopen('segmentation.data.txt','r');
fgetl(fid3);
fgetl(fid3);
fgetl(fid3);
fgetl(fid3);
fgetl(fid3);
segmentationData = textscan(fid3,'%s');
segmentationData = segmentationData{1,1};
[rows,columns] = size(segmentationData);

for i = 1:rows
   
    segData = strsplit(segmentationData{i,1},',');
    segData2(i,:) = [str2num(segData{:,2}),str2num(segData{:,3}),str2num(segData{:,4}),str2num(segData{:,5}),str2num(segData{:,6}),str2num(segData{:,7}),str2num(segData{:,8}),str2num(segData{:,9}),str2num(segData{:,10}),str2num(segData{:,11}),str2num(segData{:,12}),str2num(segData{:,13}),str2num(segData{:,14}),str2num(segData{:,15}),str2num(segData{:,16}),str2num(segData{:,17}),str2num(segData{:,18}),str2num(segData{:,19}),str2num(segData{:,20})]; 
    lab = segData{:,1};
    if strcmp(lab,'BRICKFACE')
        labels(i,1) = 1;
    elseif strcmp(lab,'SKY')
        labels(i,1) = 2;
    elseif strcmp(lab,'FOLIAGE')
        labels(i,1) = 3;
    elseif strcmp(lab,'CEMENT')
        labels(i,1) = 4;
    elseif strcmp(lab,'WINDOW')
        labels(i,1) = 5;
    elseif strcmp(lab,'PATH')
        labels(i,1) = 6;
    else
        labels(i,1) = 7;
    end
end
segData2 = [segData2,labels];

%segData = [str2num(segData{:,2}),str2num(segData{:,3}),str2num(segData{:,4}),str2num(segData{:,5}),str2num(segData{:,6}),str2num(segData{:,7}),str2num(segData{:,8}),str2num(segData{:,9}),str2num(segData{:,10}),str2num(segData{:,11}),str2num(segData{:,12}),str2num(segData{:,13}),str2num(segData{:,14}),str2num(segData{:,15}),str2num(segData{:,16}),str2num(segData{:,17}),str2num(segData{:,18}),str2num(segData{:,19}),str2num(segData{:,20})];
%segmentationData = textread('segmentation.data.txt','%s,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f',-1,'headerlines',5);

%% Data Preprocessing for Vertebral Dataset
fid4 = fopen('vertebral_column_data/column_3C.dat','r');

column = textscan(fid4,'%f %f %f %f %f %f %s');
columnDataset = [column{1,1},column{1,2},column{1,3},column{1,4},column{1,5},column{1,6}];

B = column{1,7};
L2 = [];
for i = 1:length(B)
    if strcmp(B(i),'DH')
       L2(i) = 1;
    elseif strcmp(B(i),'SL')
       L2(i) = 2;
    else
       L2(i) = 3;
    end
end
columnDataset = [columnDataset,L2'];
%% Data Preprocessing for Seeds dataset
fid2 = fopen('seeds_dataset.txt');
seedData = textscan(fid2,'%f %f %f %f %f %f %f %f');
seedDataset = [seedData{1,1},seedData{1,2},seedData{1,3},seedData{1,4},seedData{1,5},seedData{1,6},seedData{1,7},seedData{1,8}];
%% Data Preprocessing for Iris dataset
fid = fopen('irisData.txt');
irisData = textscan(fid,'%f,%f,%f,%f,%s');
irisDataset = [irisData{1,1},irisData{1,2},irisData{1,3},irisData{1,4}];
A = irisData{1,5};
L = [];
for i=1:length(A)
   
    if strcmp(A(i),'Iris-setosa')
       L(i) = 1;
    elseif strcmp(A(i),'Iris-versicolor')
           L(i) = 2;
    else
        L(i) = 3;
    end
end
irisDataset = [irisDataset,L'];
%%
numOfIterations = 10; %% Desired Number of Cluster Centroids
[N,D] = size(segData2); %% name of the desired dataset
numOfCentroids = 12;
Centroids = [];
for i = 1: numOfCentroids
   
    Centroid = segData2(floor((N-1)*rand),1:end-1); %% name of the desired dataset
    Centroids = [Centroids;Centroid];
    
end
objFunc = [];
for numOfIterations=1:20

    [newCentroid,lables,evaluationMatrix,objectiveFunction] = my_kMeans(segData2,Centroids,numOfIterations); %% name of the desired dataset
    objFunc = [objFunc,objectiveFunction];
end
figure;
plot(1:length(objFunc),objFunc);
