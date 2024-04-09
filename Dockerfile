FROM eclipse/rdf4j-workbench:4.3.8

# BASED on https://vos.openlinksw.com/owiki/wiki/VOS/VirtSesame2HttpRepository
# BASED on https://hub.docker.com/r/eclipse/rdf4j-workbench

ADD http://download3.openlinksw.com/uda/virtuoso/rdfproviders/rdf4j/4/virt_rdf4j_4.jar jars/
ADD http://download3.openlinksw.com/uda/virtuoso/jdbc/virtjdbc4_3.jar jars/
ADD http://download3.openlinksw.com/uda/virtuoso/rdfproviders/rdf4j/4/rdf4j_provider.tgz jars/

USER root

RUN apt-get update && apt-get install -y unzip && cd /usr/local/tomcat/webapps && unzip -d rdf4j-workbench rdf4j-workbench.war  && unzip -d rdf4j-server rdf4j-server.war && rm *.war
RUN cp jars/virt_rdf4j_4.jar jars/virtjdbc4_3.jar /usr/local/tomcat/webapps/rdf4j-server/WEB-INF/lib/ 
RUN cp jars/virt_rdf4j_4.jar jars/virtjdbc4_3.jar /usr/local/tomcat/webapps/rdf4j-workbench/WEB-INF/lib/
RUN chmod o+r /usr/local/tomcat/webapps/rdf4j-server/WEB-INF/lib/virt_rdf4j_4.jar
RUN chmod o+r /usr/local/tomcat/webapps/rdf4j-server/WEB-INF/lib/virtjdbc4_3.jar
RUN cd jars && tar xzf rdf4j_provider.tgz && mv rdf4j_provider_v4/RDF4J_UI/*.xsl /usr/local/tomcat/webapps/rdf4j-workbench/transformations/
RUN rm -rf jars && 	chown -R tomcat /usr/local/tomcat

USER tomcat
