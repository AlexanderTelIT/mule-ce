# Temporarilty lifted from V Romero at Mulesoft. 
# changes coming to Dockerfile

FROM alpine:latest

RUN  apk update \
  && apk upgrade \
  && apk add ca-certificates \
  && update-ca-certificates \
  && apk add --update coreutils && rm -rf /var/cache/apk/*   \ 
  && apk add --update openjdk11 tzdata curl unzip bash \
  && apk add --no-cache nss \
  && rm -rf /var/cache/apk/*

RUN mkdir /app

ENV MULE_HOME=/app/mule-standalone-4.4.0/
WORKDIR /app
#RUN useradd --user-group --shell /bin/false mule && chown mule /app 
#RUN  chmod -R 777 /opt

    
#RUN  wget https://s3.amazonaws.com/new-mule-artifacts/mule-ee-distribution-standalone-4.3.0.zip \
#	&& unzip *.zip \
#	&& ln -s mule-enterprise-standalone-4.3.0 mule && rm mule-ee-distribution-standalone-4.3.0.zip
 #ADD ./start.sh /opt
 COPY start.sh /app
RUN cd  /app && wget https://repository-master.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/4.4.0/mule-standalone-4.4.0.tar.gz && \
    tar xvzf mule-standalone-4.4.0.tar.gz && \
    rm mule-standalone-4.4.0.tar.gz	


#RUN cd /app wget https://repository-master.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/4.4.0/mule-standalone-4.4.0.tar.gz \
#	&& cd /app && tar xvzf /mule-standalone-4.4.0.tar.gz && rm /mule-standalone-4.4.0.tar.gz && ln -s /app/mule-standalone-4.4.0 /app/mule


RUN ln -s /app/mule-standalone-4.4.0 /app/mule
	# to add a license insert the following line

 #ADD ./start.sh /opt
 # to add a license insert the following three lines
 # RUN rm /opt/mule/muleLicenseKey.lic
 #ADD ./license.lic /opt/mule/conf
 #RUN /opt/mule/bin/mule -installLicense /opt/mule/conf/license.lic
 # to complete the license install uncomment the next line
# RUN mule/bin/mule -installLicense mule/conf/mule-ee-license.lic && rm -f mule/conf/mule-ee-license.lic && rm -Rf examples
#
# # Define environment variables.

#
# # Define mount points.
#RUN chgrp -R 0 /app/mule-standalone-4.4.0 && \
#    chmod -R g+rwX /app/mule-standalone-4.4.0


RUN adduser -D -g "" 185 root -u 185
RUN chmod -R ugo+rwx /app/mule-standalone-4.4.0

USER 185


VOLUME ["/app/mule-standalone-4.4.0/logs", "/app/mule-standalone-4.4.0/conf", "/app/mule-standalone-4.4.0/apps", "/app/mule-standalone-4.4.0/domains"]

#WORKDIR /opt/mule


RUN echo $PATH


ENTRYPOINT [ "/app/mule-standalone-4.4.0/bin/mule"]

EXPOSE 8881
EXPOSE 8882
EXPOSE 8084
EXPOSE 8085
EXPOSE 8091
EXPOSE 8090

