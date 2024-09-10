# CSE 140L Buildsystem Docker

This repository contains the Dockerfile to build an image that can be used to compile Verilog to JavaScript.

## Information

- Emscripten v3.1.61
- Verilator v5.026

## Usage

``` bash
podman pull docker.io/anishg24/cse140l:latest
podman run --rm -v /path/to/project:/src anishg24/cse140l:latest make target
```
