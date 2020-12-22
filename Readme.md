# Babel Daemon Experiment Repository

This repository created for testing babeld in your computer.

[Babel](https://www.irif.fr/~jch/software/babel/) is a loop-avoiding distance-vector routing protocol.  
It is easy to setup on Layer 3 network.  
You can access more on [IETF rfc6126](https://tools.ietf.org/html/rfc6126)  

Another good video.  
[![babel-video](https://i.ytimg.com/an_webp/Mflw4BuksHQ/mqdefault_6s.webp?du=3000&sqp=CLjxiP8F&rs=AOn4CLBsbpERt02uSKrbktUEHvyKhoWsLQ)](https://www.youtube.com/watch?v=Mflw4BuksHQ)  

This scripts are usable for Ubuntu and Debian.
If you don't want to leave anything on your system, you can use one time container in demo.

```bash
# Container for temporarily network demo
docker pull ahmetozer/babeld-demo:latest
docker run -it --rm --privileged ahmetozer/babeld-demo
```

In a container, Prepare your enviroment with executing setup.sh  
Default node count is 20, you can change with setting count enviroment value. It can be lower or upper but it cannot be bigger than 254.

```bash
./setup.sh
```

For inspecting name spaces. You have to jump namespace with jump command

```bash
jump node-1
#or you can execute iptraf directly
jump node-1 iptraf-ng
```
