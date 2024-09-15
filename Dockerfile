FROM emscripten/emsdk:3.1.61
RUN apt-get update && apt-get install -y git help2man perl python3 make autoconf g++ flex bison ccache build-essential libgoogle-perftools-dev numactl perl-doc libfl2 libfl-dev zlib1g zlib1g-dev libpython3-dev

# Build our patched Verilator
ADD tools/verilator /tools/verilator
WORKDIR /tools/verilator
RUN autoconf && ./configure && make -j16 
RUN sed -i "s/CXX =/CXX ?=/" include/verilated.mk
RUN make install

# Install Digital
WORKDIR /tools
RUN wget https://github.com/hneemann/Digital/releases/download/v0.31/Digital.zip
RUN unzip ./Digital.zip
RUN rm Digital.zip
RUN ln -s /tools/Digital/Digital.sh /usr/bin/digital

# Install autograder dependencies
RUN pip3 install cocotb~=1.9 pytest
ADD ./tools/pytest_utils /tools/pytest_utils
RUN cd /tools/pytest_utils && pip3 install .

WORKDIR /src
