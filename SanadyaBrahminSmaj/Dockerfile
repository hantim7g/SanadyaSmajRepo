# BUILD STAGE
FROM maven:3.9.9-eclipse-temurin-17 AS builder

WORKDIR /app

COPY SanadyaBrahminSmaj .

RUN mvn clean package -DskipTests


# RUNTIME STAGE
FROM tomcat:10.1-jdk17-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=builder /app/target/SanadyaBrahminSmaj.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
