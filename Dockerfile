FROM apache/spark:3.5.7-python3

USER root

RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install --no-cache-dir \
    jupyter \
    jupyterlab \
    pandas \
    numpy \
    matplotlib \
    pyspark

RUN mkdir -p /home/jovyan && \
    mkdir -p /home/jovyan/notebooks && \
    chmod -R 777 /home/jovyan

WORKDIR /home/jovyan

EXPOSE 8888

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser"]
