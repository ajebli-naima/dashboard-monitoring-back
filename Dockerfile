FROM maven:3.6.1-jdk-8-slim AS build
RUN mkdir -p /workspace
WORKDIR /workspace
COPY pom.xml /workspace
COPY src /workspace/src
RUN mvn -f pom.xml clean package -DskipTests


FROM openjdk:8-jre-stretch
EXPOSE 8080
RUN echo -e "***Deploy JAR***"
COPY --from=build  target/backend*.jar target/dashboard.jar
RUN bash -c 'touch target/dashboard.jar'
CMD ["java", "-jar", "target/dashboard.jar"]
