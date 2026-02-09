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

# Create upload directories (IMPORTANT)
RUN mkdir -p /opt/render/project/src/uploads/images/events \
    && mkdir -p /opt/render/project/src/uploads/images/guidance \
    && mkdir -p /opt/render/project/src/uploads/images/id-proof \
    && mkdir -p /opt/render/project/src/uploads/images/logo \
    && mkdir -p /opt/render/project/src/uploads/images/profile_images \
    && mkdir -p /opt/render/project/src/uploads/images/receiptImage \
    && mkdir -p /opt/render/project/src/uploads/images/rooms

# Set permissions
RUN chmod -R 777 /opt/render/project/src/uploads

EXPOSE 8080

CMD ["catalina.sh", "run"]
