FROM ubuntu:latest

MAINTAINER Andy.Wang <xswang_k@163.com>

# copy biotools to /bioTools
COPY ref_packages/ /bioTools/ 

# configure the system, install the neccessary tools
RUN apt-get update \
&& apt-get -f install -y make git wget python3 python2.7 vim g++ curl zip gcc ruby zlib1g zlib1g.dev \
libbz2-dev libncurses-dev liblzma-dev bedtools python3-pip


# install bio tools.
RUN cd /bioTools/bwa && make 
RUN cd /bioTools && tar -jxvf htslib-1.9.tar.bz2 && cd htslib-1.9 && make && make install 
RUN cd /bioTools && tar -jxvf samtools-1.9.tar.bz2 && cd samtools-1.9 && make && make install 
RUN cd /bioTools && tar -jxvf bcftools-1.9.tar.bz2 && cd bcftools-1.9 && make && make install 
RUN cd /bioTools && tar -zxvf jdk-8u211-linux-x64.tar.gz 
RUN cd /bioTools && unzip gatk-4.1.2.0.zip 
RUN chmod a+x /bioTools/fastp

#set python
RUN ln -s /usr/bin/python2.7 /usr/bin/python \
&& wget https://bootstrap.pypa.io/get-pip.py  --no-check-certificate \
&& python get-pip.py \
&& rm get-pip.py

# delete package flile
RUN rm /bioTools/bcftools-1.9.tar.bz2 \
/bioTools/gatk-4.1.2.0.zip \
/bioTools/jdk-8u211-linux-x64.tar.gz \
/bioTools/samtools-1.9.tar.bz2 \
/bioTools/htslib-1.9.tar.bz2

# set exec path
ENV JAVA_HOME=/bioTools/jdk1.8.0_211 
ENV PATH=/bioTools:/bioTools/htslib-1.9:/bioTools/samtools-1.9:/bioTools/bcftools-1.9:/bioTools/gatk-4.1.2.0:/bioTools/bwa:$JAVA_HOME/bin:$PATH





