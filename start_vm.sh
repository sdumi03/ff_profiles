# Add Docker's official GPG key:
apt install ca-certificates curl gnupg -y

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update

apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y


for i in $(seq 0 19); do
    docker run --cap-add=NET_ADMIN -v D:\Twitch:/tmp --name user_$i -it ubuntu bash
    # exit
    # docker start user_$i

    docker exec user_$i apt update

    docker exec user_$i apt install openvpn git -y

    docker exec user_$i apt install software-properties-common -y

    docker exec user_$i add-apt-repository ppa:mozillateam/ppa -y

    docker exec user_$i echo '
    Package: *
    Pin: release o=LP-PPA-mozillateam
    Pin-Priority: 1001
    ' | tee /etc/apt/preferences.d/mozilla-firefox

    docker exec user_$i apt install firefox -y

    docker exec user_$i mkdir -p /dev/net
    docker exec user_$i mknod /dev/net/tun c 10 200
    docker exec user_$i chmod 600 /dev/net/tun

    docker exec user_$i openvpn --config /tmp/OpenVPNsFiles/$i.node*.ovpn --auth-user-pass /tmp/OpenVPNsCredentials/$i.txt --daemon

done