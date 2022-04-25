classdef compareModelSnapshot
    %COMPAREMODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        proj_commit_snapshot_folder;
        project_name; %Project name is the name of the project when downloaded GitHub zip is extracted 
        working_dir;
        
         colnames = {'Before_Project_SHA','After_Project_SHA','Model',...
             'Before_Project_Folder','After_Project_Folder', ...
            'Block_Path','Node_Type','Block_Type',...,
            'is_deleted','is_modified','is_added','is_renamed'};
        coltypes = {'VARCHAR','VARCHAR','VARCHAR',...
            'VARCHAR','VARCHAR', ...
             'VARCHAR','VARCHAR','VARCHAR',...
            'BOOLEAN','BOOLEAN','BOOLEAN','BOOLEAN'};
        conn;
        table_name;
        logfilename;
        blk_category_map;
    end
    
    methods
        function obj = compareModelSnapshot(proj_commit_snapshot_folder,model_comparison_utility_folder,project_name)
           obj.proj_commit_snapshot_folder = proj_commit_snapshot_folder;
           obj.project_name = project_name;
           obj.working_dir = 'workdir';
           obj.logfilename = strcat('Model_Snapshot_Compare',datestr(now, 'dd-mm-yy-HH-MM-SS'),'.txt');
           
           obj.WriteLog('open');
     
        
            if(~exist(obj.working_dir,'dir'))
                    mkdir(obj.working_dir);
            end
            db = "model_compare_new.sqlite";
            obj.table_name = "Model_Comparison_Across_Commit";
            obj.conn = obj.connect_db_and_create_table(db,obj.table_name);
            
            %Block Category
            
            block_lib_map = utils.getblock_library_map();
            block = keys(block_lib_map);
            obj.blk_category_map = containers.Map();
            categories = java.util.HashSet;
        
            for i = 1:length(block)
                lib = block_lib_map(block{i}); % cell 
                blk_type = block{i};
                category = utils.get_category(blk_type,lib{1},true);
                categories.add(category);
                if ~isKey(obj.blk_category_map,category)
                    obj.blk_category_map(category) = java.util.HashSet;
                    obj.blk_category_map(category).add(blk_type);
                else
                    obj.blk_category_map(category).add(blk_type);
                end
            
            end
            obj.blk_category_map('Structural').add('Reference');
             obj.blk_category_map('Trigger').add('ActionPort');
            utils.print_map(obj.blk_category_map);
           %Adding the utility in the matlab path
           addpath(genpath(model_comparison_utility_folder));
           
        end
        
       
        WriteLog(obj,Data);
        conn = connect_db_and_create_table(obj,db,table_name);
        
        res = compare_two_models(obj,model_before, model_after);
        
        model_list = get_list_of_sim_model(obj,project_before);
        renamed_model = add_letter_to_name(obj,model_full_path,letter);
        project_sha = get_project_sha(obj,project_after);
        output_bol = write_to_database(obj,before_sha, after_sha,model,before_folder, after_folder,comparison_res_table);
        process_two_project_versions(obj,project_before, project_after);  
        process_project(obj,project);
        
        
        %Replication and plots
        %ChangeType and counts
        nodeandchangetype_count_map = get_nodeandchangetype_count_map(obj);
        res_vector = get_vector_per_node_type(obj, node_type,nodeandchangetype_count_map);
        
        %block Type and counts
        [blk_type_name, blk_count] = get_block_type_and_count_over_20(obj);
        
       
        [blocktype_changetype,median_of_change] = get_median_of_block_change_per_commit(obj);
        [changetype,median_no_of_change] = get_median_of_node_change_per_commit(obj,nodetype);
        
        %bubbble chart category change
        [category, category_change_percent] = get_blocktype_blockpath_count(obj);
        replicate_plots_and_results(obj);
    end
end

