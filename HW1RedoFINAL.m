close all, clear all;

%Homework 01 - Second Submission
%assignment completed during assitance during office hours and some
%collaboration with others

%Create 10cm finely sampled 3D cube

n=100; %Instead of n=10, use 100 to finely sample matrix
I = zeros(n, n, n); %create cube with finely sampled 3D matrix

%define units 
x=1:1:n;
y=1:1:n; 
z=1:1:n;

%defines as cm (as shift and scale)
x=x/10; % changing scale from 0-100 to 0-10 (divide by 10)
x=x-5; % shifts x range by -5 (range shifts from (0 to 10) to (-5 to 5)) bring 0 to center of cube
y=y/10; %can also use 'y=x;' to make same as x above
y=y-5;
z=z/10; %can also use 'z=x;' to make same as x above
z=z-5;

[X,Y,Z] = meshgrid(x,y,z); %combines x, y, z, vectors to make matrix/cube

%%

%Create a sphere 5cm centered inside cube
%Sphere filled with ones

distance = sqrt(X.^2 + Y.^2 + Z.^2); 
slice_x=distance(3,:,:); 
slice_y=distance(:,3,:);
slice_z=distance(:,:,8);

%%

%Mask function: 

I(distance<2.5)=1; %fills ones for all values with a distance of less than 2.5 in 3D volume(sphere distance of 5)
%take all distances below 2.5 (radius) in I, assigning them to ones
figure 
imagesc(squeeze(I(:,:,50))), title('z = 50 (Center Slice)') %take slice 50 because sampled 100x100x100 (50 should be middle)%snapnow
snapnow
figure 
imagesc(squeeze(I(:,:,74))), title('z = 74 (Offset Slice)') %74 equal to +2.4cm if 50 equal to center or (Z=0)
snapnow

%%
%Part 2 - Repeat with 0.5cm thick slices

n=200; %use 200 to finely sample matrix (200 samples over 10cm = 0.05 cm)
I = zeros(n, n, n); %create cube with finely sampled 3D matrix

x=1:1:n;
y=1:1:n; 
z=1:1:n;

%defines as cm (shift and scale)
x=x/20; % changing scale from 0-200 to 0-10 (divide by 10)
x=x-5; % shifts x range by -5 (range shifts from (0 to 10) to (-5 to 5)) bring 0 to center of cube
y=y/20; 
y=y-5;
z=z/20; 
z=z-5;

[X,Y,Z] = meshgrid(x,y,z); 
%%
%Create a sphere 5cm centered inside cube
%sphere filled with ones

distance = sqrt(X.^2 + Y.^2 + Z.^2); 
slice_x=distance(3,:,:); 
slice_y=distance(:,3,:);
slice_z=distance(:,:,8);

%Mask function: 

I(distance<2.5)=1;
figure
imagesc(squeeze(I(:,:,100))), title('Ideal Slice: Center (z=100)') %take slice 100 because sampled 200x200x200(100 should be middle)
snapnow
%%
%sample 10 slices, 0.05cm apart (equal to 0.5mm)

%Thick Slice
Thick_slice_center=I(:,:,97.5:102.5);
DIM=3;
%S=sum(X,DIM)
S=sum(Thick_slice_center,DIM);
figure
imagesc(S), title('Thick Slice Integration: Sphere Center')
snapnow

Thick_slice_edge=I(:,:,57.5:62.5); %edge slice
S1=sum(Thick_slice_edge,DIM);
figure
imagesc(S1), title('Thick Slice Integration: Sphere Edge')
snapnow
%The thick slice integrated at the center of the sphere has minimal change with very few pixel values changed
%at the edges of the sphere. 
%Many more pixels have changed value as a result of integrating slices at
%the edge of the sphere as noted by the pixel value change at the sphere
%periphery


%%
%Thresholding
%Max already defined in calculation
T=0.25;
Threshold_center=imbinarize(S,T);
figure
imagesc(Threshold_center), title('Center Slice 0.25 Threshold')
snapnow

Threshold_edge=imbinarize(S1,T);
figure
imagesc(Threshold_edge), title('Edge Slice 0.25 Threshold')
snapnow


T1=0.5
Threshold_center=imbinarize(S,T1);
figure
imagesc(Threshold_center), title('Center Slice 0.5 Threshold')
snapnow

Threshold_edge=imbinarize(S1,T1);
figure
imagesc(Threshold_edge), title('Edge Slice 0.5 Threshold')
snapnow


T2=0.75
Threshold_center=imbinarize(S,T2);
figure
imagesc(Threshold_center), title('Center Slice 0.75 Threshold')
snapnow

Threshold_edge=imbinarize(S1,T2);
figure
imagesc(Threshold_edge), title('Edge Slice 0.75 Threshold')
snapnow

%Thresholding appears to restore the results of partial voluming on the
%thick slice integration back to the original idela slice values