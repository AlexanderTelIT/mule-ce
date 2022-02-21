# Temporarilty lifted from V Romero at Mulesoft. 
# changes coming to Dockerfile

FROM openjdk:11


RUN cd ~ && wget https://repository-master.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/4.4.0/mule-standalone-4.4.0.tar.gz \
	&& cd /opt && tar xvzf ~/mule-standalone-4.4.0.tar.gz && rm ~/mule-standalone-4.4.0.tar.gz && ln -s /opt/mule-standalone-4.4.0 /opt/mule


RUN addgroup   --system --gid 1001 appuser
RUN adduser  --system --uid  1001   --group appuser
RUN  chmod -R 777 /opt

USER 1001

# Define environment variables.
ENV MULE_HOME /opt/mule

# Define working directory.
WORKDIR /opt/mule

VOLUME ["/opt/mule/logs", "/opt/mule/conf", "/opt/mule/apps", "/opt/mule/domains"]

#CMD [ "/opt/mule/bin/mule" ]

CMD [ "/bin/mule" ]

# Default http port
EXPOSE 8081

#CMD [ "/opt/mule/bin/mule" ]

CMD [ "/bin/mule" ]

