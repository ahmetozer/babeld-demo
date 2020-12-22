FROM ahmetozer/cna
RUN apt update &&\
DEBIAN_FRONTEND=noninteractive; apt upgrade -y ; apt install --no-install-recommends -y \
babeld screen iproute2 && \
find /var/lib/apt/lists/ -maxdepth 1 -type f -print0 | xargs -0 rm 
WORKDIR /root
COPY . .
CMD chmod +x .bashrc setup.sh babeld.sh
CMD bash
