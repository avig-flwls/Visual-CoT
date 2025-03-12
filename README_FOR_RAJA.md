
## Clone repo
```
git clone ...
cd Visual-CoT
```

## Build Docker container
```
docker build -t my-image-name . # create image
docker run -dit --name my-container my-image-name # start container
docker exec -it my-container bash # drop into container in bash shell
```

## Now you should be inside of container and can run commands
## replace all conda commands with micromamba and uv
```
micromamba create -n viscot python=3.10 -y
micromamba activate viscot
uv pip install --upgrade pip  # enable PEP 660 support
uv pip install -e .

uv pip install -e ".[train]"
uv pip install flash-attn --no-build-isolation # this takes forever to build, not sure when it will finish.
```

## Create lock file.
```
uv sync
```