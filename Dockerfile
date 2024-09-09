FROM alpine:3.20 as BUILD
RUN apk add --no-cache build-base git cmake make zlib gcc python3

ADD tools/llvm /tools/llvm
WORKDIR /tools/llvm
# Todo, make this MinSizeRel
RUN cmake -S llvm -B build -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS='lld;clang' -DLLVM_TARGETS_TO_BUILD="host;WebAssembly" -DLLVM_INCLUDE_EXAMPLES=OFF -DLLVM_INCLUDE_TESTS=OFF
RUN cmake --build build -j4



# ADD emsdk /root/emsdk
# WORKDIR /root/emsdk
# RUN ./emsdk install 3.1.61
# RUN ./emsdk activate 3.1.61
# RUN sed -i "s/NODE_JS.*/NODE_JS = '\/usr\/bin\/node'/" .emscripten
# RUN echo 'source "/root/emsdk/emsdk_env.sh"' >> $HOME/.bash_profile
#
# WORKDIR /root
# ADD hello_world.c /root/hello_world.c

ENTRYPOINT ["/bin/bash"]
