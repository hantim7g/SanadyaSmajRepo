# ---------- BUILD STAGE ----------
FROM maven:3.9.9-eclipse-temurin-17 AS builder

WORKDIR /app

COPY SanadyaBrahminSmaj .

RUN mvn clean package -DskipTests


# ---------- RUNTIME STAGE ----------
FROM tomcat:10.1-jdk17-temurin

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR
COPY --from=builder /app/target/SanadyaBrahminSmaj.war /usr/local/tomcat/webapps/ROOT.war
# Create upload directories
RUN mkdir -p /var/data/uploads/images/{events,guidance,id-proof,logo,profile_images,receiptImage,rooms}

# Set permissions (safe)
RUN chmod -R 777 /var/data/uploads || true
EXPOSE 8080

CMD ["catalina.sh", "run"]
