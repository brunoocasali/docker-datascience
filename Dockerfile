FROM jupyter/pyspark-notebook

LABEL maintainer="Bruno Casali <hi@brunoocasali.xyz>"

RUN conda update -n base conda
RUN conda install pyspark
