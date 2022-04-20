function process_two_project_versions(obj,project_before, project_after)
    model_before_list = obj.get_list_of_sim_model(project_before);
    
    project_before_split = split(project_before,filesep);
    project_folder_before = project_before_split(end);
    
    project_after_split = split(project_after,filesep);
    project_folder_after = project_after_split(end);
    
    project_before_sha = obj.get_project_sha(project_before);
    obj.WriteLog(sprintf('Before Project SHA = %s',project_before_sha));
    project_after_sha = obj.get_project_sha(project_after);
    obj.WriteLog(sprintf('After Project SHA = %s',project_after_sha));
    for i = 1:numel(model_before_list)
        potential_model_project_after = fullfile(project_after,model_before_list(i));
        if isfile(potential_model_project_after)
            try
                obj.WriteLog(sprintf('Comparing %s',model_before_list(i)));
                comparison_res = obj.compare_two_models(fullfile(project_before,model_before_list(i)),potential_model_project_after);
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
        else
            obj.WriteLog(sprintf('Skipping %s',model_before_list(i)));
        end
    end

end

