<p align="center">
	<img width="120" height="120" src="https://www.juancitocubo.tk/images/logo.png">
</p>

# 📡JuancitocuboTrack📡
This track makes it easy to keep an eye on your favorite Minecraft servers.

### Features
- 🚀 Real time Minecraft server player count tracking with customizable update speed.
- 📝 Historical player count logging with 24 hour peak and player count record tracking.
- 📈 Historical graph with customizable time frame.
- 📦 Out of the box included dashboard with various customizable sorting and viewing options.
- 📱(Decent) mobile support.
- 🕹 Supports both Minecraft Java Edition and Minecraft Bedrock Edition.

## Installation
1. Node 18.4.0 is required (you can check your version using `node -v`) you can download it from here: https://nodejs.org/
2. Make sure everything is correct in ```config.json```.
3. Add/remove servers by editing the ```servers.json``` file
4. Run ```npm install```
5. Run ```npm run build``` (this bundles `assets/` into `dist/`)
6. Run ```node main.js``` to boot the system (may need sudo!)

(There's also ```install.sh``` and ```start.sh```, but they may not work for your OS.)

Database logging is disabled by default. You can enable it in ```config.json``` by setting ```logToDatabase``` to true.
This requires sqlite3 drivers to be installed.

## Docker
track can be built and run with Docker from this repository in several ways:

### Build and deploy directly with Docker
```
# build image with name track and tag latest
docker build . --tag track:latest

# start container, delete on exit
# publish container port 8080 on host port 80
docker run --rm --publish 80:8080 track:latest
```

The published port can be changed by modifying the parameter argument, e.g.:  
* Publish to host port 8080: `--publish 8080:8080`  
* Publish to localhost (thus prohibiting external access): `--publish 127.0.0.1:8080:8080`

### Build and deploy with docker-compose
```
# build and start service
docker-compose up --build

# stop service and remove artifacts
docker-compose down
```

## Nginx reverse proxy
The following configuration enables Nginx to act as reverse proxy for a track instance that is available at port 8080 on localhost:
```
server {
    server_name track.example.com;
    listen 80;
    location / {
        proxy_pass http://localhost:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
    }
}
```