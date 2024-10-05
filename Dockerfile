FROM emscripten/emsdk:3.1.61
RUN apt-get update && apt-get install -y git help2man perl python3 make autoconf g++ flex bison ccache build-essential libgoogle-perftools-dev numactl perl-doc libfl2 libfl-dev zlib1g zlib1g-dev libpython3-dev maven

# Build our patched Verilator
ADD tools/verilator /tools/verilator
WORKDIR /tools/verilator
RUN autoconf && ./configure && make -j16 
RUN sed -i "s/CXX =/CXX ?=/" include/verilated.mk
RUN make install

# Build our patched Digital
WORKDIR /tools
RUN git clone https://github.com/CSE140L/Digital
WORKDIR /tools/Digital
RUN mvn install -DskipTests
ADD tools/Digital.sh /usr/bin/digital

# Install autograder dependencies
RUN pip3 install cocotb~=1.9 pytest
ADD ./tools/pytest_utils /tools/pytest_utils
RUN cd /tools/pytest_utils && pip3 install .

WORKDIR /src
