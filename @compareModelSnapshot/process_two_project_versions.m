function process_two_project_versions(obj,project_before, project_after)
    model_before_list = obj.get_list_of_sim_model(project_before);
    model_after_list = obj.get_list_of_sim_model(project_after);
    
    all_models = utils.combine_two_list(model_before_list,model_after_list);
    
    project_before_split = split(project_before,filesep);
    project_folder_before = project_before_split(end);
    
    project_after_split = split(project_after,filesep);
    project_folder_after = project_after_split(end);
    
    project_before_sha = obj.get_project_sha(project_before);
    obj.WriteLog(sprintf('Before Project SHA = %s',project_before_sha));
    project_after_sha = obj.get_project_sha(project_after);
    obj.WriteLog(sprintf('After Project SHA = %s',project_after_sha));
    
    for i = 1:numel(all_models)
        potential_model_project_before = fullfile(project_before,all_models(i));
        potential_model_project_after = fullfile(project_after,all_models(i));
        
        
        if isfile(potential_model_project_after) & isfile(potential_model_project_before)
            obj.WriteLog(sprintf('Comparing %s',all_models(i)));
        elseif ~isfile(potential_model_project_before)
            potential_model_project_before = 'blank_model.slx';
        elseif ~isfile(potential_model_project_after)
            potential_model_project_after = 'blank_model.slx';
        else
            error('ERROR');
        end
        try
            obj.WriteLog(sprintf('Comparing %s',all_models(i)));
            comparison_res = obj.compare_two_models(potential_model_project_before,potential_model_project_after);
        catch ME
            obj.WriteLog(sprintf('ERROR Comparing models snapshot '));                    
            obj.WriteLog(['ERROR ID : ' ME.identifier]);
            obj.WriteLog(['ERROR MSG : ' ME.message]);
            continue;
        end
        if isa(comparison_res,'table')
            try
                obj.write_to_database(project_before_sha,project_after_sha,model_before_list(i), ...
                    project_folder_before,project_folder_after,comparison_res);
            catch ME
                obj.WriteLog(sprintf('ERROR Inserting into database '));                    
                obj.WriteLog(['ERROR ID : ' ME.identifier]);
                obj.WriteLog(['ERROR MSG : ' ME.message]);
                continue;
            end
        end
        
    end

end

