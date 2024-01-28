
ARG BASE_IMAGE=ubuntu:latest
FROM ${BASE_IMAGE}

# Use bash shell with pipefail option for all RUN instructions
SHELL ["/bin/bash", "--login", "-eo", "pipefail", "-c"]

# Set the working directory in the container
ARG WORKSPACE=/workspace
WORKDIR $WORKSPACE

# Install Python, pip, and other system dependencies
RUN apt-get update \
    && apt-get install -y \
        python3 \
        python3-pip \
        python3-venv \
        gnupg \
        curl\
        pkg-config\
        unixodbc-dev \
        graphviz \
        libgvc6 \
        protobuf-compiler \
        libmysqlclient-dev \
    && rm -rf /var/lib/apt/lists/*

# Add the repository for protobuf
RUN echo "deb http://ppa.launchpad.net/maarten-fonville/protobuf/ubuntu trusty main" | tee /etc/apt/sources.list.d/protobuf.list \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4DEA8909DC6A13A3 \
    && apt-get update \
    && apt-get install -y protobuf-compiler


# Install pre-commit
RUN pip install pre-commit

# Create a non-root user 'streamlit'
RUN useradd -m -s /bin/bash streamlit
RUN chown -R streamlit:streamlit $WORKSPACE
USER streamlit

# The entry point is set to bash. Specific commands can be run via devcontainer.json
CMD ["/bin/bash"]
