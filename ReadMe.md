# Pi-hole-Docker
Pi-hole Docker image

# To Build
docker build -t [Image Name]:{Version You Want} {Path of the Docker File} --no-cache

# To Run
In the folder located where the "docker-compose.yml" is located create a folder named "pihole"

In the folder located where the "docker-compose.yml" is located run: docker-compose up -d

# Notes
Need to download the installer for Pi-hole from https://github.com/pi-hole/pi-hole and put it in the build/corefiles named as "basic-install-{Version Number}.sh"

I don't own any of the install packages