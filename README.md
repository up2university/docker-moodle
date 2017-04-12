docker-moodle
=============

A Dockerfile that installs the latest Moodle, Apache, PHP, and SSH. This uses the official MySQL images from Docker Hub.

## Installation

```
git clone https://github.com/up2university/docker-moodle.git
cd docker-moodle
```

Create ```.env``` to specify local details, e.g.,

```
MYSQL_ROOT_PASSWORD=MyMy5QLPas$word
MOODLE_PASSWORD=MyM00Dl3Pas$word
SSH_PASSWORD=MyS54Pas$word
VIRTUAL_HOST=my-moodle-host.my-moodle-domain
```

and create a directory ```/data/moodle-mysql``` to hold the MySQL DB persistently.

Then run

```
docker-compose build
```

## Usage

To spawn a new instance of Moodle:

```
docker-compose up
```

You can visit the following URL in a browser to get started:

```
http://my-moodle-host.my-moodle-domain/moodle
```

Thanks to [sergiogomez](https://github.com/sergiogomez), [eugeneware](https://github.com/eugeneware) and [ricardoamaro](https://github.com/ricardoamaro) for their Dockerfiles.

## Build images

Build the app and push images to Docker Hub:

```
branch=$(git rev-parse --abbrev-ref HEAD)
docker build -t up2university/moodle-mysql:${branch} mysql
docker push up2university/moodle-mysql:${branch}
docker build -t up2university/moodle:${branch} moodle
docker push up2university/moodle:${branch}
```

## Deployment

For the first time put .env file on the host and add GIT_BRANCH=master, specifying which git branch should be deployed on the host.

On deploy upload docker-compose-deploy.yml to the host and run the following there:

```
docker-compose -f docker-compose-deploy.yml pull
docker-compose -f docker-compose-deploy.yml up -d
```

