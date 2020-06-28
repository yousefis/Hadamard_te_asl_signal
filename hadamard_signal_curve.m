function curve=hadamard_signal_curve(delta_t_a,tau_vec,T1a,L,L_row)
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
%static tissue signal
kapa=0;
%Hadamard matrix
hadamard_mat = [1  1  1  1  1  1  1  1
    1 -1  1 -1  1 -1  1 -1
    1  1 -1 -1  1  1 -1 -1
    1 -1 -1  1  1 -1 -1  1
    1  1  1  1 -1 -1 -1 -1
    1 -1  1 -1 -1  1 -1  1
    1  1 -1 -1 -1 -1  1  1
    1 -1 -1  1 -1  1  1 -1];
M0a=1;
f=0.01;
points=10000;
asl_sig=zeros(1,points);
N=size(hadamard_mat,1)-1;
for t=1:points
    asl_sig(t)=signal_per_voxel(t*.001,tau_vec,delta_t_a,T1a,M0a,f,L_row,L,N);
end
curve=asl_sig+kapa;
end

