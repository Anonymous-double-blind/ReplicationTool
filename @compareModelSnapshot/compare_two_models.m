function res = compare_two_models(obj,model_before, model_after)
    delete(strcat(obj.working_dir,"/*"))
    bdclose('all');
    
    model_before_renamed = obj.add_letter_to_name(model_before,"x");
    model_before_renamed_fp = fullfile(obj.working_dir,model_before_renamed);
    copyfile(model_before,model_before_renamed_fp);
    
    model_after_renamed = obj.add_letter_to_name(model_after,"y");
    model_after_renamed_fp = fullfile(obj.working_dir,model_after_renamed);
    copyfile(model_after,model_after_renamed_fp);
    
    load_system(model_before_renamed_fp);
    load_system(model_after_renamed_fp);
    
    Edits = slxmlcomp.compare(model_before_renamed_fp, model_after_renamed_fp);
    %plotTree(Edits);
    %summaryOfChanges(Edits, 1);
    if isempty(Edits)
        res = -1;
    else
        res = treeToTable(Edits);
    end
    close_system(model_before_renamed_fp);
    close_system(model_after_renamed_fp);
    delete(strcat(obj.working_dir,"/*"))
end

