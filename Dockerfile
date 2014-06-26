FROM java

MAINTAINER chris@cbeer.info

ENV ISPN_VERSION 7.0.0.Alpha4

RUN apt-get update && apt-get install -y curl unzip

RUN curl -O http://downloads.jboss.org/infinispan/${ISPN_VERSION}/infinispan-server-${ISPN_VERSION}-bin.zip
RUN unzip infinispan-server-${ISPN_VERSION}-bin.zip && mv infinispan-server-${ISPN_VERSION} /opt/infinispan-server && rm infinispan-server-${ISPN_VERSION}-bin.zip

RUN printf "\nadmin=29d8b948d7f701fa12ef858a5c432291\n" >> /opt/infinispan-server/standalone/configuration/application-users.properties
RUN printf "\nadmin=REST\n" >> /opt/infinispan-server/standalone/configuration/application-roles.properties
RUN printf "\nadmin=d041a4bcc575ab17cf6039a206f72af8\n" >> /opt/infinispan-server/standalone/configuration/mgmt-users.properties

EXPOSE 8080 9999 4447 8181 11222 11211 9990 8009

CMD /opt/infinispan-server/bin/standalone.sh -Djboss.bind.address=0.0.0.0 -Djboss.bind.address.management=0.0.0.0
