# Replication of the Model Based Study with [SLNET]
SL-corpus-0 replication study refers to replication of this [Paper]

Set up project according to SLNET-Metrics README File. Create an object for model_metric
````
	> model_metric_obj = model_metric();
````
### Getting SLNET model metrics presented in the paper. 
Download SLNET_v1.zip from [SLNET] and update the dbfile to "slnet_v1.sqlite" in model_metric_cfg.m

##### To get correlation related results, run
````
	model_metric_obj.correlation_analysis(false,'GitHub','MATC') 
````

##### To get cumulative model metrics per source repository, run
````
 model_metric_obj.total_analyze_metric('<Table Name>',false)
 ````
 where <Table Name> is either ``GitHub_Models`` or ``MATC_Models``
 
##### To get all the model metrics from all the table/sources combined
 ````
	model_metric_obj.grand_total_analyze_metric(false)
 ````	
 
##### To get all other findings and comparison with earlier corpus reported metrics
````	
	model_metric_obj.analyze_metrics(false)
````	

### Getting SL-corpus-2's model metric
Download `` Sl-Corpus-2_exclude_lib.sqlite``, ``Sl-Corpus-2_include_lib.sqlite`` from [here] 

##### To get correlation related results (which include library-imported blocks)
Update the dbfile to`` Sl-Corpus-2_include_lib.sqlite`` in model_metric_cfg.m and run . 
````
	model_metric_obj.correlation_analysis(true,'GitHub','Tutorial','sourceforge','matc','Others') .
````

##### To get correlation related results (which include library-imported blocks or )
Update the dbfile to`` Sl-Corpus-2_exclude_lib.sqlite`` in model_metric_cfg.m and run . 
````
	model_metric_obj.correlation_analysis(true,'GitHub','Tutorial','sourceforge','matc','Others') .
````

For rest of the metrics, Update the dbfile to`` Sl-Corpus-2_exclude_lib.sqlite`` in model_metric_cfg.m and run . 
##### To get cumulative model metrics per Table
````
	model_metric_obj.total_analyze_metric('<Table Name>',true)
````
 where <Table Name> is either ``GitHub_Models`` or ``MATC_Models`` or ``Others_Models`` or ``Tutorial_Models`` or ``SourceForge_Models`` 
 
##### To get all the model metrics from all the table/sources combined
````
	model_metric_obj.grand_total_analyze_metric(true)
````
##### To get all other findings.
````	
	model_metric_obj.analyze_metrics(true)
```` 


	
[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)
[paper]:http://ranger.uta.edu/~csallner/papers/Chowdhury18Curated.pdf
[here]:https://zenodo.org/record/6374469#.YjkRkITMJhE
[SLNET]:https://zenodo.org/record/5259648#.Yjj854TMKV4

