# Replicating Study on Simulink Models
This work replicates various findings related to Simulink models and modeling practices and analyzes publicly available corpora of Simulink models. 
Project Evolution can be used to extract commit history of any github project. The history is maintained in sqlite database. 

### Installation

Tested on Ubuntu 18.04 

First, create virtual environment using  [Anaconda] so that the installation does not conflict with system wide installs.
```sh
$ conda create -n <envname> python=3.7
```

Clone the project and install the dependencies
```sh
$ git clone <gitlink>
$ cd ReplicationTool
```

Activate environment and Install the dependencies.
```sh
$ conda activate <envname>
$ pip install -r requirements.txt
```

### Usage

#### 1. Project Evolution
This package extracts project and model commit history of [SLNET]. Note that some projects may go offline in which case skip those projects by including it in main() function. 

Update the source database(slnet_v1.sqlite) and destination database (say github_evol.sqlite) in project_evol.py file.
```sh
$ cd project_evolution
$ python project_evol.py
```

Note that the commits extracted are upto the time when [SLNET] are packaged. To get the most latest commits, remove ''to_commit'' argument in  get_<project/model>_level_commits.py file

#### 2. Analyze Data
Download the [Analysis Data] and [SLNET]
Update the respective database full path in the script as required.
1. Update slnet_analysis_data.sqlite in the analyze_lifecycle.py data. This script will create the model and project commit plot.
2. Update slnet_analysis_data.sqlite in analyzeProjects.py. This script will show all project level commit distribution 
3. Update slnet_v1.sqlite in get_SLNET_plots.py. This script will show all analysis data and plots of SLNET. 
4. Update Sl-Corpus-2_exclude_lib.sqlite in to_plot_slcorpus2_most_freq_blks.py. This script will plot most frequently used blocks of slcorpus-2. 

To run the script

```sh
$ python <python file>
```

#### 3. SLNET-Metrics-Extended is a extension of [SLNET-Metrics]. It is used to extract metrics of Simulink Model in [SLNET] and Sl-Corpus-2
Refer to [Replication.md] to reproduce the numbers reported in the paper.


#### Note Sl-Corpus-X is refered as SLCX in the paper, where X is 0,1,2
[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)
   [Anaconda]: <https://www.anaconda.com/distribution/>
   [SLNET]: <https://zenodo.org/record/3911155#.Yjite4TMKV4>
   [Analysis Data]: <https://zenodo.org/record/4915021#.Yjitx4TMKV4>
   [Replication.md]: <https://github.com/Anonymous-double-blind/ReplicationTool/blob/main/SLNET_Metrics-Extended/replication.md>
   [SLNET-Metrics]: <https://github.com/50417/SLNET_Metrics>
