# Use the Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set environment variables for configuration
ENV PYTHON_VERSION=3.10

# Update the package lists and install necessary packages
RUN apt-get update && \
    apt-get install -y python${PYTHON_VERSION} python3-pip && \
    apt-get clean

# Set the default command to run when the container starts
CMD ["python3"]

# Install necessary packages from URL
RUN pip install -U jaxlib -f 'https://storage.googleapis.com/jax-releases/nocuda/jaxlib-0.3.24-cp310-cp310-manylinux2014_x86_64.whl'
RUN pip install -U "jax[cpu]" -f 'https://storage.googleapis.com/jax-releases/jax/jax-0.3.24.tar.gz'

# Set the default working directory
WORKDIR /codoc-main

# Copy your application code to the container
COPY . /

# Install necessary packages from requirements.txt
RUN pip install -r requirements.txt

# Run Jupyter Notebook when the container launches
EXPOSE 8888
CMD ["jupyter", "notebook", "--ip='0.0.0.0'","--port=8888", "--allow-root"]

# docker build -t py/codoc:3.10 -f Dockerfile .
# docker run -p 8888:8888 -it py/codoc:3.10

# docker save -o py_codoc_3_10.tar py/codoc:3.10
# docker load -i py_codoc_3_10.tar
