FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Installer SSH et autres outils nécessaires
RUN apt-get update && \
    apt-get install -y openssh-server sudo && \
    mkdir /var/run/sshd

# Ajouter l'utilisateur 'alexis' et définir un mot de passe
RUN useradd -m -s /bin/bash alexis && \
    echo 'alexis:alexis' | chpasswd && \
    adduser alexis sudo

# Modifier la configuration SSH
RUN sed -i 's/#Port 22/Port 2025/' /etc/ssh/sshd_config && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Exposer le port 2025
EXPOSE 2025

# Démarrer SSH et garder le conteneur actif
CMD service ssh start && tail -f /dev/null
