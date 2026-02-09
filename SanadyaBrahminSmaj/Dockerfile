# BUILD STAGE
FROM maven:3.9.9-eclipse-temurin-17 AS builder

WORKDIR /app

COPY SanadyaBrahminSmaj .

RUN mvn clean package -DskipTests


# RUNTIME STAGE (Tomcat)
FROM tomcat:10.1-jdk17-temurin

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR as ROOT app
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
