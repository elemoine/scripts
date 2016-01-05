for i in $(seq 3 6); do cat ~/.ssh/authorized_keys | ssh 10.109.0.$i "cat >> ~/.ssh/authorized_keys"; done
