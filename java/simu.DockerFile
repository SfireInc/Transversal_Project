FROM openjdk:11-jre

WORKDIR /usr/src/

COPY ./jar/simulateur.jar .

ENTRYPOINT ["java", "-jar", "simulateur.jar"]