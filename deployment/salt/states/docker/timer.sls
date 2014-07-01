ubuntu:
    docker.pulled:
        - name: "ubuntu:14.04"



# Move build-files to the node.
dockerdir:
    file.directory:
        - name: "/app/timer/"
        - makedirs: try

dockerfiles:
    file.managed:
        - name: /app/timer/Dockerfile
        - source: salt://docker/Dockerfile
        - template: jinja
        - defaults:
            baseimage: ubuntu:14.04
        #TODO: use names: here for multiple files, or make a cycle.
        - require: 
            - file: dockerdir


timer_image:
    docker.built:
        - path: /app/timer/
        - require:
            - docker: ubuntu # explicit
        - watch:   #FIXME: hangs when dockerfile is changed (sometimes, unreproducible)
            - file: dockerfiles

timer_cont:
    docker.installed:
        - image: timer_image
        - watch: 
            - docker: timer_image

timer_app:
    docker.running:
        - container: timer_cont
        - watch:
            - docker: timer_cont
