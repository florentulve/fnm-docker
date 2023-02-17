FROM public.ecr.aws/ubuntu/ubuntu:23.04_edge

RUN apt-get update &&\
    apt-get install -y curl wget vim nano unzip && \
    apt-get purge

RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes

USER ubuntu
WORKDIR /home/ubuntu

ARG NODE_VERSION=18
ARG NVM_VERSION=0.39.3

RUN mkdir -p ~/.config && \
    printf '[container]\n\
disabled = true' >> ~/.config/starship.toml

RUN curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "./.fnm" --skip-shell &&\
printf '\nexport PATH="~/.fnm:$PATH"\n\
eval "$(fnm env --use-on-cd)"\n\
eval "$(fnm completions --shell bash)"\n' >> ~/.bashrc

RUN ~/.fnm/fnm install ${NODE_VERSION}

RUN printf 'eval "$(starship init bash)"\n' >> ~/.bashrc



