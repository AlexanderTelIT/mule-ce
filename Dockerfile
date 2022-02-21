# Temporarilty lifted from V Romero at Mulesoft. 
# changes coming to Dockerfile

FROM openjdk:11


WORKDIR /opt
RUN useradd --user-group --shell /bin/false mule && chown mule /opt 
RUN  chmod -R 777 /opt
USER mule
    
RUN wget https://s3.amazonaws.com/new-mule-artifacts/mule-ee-distribution-standalone-4.3.0.zip \
	&& unzip *.zip \
	&& ln -s mule-enterprise-standalone-4.3.0 mule && rm mule-ee-distribution-standalone-4.3.0.zip
 ADD ./start.sh /opt

#RUN cd  /opt && wget https://repository-master.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/4.4.0/mule-standalone-4.4.0.tar.gz && \
#    tar xvzf mule-standalone-4.4.0.tar.gz && \
#    rm mule-standalone-4.4.0.tar.gz	


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
VOLUME ["/opt/mule/logs", "/opt/mule/conf", "/opt/mule/apps", "/opt/mule/domains"]

WORKDIR /opt/mule

ENTRYPOINT ["sh", "/opt/start.sh"]


EXPOSE 8881
EXPOSE 8882
EXPOSE 8084
EXPOSE 8085
EXPOSE 8091
EXPOSE 8090

