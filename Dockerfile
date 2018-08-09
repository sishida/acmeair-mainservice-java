FROM websphere-liberty:microProfile

# Install opentracing usr feature

COPY liberty-opentracing-zipkintracer-1.1-sample.zip /opt/ibm/wlp/usr/liberty-opentracing-zipkintracer-1.1-sample.zip

RUN cd /opt/ibm/wlp/usr && unzip liberty-opentracing-zipkintracer-1.1-sample.zip && rm liberty-opentracing-zipkintracer-1.1-sample.zip

COPY server.xml /config/server.xml

# Don't fail on rc 22 feature already installed
RUN installUtility install --acceptLicense defaultServer || if [ $? -ne 22 ]; then exit $?; fi

COPY jvm.options /config/jvm.options

COPY target/acmeair-mainservice-java-2.0.0-SNAPSHOT.war /config/apps/
