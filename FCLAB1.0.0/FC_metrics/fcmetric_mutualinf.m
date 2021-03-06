function outEEG = fcmetric_mutualinf(inEEG)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Usage:
%
%   >>  outEEG = fcmetric_mutualinf(inEEG);
%
% Inputs:
%           inEEG   - input EEG dataset
%   
% Outputs:
%           outEEG  - output EEG dataset
%
% Info:
%           Computes the mutual information for each possible pair of EEG 
%           channels and for every band as well.
%
% Mathematical background:
%           Mutual information quantifies the mutual dependence between two 
%           random variables, assume x and y. It can be defined as:
%       
%                           I = ?[p(x,y)*log(p(x,y)/p(x)*p(y))]
%
%           where p(x,y) is the joint probability function between x and y, 
%           and p(x), p(y) are the marginal probability distribution 
%           functions of x and y, respectively. 
%
% Fundamental basis:
%           Mutual information varies between 0 and 1 where 1 denotes a 
%           complete dependence between the two variables and 0 otherwise.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

w = warning('query','last');
outEEG = inEEG;
id = w.identifier;
warning('off',id);
mf = size(inEEG.FC.parameters.bands, 1);
disp('>> FCLAB: Mututal information is being computed...');

for band = 1:mf
    testEEG = inEEG;
    freq_range = str2num(inEEG.FC.parameters.bands{band,1});
    [testEEG, ~, ~] = pop_eegfiltnew(testEEG, freq_range(1));
    [testEEG, ~, ~] = pop_eegfiltnew(testEEG, [], freq_range(2));
    for i = 1:inEEG.nbchan
        for j = 1:inEEG.nbchan
           Matrix(i,j) = mutualinf(inEEG.data(i,:)',inEEG.data(j,:)',inEEG.srate,freq_range(1),freq_range(2));
        end
    end
    disp(num2str(size(Matrix,1)))
    disp(num2str(size(Matrix,2)))
    Matrix = Matrix + Matrix';
    eval(['outEEG.FC.mutualinf.' strrep(inEEG.FC.parameters.bands{band,2},' ','_') '.adj_matrix=Matrix;']);
end
