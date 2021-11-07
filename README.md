# docker-ring

## Installation
### Xephyr
You can use Xephyr as an X server window if you are to run this image in desktop environment.

In case you are running Ubuntu, install Xephyr as following:
```shell
sudo apt install -y xserver-xephyr
```

### Build and Run
Clone the repository of this image
```shell
git clone https://github.com/hijiki02/docker-ring.git
cd docker-ring
```

## Running
```
Xephyr -screen 1024x768 :1 &
docker-compose up -d
```
You can edit docker-compose.yml to select what display you use.
