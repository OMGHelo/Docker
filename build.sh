
#!/usr/bin/env bash

exit_script()
{
echo "Build was killed!"
sendTG "Docker image build was killed!"
}

trap exit_script SIGINT SIGTERM

function sendTG() {
    curl -s "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendmessage" --data "text=${*}&chat_id=-1001372533112&parse_mode=Markdown"
}

sendTG "\`Docker image is being updated!\`"

docker build . -t gengkapak/mirrorbot:latest
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker push gengkapak/mirrorbot:latest

sendTG "\`I have pushed new images to docker\` %0A [Images are Here](https://hub.docker.com/r/gengkapak/mirrorbot)"