# Temporarilty lifted from V Romero at Mulesoft. 
# changes coming to Dockerfile

FROM alpine:latest


RUN cd ~ && wget https://repository-master.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/4.4.0/mule-standalone-4.4.0.tar.gz \
	&& cd /opt && tar xvzf ~/mule-standalone-4.4.0.tar.gz && rm ~/mule-standalone-4.4.0.tar.gz && ln -s /opt/mule-standalone-4.4.0 /opt/mule


RUN adduser -D -g "" 185 root -u 185
USER  185

RUN chmod -R 777 /opt/mule/

# Define environment variables.
ENV MULE_HOME /opt/mule

VOLUME ["/opt/mule/logs", "/opt/mule/conf", "/opt/mule/apps", "/opt/mule/domains"]

# Define working directory.
WORKDIR /opt/mule

#CMD [ "/opt/mule/bin/mule" ]

# Default http port
EXPOSE 8081

CMD [ "/opt/mule/bin/mule" ]

