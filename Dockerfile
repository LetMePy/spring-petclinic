FROM eclipse-temurin:17-jdk-alpine
VOLUME /tmp
COPY target/spring-petclinic-3.2.0-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]