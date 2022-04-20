function process_project(obj)
     all_sub_folders = dir(obj.proj_commit_snapshot_folder);
     all_sub_folders = all_sub_folders(3:end);
     sub_folder_num = length(all_sub_folders);
     obj.WriteLog(sprintf('Total Number of Project Snapshots = %d',sub_folder_num));
     
     processing_folder_sql = ['SELECT Distinct Before_project_folder from ' char(obj.table_name) ];
     results = fetch(obj.conn,processing_folder_sql);
     
     % Restart processing from the folder location which has not been fully
     % processed (i.e. it has been processed both as before and after folder)
     if ~isempty(results)
         results_num = cellfun(@(x) str2double(x),results,'UniformOutput',false);
         start_cnt = max(cell2mat(results_num));
         
         obj.WriteLog(sprintf('Deleting %d based comparison ',start_cnt));
         sqlquery = ['DELETE FROM ' char(obj.table_name) ' WHERE ' ...
            'Before_Project_Folder >= ' char(num2str(start_cnt)) ];
        obj.WriteLog(sprintf('SQL Query: %s ',sqlquery));
          
          exec(obj.conn,sqlquery);
          start_cnt = start_cnt +1;
     else
         start_cnt = 2;
     end
     for cnt = start_cnt:sub_folder_num
         
         
         
         obj.WriteLog(sprintf('Comparing %d and %d ',cnt-1, cnt));
         project_before = fullfile(obj.proj_commit_snapshot_folder,string(cnt-1));
         project_after = fullfile(obj.proj_commit_snapshot_folder,string(cnt));
         obj.process_two_project_versions(project_before, project_after);
         
         
         obj.WriteLog(sprintf('=======Folder %d processed====== ',cnt-1));
         
     
     end
     
end

