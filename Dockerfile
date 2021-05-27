FROM maven:3.5-jdk-8-alpine AS Build
WORKDIR /workspace/source
COPY . .
RUN mvn clean package -DskipTests


FROM openjdk:8-jre-alpine
RUN echo -e "***Deploy JAR***"
WORKDIR /workspace/source
RUN ls -l
COPY --from=Build target/backend-0.0.1-SNAPSHOT.jar /dashboard.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/dashboard.jar"]

