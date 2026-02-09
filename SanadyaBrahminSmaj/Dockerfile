# ---------- BUILD STAGE ----------
FROM maven:3.9.9-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy pom.xml
COPY SanadyaBrahminSmaj/pom.xml .

# Copy Maven wrapper (optional but safe)
COPY SanadyaBrahminSmaj/mvnw .
COPY SanadyaBrahminSmaj/.mvn .mvn

# Download dependencies
RUN mvn -B dependency:go-offline

# Copy FULL project including webapp (IMPORTANT for JSP)
COPY SanadyaBrahminSmaj/src ./src
COPY SanadyaBrahminSmaj/src/main/webapp ./src/main/webapp

# Build jar
RUN mvn clean package -DskipTests


# ---------- RUNTIME STAGE ----------
FROM eclipse-temurin:17-jre-jammy

WORKDIR /app

# Copy jar from builder
COPY --from=builder /app/target/*.jar app.jar

# Render dynamic port support
ENV PORT=8080

# Expose port
EXPOSE 8080

# Start Spring Boot
ENTRYPOINT ["java", "-Dserver.port=${PORT}", "-jar", "/app/app.jar"]
