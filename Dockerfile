FROM maven:3.8.8-eclipse-temurin-17 AS builder
WORKDIR /workspace

COPY .mvn/ .mvn/
COPY mvnw pom.xml ./
RUN chmod +x mvnw || true

COPY src ./src
RUN ./mvnw -B -DskipTests package || mvn -B -DskipTests package

FROM eclipse-temurin:17-jre
WORKDIR /app

ARG JAR_FILE=target/*.jar
COPY --from=builder /workspace/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","/app/app.jar"]
