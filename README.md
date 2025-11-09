# Deploy
```
git clone https://github.com/JMDirksen/Minecraft-Bedrock-Docker.git minecraftbedrock
cd minecraftbedrock
docker build -t minecraftbedrock .
docker run -it --name minecraftbedrock --rm -p 19132:19132/udp -v ./server:/data/server -e SEED=abc minecraftbedrock
```

# Update/Run
```
cd ~/minecraftbedrock
git pull
docker build -t minecraftbedrock .
docker rm -f minecraftbedrock
docker run -dit --name minecraftbedrock --restart unless-stopped -p 19132:19132/udp -v ./server:/data/server minecraftbedrock
docker logs -ft minecraftbedrock
```

# Compose file
You can also use the compose file like so:
```
docker compose up -d
docker compose logs -ft
```
