function [blk_type_name, blk_count] = get_block_type_and_count(obj)

         block_type_and_count_query = ['SELECT * FROM ' ... 
                ' (SELECT count(*) cnt, block_type ' ...
                ' FROM ' char(obj.table_name) ...
                ' WHERE Block_Type != ""' ...
                ' GROUP BY block_type)' ...
                ' WHERE cnt > 20' ...
                ' ORDER BY cnt desc'];
            
        result = fetch(obj.conn, block_type_and_count_query);
        [rows,~] = size(result);
        
        blk_count = [];

        for r = 1:rows
            blk_count = [blk_count result{r,1}];  
        end
        blk_type_name = result(:,2)';
end

