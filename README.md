docker-moodle
=============

A Dockerfile that installs the latest Moodle, Apache and PHP. This uses the official MySQL images from Docker Hub.

## Setup

```
git clone https://github.com/up2university/docker-moodle.git
cd docker-moodle
```

Populate ```envs/``` (based on the contents of ```envs-templates/```) to specify local details, especially ```common.env```:

```
MYSQL_ROOT_PASSWORD=MyMy5QLPas$word
MOODLE_PASSWORD=MyM00Dl3Pas$word
VIRTUAL_HOST=localhost
```
and fill out other ```.env``` files from ```/envs-templates``` for automatic
configuration of any needed tools/integrations.

Create a directory ```./data/``` to hold persistent data.

## Usage

To spawn a new instance of Moodle:

```
docker-compose build
docker-compose up
```
and, in a separate terminal, once the Docker containers are running,

```
docker-compose exec moodle /configure.sh
docker-compose exec mysql /configure.sh
```
to configure from the ```/envs/``` directory.

You can visit the following URL in a browser to get started:

```
https://localhost/
```

Thanks to [sergiogomez](https://github.com/sergiogomez), [eugeneware](https://github.com/eugeneware) and [ricardoamaro](https://github.com/ricardoamaro) for their Dockerfiles.

## SSL certificates

By default a self-signed certificate is created. It is enough for local instances.

Setting up a public instance, edit ```envs/common.env``` to includes

```
CURL_OPTS='-k'
```

and do the following:

```
docker-compose exec moodle bash

rm /etc/apache2/sites-enabled/default-ssl.conf
rm -r /etc/letsencrypt/live
/certbot-setup.sh
exit

docker-compose restart moodle
```

To renew the certificate later just run the /certbot-setup.sh within the container.

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

For the first time put .env file on the host and add DOCKER_TAG=value, specifying which git branch or commit should be deployed on the host. 
Docker images are created for both branches and particular commits, for instance:

* DOCKER_TAG=develop
* DOCKER_TAG=commit-985d87ac2b69c119058a5d290c250e09ed79962b

On deploy upload docker-compose-deploy.yml to the host and run the following there:

```
docker-compose -f docker-compose-deploy.yml pull
docker-compose -f docker-compose-deploy.yml up -d
```
