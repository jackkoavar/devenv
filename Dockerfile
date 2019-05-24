from debian:stretch as base

run apt-get update

from base as tools

run apt-get install -y \
      git \
      python3 \
      python3-pip \
      openssh-client \
      openssh-server \
      sudo \
      procps \
      curl \
    && python3 -m pip install \
      rope \
      pylint \
      autopep8 

from tools as final

run adduser --gecos '' --disabled-password dev \
  && gpasswd -a dev sudo \
  && echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
  && mkdir -p /var/run/sshd  \
  && rm -r /etc/ssh/ssh*key \
  && dpkg-reconfigure openssh-server \
  && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
  && sed -i 's/#AuthorizedKeysFile/AuthorizedKeysFile/' /etc/ssh/sshd_config \
  && mkdir -p /home/dev/projects /home/dev/.ssh

copy --chown=root:root profile.d/ /etc/profile.d/
run chown -R dev:dev /home/dev

expose 22
volume ["/home/dev/.ssh", "/home/dev/projects"]
CMD ["/usr/sbin/sshd", "-D"]