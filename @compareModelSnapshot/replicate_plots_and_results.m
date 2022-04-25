function replicate_plots_and_results(obj)
    nodeandchangetype_count_map = obj.get_nodeandchangetype_count_map();
    node_type = {'block','line','port','mask','annotation','configuration'};
    node_changetype_matrix = [];
    for i = 1:length(node_type)
        tmp_vector = obj.get_vector_per_node_type(node_type{i},nodeandchangetype_count_map);
        node_changetype_matrix = [node_changetype_matrix; tmp_vector];
    end
    plot.plot_stacked_bar(node_changetype_matrix,node_type);   
    
    
    [blk_type_name, blk_count] = obj.get_block_type_and_count_over_20();
    plot.plot_bar(blk_type_name,blk_count,500,90,90);
    
    [changetype,median_no_of_change] = obj.get_median_of_block_change_per_commit();
    plot.plot_bar(changetype,median_no_of_change,1,75,0);
    
    [category, category_change_percent] = obj.get_blocktype_blockpath_count();
        plot.plot_bubblechart(category,category_change_percent);        
end

