# We will use Ubuntu for our image
FROM ubuntu:18.04

# Updating Ubuntu packages
RUN apt-get update && yes|apt-get upgrade
RUN apt-get update && yes|apt-get install -y vim
RUN apt-get install -y emacs

# Adding wget, bzip2, nodejs and git
RUN apt-get install -y wget bzip2 git

# Adding gcc
RUN apt-get install -y build-essential manpages-dev

# Add sudo
RUN apt-get -y install sudo

# Adding Extension
RUN apt-get install -y curl dirmngr apt-transport-https lsb-release ca-certificates
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
RUN apt-get install -y nodejs

# Add user ubuntu with no password, add to sudo group
RUN adduser --disabled-password --gecos '' ubuntu
RUN adduser ubuntu sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ubuntu
WORKDIR /home/ubuntu/
RUN chmod a+rwx /home/ubuntu/

# Anaconda installing
RUN wget https://repo.anaconda.com/archive/Anaconda3-2020.11-Linux-x86_64.sh
RUN bash Anaconda3-2020.11-Linux-x86_64.sh -b
RUN rm Anaconda3-2020.11-Linux-x86_64.sh

# Set path to conda
ENV PATH /home/ubuntu/anaconda3/bin:$PATH

# Updating Anaconda packages
RUN conda update conda
RUN conda update anaconda
RUN conda update --all
# Configuring access to Jupyter
RUN mkdir /home/ubuntu/notebooks
RUN mkdir /home/ubuntu/.jupyter
RUN conda install -y -c conda-forge jupyterlab

# Extension
RUN jupyter labextension install @jupyterlab/google-drive
RUN jupyter labextension install @jupyterlab/github
RUN jupyter labextension install @jupyterlab/git
RUN pip install jupyterlab-git
RUN jupyter serverextension enable --py jupyterlab_git
RUN jupyter labextension install jupyterlab-drawio
RUN pip install jupyter-lsp
RUN jupyter labextension install @krassowski/jupyterlab-lsp
RUN pip install 'python-language-server[all]'
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager

# requirement.txt
RUN pip install altair
RUN pip install fasttext
RUN pip install faiss-cpu
RUN pip install jmespath
RUN pip install sentencepiece
RUN pip install icecream
RUN pip install spacy
RUN pip install rank-bm25
RUN pip install gensim
