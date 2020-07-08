FROM arm32v7/python:stretch as build

ARG PYTORCH_VERSION=1.4.1
ARG TORCHVISION_VERSION=0.5.0
ENV DEBUG=0 REL_WITH_DEB_INFO=0 USE_DISTRIBUTED=0 USE_MKLDNN=0 USE_CUDA=0 BUILD_TEST=0 USE_FBGEMM=0 USE_NNPACK=0 USE_QNNPACK=0 USE_XNNPACK=0

RUN apt update && apt install -y cmake build-essential

WORKDIR /pytorch/
RUN git clone --branch=v${PYTORCH_VERSION} --depth=1 --recursive https://github.com/pytorch/pytorch .
RUN pip install -Ur requirements.txt
RUN python setup.py bdist_wheel

RUN pip install $(ls ./dist/*.whl)

WORKDIR /vision/
RUN git clone --branch=v${TORCHVISION_VERSION} --depth=1 --recursive https://github.com/pytorch/vision .
RUN python setup.py bdist_wheel

#############################

FROM scratch as dist

COPY --from=build /pytorch/dist/* /wheels/
COPY --from=build /vision/dist/* /wheels/
