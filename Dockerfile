FROM python:3.10.2-buster
# debianでパッケージインストール時の確認等を無視
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y

RUN python3 -m pip install --upgrade pip

RUN apt-get install -y build-essential poppler-utils apt-utils texlive-latex-base texlive-latex-extra libopenblas-dev \
    sudo unzip wget nano poppler-utils cmake git libssl-dev zlib1g-dev libncurses5-dev libgdbm-dev \
    libnss3-dev libssl-dev libreadline-dev libffi-dev curl libsqlite3-dev curl unzip




RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && \
    sudo ./aws/install && /usr/local/bin/aws --version

RUN pip3 install boto3
RUN git clone https://github.com/aws/amazon-braket-sdk-python.git && cd amazon-braket-sdk-python && \
    pip install .
RUN pip3 install --no-cache-dir \
    pandas \
    numpy \
    matplotlib \
    jupyterlab \
    scipy \
    scikit-learn \
    seaborn

ENV BRAKET_DIR=/home/braket
WORKDIR $BRAKET_DIR

# RUN JUPYTER ON PORT 8889
CMD [ "jupyter" , "notebook",  "--ip=0.0.0.0", "--port=8889", "--notebook-dir=./", "--no-browser","--allow-root" ]

# jupyter notebook --ip=0.0.0.0 --port=8889 --notebook-dir=./ --no-browser --allow-root