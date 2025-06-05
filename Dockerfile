FROM ubuntu:22.04 AS glide-build
RUN apt update
RUN apt install -y build-essential g++ clang curl cmake python3
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o rustup.sh && \
     chmod u+x ./rustup.sh && \
    ./rustup.sh --profile=default -y
RUN echo '4e957b66ade85eeaee95932aa7e3b45aea64db373c58a5eaefc8228cc71445c2  vulkansdk-linux-x86_64-1.4.313.0.tar.xz' > vulkan_sdk.sha256 && \
    curl --proto ='https' --tlsv1.2 -sSf https://sdk.lunarg.com/sdk/download/1.4.313.0/linux/vulkansdk-linux-x86_64-1.4.313.0.tar.xz -o vulkansdk-linux-x86_64-1.4.313.0.tar.xz && \
    sha256sum -c 'vulkan_sdk.sha256' && \
    mkdir vulkan_sdk && \
    tar -xvf vulkansdk-linux-x86_64-1.4.313.0.tar.xz -C vulkan_sdk/

ENV PATH="$PATH:/root/.cargo/bin"


FROM glide-build AS glide-develop
RUN apt install -y neovim silversearcher-ag
