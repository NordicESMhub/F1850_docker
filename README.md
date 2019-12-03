# CESM F1850 f19_g17 docker

CESM docker container for F1850 compset and resolution f09_g17 using [bioconda cesm docker](https://bioconda.github.io/recipes/cesm/README.html) as a base image.

- Input dataset is stored and available in zenodo.

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3526120.svg)](https://doi.org/10.5281/zenodo.3526120)


## Running F1850 with docker

### Prepare your run (inputdata, archive, etc.)

Make sure inputdata is available (it won't download it as we suppose it is already on disk). 
- The location of the inputdata is `/opt/uio/inputdata` 
- Model outputs are stored in `/opt/uio/archive` along with the `cases` folder (it can be interesting to check timing).

**Important**: the folder /opt/uio/archive needs to be writable by unix group `users` (see Dockerfile) otherwise you will get a permission denied when running.

```
sudo chgrp -R users /opt/uio/archive
sudo chmod -R g+w /opt/uio/archive
```

You can check it:

```
ls -lrt /opt/uio | grep archive
```

You should have:

```
drwxrwxr-x.  8 centos users        4096 Nov  9 15:21 archive
```

### Pull your image and run it

```
docker pull quay.io/nordicesmhub/cesm_f1850:latest
docker run -i -v /opt/uio/inputdata:/home/cesm/inputdata -v /opt/uio/archive:/home/cesm/archive  -t quay.io/nordicesmhub/cesm_f1850:latest
```

