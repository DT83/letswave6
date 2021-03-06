function [out_header,out_data,message_string]=RLW_arrange_channels(header,data,channel_idx);
%RLW_arrange_channels
%
%Arrange or delete channels
%
%header
%data
%channel_idx
%
% Author : 
% Andre Mouraux
% Institute of Neurosciences (IONS)
% Universite catholique de louvain (UCL)
% Belgium
% 
% Contact : andre.mouraux@uclouvain.be
% This function is part of Letswave 6
% See http://nocions.webnode.com/letswave for additional information
%


%init message_string
message_string={};
message_string{1}='Arrange or delete channels';
message_string{end+1}=['Number of channels : ' num2str(length(channel_idx))];

%prepare out_header
out_header=header;

%data
out_data=data(:,channel_idx,:,:,:,:);

%change number of channels
out_header.datasize=size(out_data);

%adjust chanlocs
out_header.chanlocs=header.chanlocs(channel_idx);



