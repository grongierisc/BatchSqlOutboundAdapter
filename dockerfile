FROM intersystemsdc/iris-community:2020.3.0.221.0-zpm

# copy files
COPY . /tmp/iris

USER root

# Update package and install sudo
RUN apt-get update && apt-get install -y \
	openjdk-8-jdk \
	nano \
	sudo && \
	/bin/echo -e ${ISC_PACKAGE_MGRUSER}\\tALL=\(ALL\)\\tNOPASSWD: ALL >> /etc/sudoers && \
	sudo -u ${ISC_PACKAGE_MGRUSER} sudo echo enabled passwordless sudo-ing for ${ISC_PACKAGE_MGRUSER}

RUN export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
RUN export PATH=$PATH:$JAVA_HOME/bin

USER irisowner

# load demo stuff
RUN iris start IRIS \
	&& iris session IRIS < /tmp/iris/iris.script && iris stop IRIS quietly

ENTRYPOINT ["/iris-main"] 