function hadamard_te_asl_signal_for_a_voxel()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%           Develper: Sahar Yousefi
% This program plots the hadamard time encoded arterial spin labeling
% signal for Hadamard matrix of rank 8 in a voxel
%% Please cite the below paper:
%  @inproceedings{yousefi2019fast,
%  title={Fast Dynamic Perfusion and Angiography Reconstruction 
%  Using an End-to-End 3D Convolutional Neural Network},
%  author={Yousefi, Sahar and Hirschler, Lydiane and van der Plas, 
%  Merlijn and Elmahdy, Mohamed S and Sokooti, Hessam and Van Osch, 
%  Matthias and Staring, Marius},
%  booktitle={International Workshop on Machine Learning 
%  for Medical Image Reconstruction},
%  pages={25--35},
%  year={2019},
%  organization={Springer}
%  }
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
clc
close all
clear all
%Lable duration
tau_vec = 0.001.*[528,528,528,528,528,528,528;
                  600,600,600,600,600,600,600;
                  1300,600,400,400,400,300,300;
                  500,500,500,500,500,500,500;
                  400,400,400,400,400,400,400;];
%Arterial transit time              
delta_t_a=0.001.*[1265,1665,2065,2665,2714]; 
%Arterial blood relaxation
T1a=0.001.*[1200,1400,1600,1800,2000];
%Hadamard matrix
L=-2.*[-1    -1     0     0     0     0    -1
        0    -1    -1     0    -1     0     0
        -1    0    -1     0     0    -1     0
        0     0     0     0    -1    -1    -1
        -1   -1     0    -1    -1    -1     0
        0    -1    -1    -1     0    -1    -1
        -1    0    -1    -1    -1     0    -1
        0     0     0    -1     0     0     0];
color=['r','g','b','y','k','b','c','m'];
L_row=1;
plt_c=1;
figure(1),
for i=1:length(T1a)
    curve=hadamard_signal_curve(delta_t_a(1),tau_vec(1,:),T1a(i),L,L_row);
    hold on
    subplot(3,1,plt_c)
    plot(curve,color(i))
end
plt_c=plt_c+1;
legend(num2str(T1a(1)),num2str(T1a(2)),num2str(T1a(3)),num2str(T1a(4)),num2str(T1a(5)))
title('T_1_a')
hold off

figure(1),hold on
for i=1:length(delta_t_a)
    curve=hadamard_signal_curve(delta_t_a(i),tau_vec(1,:),T1a(1),L,L_row);
    hold on
    subplot(3,1,plt_c)
    plot(curve,color(i))
end
plt_c=plt_c+1;
legend(num2str(delta_t_a(1)),num2str(delta_t_a(2)),num2str(delta_t_a(3)),num2str(delta_t_a(4)),num2str(delta_t_a(5)))
title('\Delta t')
hold off


figure(1),hold on
for i=1:size(tau_vec,1)
    curve=hadamard_signal_curve(delta_t_a(1),tau_vec(i,:),T1a(1),L,L_row);
    subplot(3,1,plt_c)
    hold on
    plot(curve,color(i))
end
plt_c=plt_c+1;
legend(num2str(sum(tau_vec(1,:))),num2str(sum(tau_vec(2,:))),num2str(sum(tau_vec(3,:))),num2str(sum(tau_vec(4,:))),num2str(sum(tau_vec(5,:))))
title('\tau')
hold off
end