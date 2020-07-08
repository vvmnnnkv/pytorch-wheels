# Compile PyTorch for ARM architecture

Docker has wonderful [buildx plugin](https://docs.docker.com/buildx/working-with-buildx/) 
that can build images for multiple platforms using QEMU emulator.

Provided `Dockerfile` can be used to build PyTorch 1.4.1 and Torchvision 0.5.0 for Raspberri Pi on a x64 machine.
It builds for ARMv7 (32-bit) but in theory can be extended to other architectures supported by buildx.

While it is possible to build packages on Raspberri Pi itself, it might take whole night or so. 
In contrast building on a decent x64 machine in emulator finishes within 2 hours.

Usage example:

```
docker buildx build --platform=linux/arm/7 -t ptwheels .

# Copy wheel files out of image
docker create -name ptwheels ptwheels echo
docker cp ptwheels:/wheels .

```

These wheels have been tested on Raspberri Pi 3 Model B v1.2 with Raspberry Pi OS (32-bit),
together with [PySyft](https://github.com/openmined/pysyft) library.

