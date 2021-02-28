FROM openjdk:11-jre

WORKDIR /usr/src/

COPY ./jar/emergency.jar .

ENTRYPOINT ["java", "-jar", "emergency.jar"]