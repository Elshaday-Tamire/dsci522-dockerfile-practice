FROM quay.io/jupyter/minimal-notebook:afe30f0c9ad8

# Copy the Conda lock file
COPY conda-linux-64.lock /tmp/conda-linux-64.lock

# Create the 'dsci522-dockerfile-practice' environment
RUN mamba create --quiet --name dsci522-dockerfile-practice --file /tmp/conda-linux-64.lock \
    && mamba clean --all -y -f \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"

# Add the environment to Jupyter as a kernel
RUN /opt/conda/envs/dsci522-dockerfile-practice/bin/python -m ipykernel install --user --name dsci522-dockerfile-practice --display-name "Python (dsci522-dockerfile-practice)"

# Ensure permissions for the environment
RUN fix-permissions "/opt/conda/envs/dsci522-dockerfile-practice"

# Activate the 'dsci522-dockerfile-practice' environment by default in Jupyter
ENV CONDA_DEFAULT_ENV=dsci522-dockerfile-practice
ENV PATH="/opt/conda/envs/dsci522-dockerfile-practice/bin:$PATH"
