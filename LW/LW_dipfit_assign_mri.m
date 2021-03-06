function [out_configuration,out_datasets] = LW_dipfit_assign_mri(operation,configuration,datasets,update_pointers)
% LW_dipfit_assign_mri
% DIPFIT : assign MRI data
%
% operations : 
% 'gui_info'
% 'default'
% 'process'
% 'configure'
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


%argument parsing
if nargin<1;
    error('operation is a required argument');
end;
if nargin<2;
    configuration=[];
end;
if nargin<3;
    datasets=[];
end;
if nargin<4;
    update_pointers=[];
end;

%gui_info
gui_info.function_name='LW_dipfit_assign_mri';
gui_info.name='dipfit : load MRI data';
gui_info.description='dipfit : load MRI data.';
gui_info.parent='source_analysis_menu';
gui_info.scriptable='yes';                      %function can be used in scripts?
gui_info.configuration_mode='direct';           %configuration GUI run in 'direct' 'script' 'history' mode?
gui_info.configuration_requires_data='no';      %configuration requires data of the dataset?
gui_info.save_dataset='yes';                    %process requires to save dataset? 'yes', 'no', 'unique'
gui_info.process_none='no';                     %for functions which have nothing to process (e.g. visualisation functions)
gui_info.process_requires_data='no';           %process requires data of the dataset?
gui_info.process_filename_string='mri';       %default filename suffix (or filename (if 'unique'))
gui_info.process_overwrite='yes';                %process should overwrite the original dataset?

%operation
switch operation
    
    case 'gui_info'
        %configuration
        out_configuration=configuration;
        out_configuration.gui_info=gui_info;
        %datasets
        out_datasets=datasets;
        
    case 'default'
        %configuration
        out_configuration=configuration;
        out_configuration.gui_info=gui_info;
        out_configuration.parameters.mri_filename=[];
        out_configuration.parameters.mri=[]; %process
        %datasets
        out_datasets=datasets;
        
    case 'process'
        out_datasets=[];
        %handles feedback
        if isempty(update_pointers) else update_pointers.function(update_pointers.handles,'*** DIPFIT : assign MRI.',1,0); end;
        %datasets
        out_datasets=datasets;
        for setpos=1:length(datasets);
            %process
            [mri,message_string]=RLW_dipfit_assign_mri(configuration.parameters.mri_filename);
            %message_string
            if isempty(update_pointers);
            else
                if isempty(message_string);
                else
                    for i=1:length(message_string);
                        update_pointers.function(update_pointers.handles,message_string{i},1,0);
                    end;
                end;
            end;
            %store chanlocs in configuration
            configuration.parameters.mri=mri;
            %store out_configuration
            out_configuration=configuration;
            %add configuration to history
            if isempty(out_datasets(setpos).header.history);
                out_datasets(setpos).header.history(1).configuration=out_configuration;
            else
                out_datasets(setpos).header.history(end+1).configuration=out_configuration;
            end;
            %update header.name
            if strcmpi(configuration.gui_info.process_overwrite,'no');
                out_datasets(setpos).header.name=[configuration.gui_info.process_filename_string ' ' out_datasets(setpos).header.name];
            end;
        end;
        if isempty(update_pointers) else update_pointers.function(update_pointers.handles,'Finished.',0,1); end;

        
    case 'configure'
        %configuration
        [a out_configuration]=GLW_dipfit_assign_mri('dummy',configuration,datasets);
        %datasets
        out_datasets=datasets;
        
        
        
        
end;
