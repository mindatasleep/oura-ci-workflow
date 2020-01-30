#!/bin/sh

ssh -vvv -o StrictHostKeyChecking=no root@$DIGITAL_OCEAN_IP_ADDRESS << 'ENDSSH'
    cd ..
    export $(cat .env | xargs)
    docker login -u $CI_REGISTRY_USER -p $CI_JOB_TOKEN $CI_REGISTRY
    docker pull $IMAGE:web
    docker-compose -f docker-compose.ci.yml up -d
    docker container exec default_web_1 rails db:create db:migrate && bundle install && rake webpacker:compile
ENDSSH