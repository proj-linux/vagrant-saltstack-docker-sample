base:
  '*':
    - bin.nginx
    - mc
    - monitoring

  'minion':
    - docker
    - docker.timer
