function asl_sig=signal_per_voxel(t,tau_vec,delta_t_a,T1a,M0a,f,L_row,L,N)
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
eps=.00000000000000000001;
if t<delta_t_a
    asl_sig=0;
elseif delta_t_a<=t && t< delta_t_a+sum(tau_vec(1))
    asl_sig=M0a*f*exp(-delta_t_a/(T1a+eps))*T1a*L(L_row,1)*(1-exp(-(t-delta_t_a)/(T1a+eps)));
    
    
elseif t>=delta_t_a+sum(tau_vec(1:7))
    B=N;
    middle_term=0;
    for i=B:-1:2
        middle_term = middle_term + L(L_row,i)*(exp(-(t-delta_t_a-sum(tau_vec(1:i)))/(T1a+eps))-exp(-(t-delta_t_a-sum(tau_vec(1:i-1)))/(T1a+eps)));
    end
    
    asl_sig=M0a*f*exp(-delta_t_a/(T1a+eps))*T1a*( middle_term+...
        L(L_row,1)*(exp(-(t-delta_t_a-tau_vec(1))/(T1a+eps))-exp(-(t-delta_t_a)/(T1a+eps))));
    
else
    for B=2:N
        if delta_t_a+sum(tau_vec(1:B-1))<=t && t< delta_t_a+sum(tau_vec(1:B))
            middle_term=0;
            for i=B-1:-1:2
                middle_term = middle_term + L(L_row,i)*(exp(-(t-delta_t_a-sum(tau_vec(1:i)))/(T1a+eps))-exp(-(t-delta_t_a-sum(tau_vec(1:i-1)))/T1a));
            end
            
            asl_sig=M0a*f*exp(-delta_t_a/(T1a+eps))*T1a*( L(L_row,B)*(1-exp(-(t-delta_t_a-sum(tau_vec(1:B-1)))/(T1a+eps)))+...
                middle_term+...
                L(L_row,1)*(exp(-(t-delta_t_a-tau_vec(1))/(T1a+eps))-exp(-(t-delta_t_a)/(T1a+eps))));
            
            break;
        end
    end
    
end


asl_sig=asl_sig;
end

