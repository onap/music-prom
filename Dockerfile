FROM library/ubuntu:latest

# Was this necessary? Removed for now. 
#    apt-get upgrade -y && \
RUN apt-get update && \
    apt-get install -y  software-properties-common && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer && \
    apt-get install -y python && \
    apt-get install -y python-pip && \
    apt-get install -y ssh jq curl && \
    apt-get clean

#for promoverride script
RUN pip install requests

#REMOVE THIS BEFORE SHIPPING
#RUN apt-get update && \
#    apt-get install -y vim

# Chnaged to suppor Maven Docker.  
#COPY target/prom.jar sampleApp/startPromDaemon.sh sampleApp/promoverride.py /app/
COPY maven/ sampleApp/startPromDaemon.sh sampleApp/promoverride.py /app/
WORKDIR /app

CMD ./startPromDaemon.sh -i $ID -c /opt/app/prom/ $PASSIVE -z

