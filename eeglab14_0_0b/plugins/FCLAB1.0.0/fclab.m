% pop_fclab() - Functional Connectivity Lab for EEGLAB  
%
% Usage:
%   >>  OUTEEG = pop_fclab( INEEG, type );
%
% Inputs:
%   INEEG   - input EEG dataset
%   type    - type of processing. 1 process the raw
%             data and 0 the ICA components.
%   
%    
% Outputs:
%   OUTEEG  - output dataset
%
% See also:
%   SAMPLE, EEGLAB 

% Copyright (C) <year>  <name of author>
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

function [outEEG, com] = fclab(inEEG)
if nargin < 1
    error('FCLAB:Need parameters');
	return;
end
outEEG=inEEG;
fclab_dependences(); % check for dependences and download.

if ~strcmp(inEEG.FC.parameters.metric, 'all');
   eval(['outEEG=' inEEG.FC.parameters.metric '(inEEG);']);
   if inEEG.FC.parameters.graph == 1
       outEEG = fclab_graphparameters(outEEG);
   end;
else
disp('implement for all algorithms')
end


disp('>> FCLAB: Done!');

%% Print executed command
com = sprintf('fclab( %s, %s );', inputname(1), 'params');

return;