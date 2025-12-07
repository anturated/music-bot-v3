FROM python:3.13 AS base
WORKDIR /app

# install deps
COPY reqs.txt .
RUN pip install -r reqs.txt
# HACK: removed py-cord from deps in favor of dev py-cord with voice v8 support.
# pls change when 2.7.x comes out
RUN python3 -m pip install git+https://github.com/Pycord-Development/pycord

# get ffmpeg
RUN command -v ffmpeg >/dev/null || \
    apt-get update && \
    apt-get install -y ffmpeg && \
    rm -rf /var/lib/apt/lists/*

# copy source
COPY src ./

# default run
ENTRYPOINT ["python", "-u", "main.py"]
