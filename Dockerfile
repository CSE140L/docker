FROM emscripten/emsdk:3.1.61
RUN apt-get update && apt-get install -y git help2man perl python3 make autoconf g++ flex bison ccache build-essential libgoogle-perftools-dev numactl perl-doc libfl2 libfl-dev zlib1g zlib1g-dev

ADD tools /tools
WORKDIR /tools/verilator
RUN autoconf && ./configure && make -j16 
RUN sed -i "s/CXX =/CXX ?=/" include/verilated.mk
RUN make install

WORKDIR /src

ENTRYPOINT ["/bin/bash"]
