# ---------- BUILD STAGE ----------
FROM maven:3.9.9-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy pom first (dependency caching)
COPY SanadyaBrahminSmaj/pom.xml .

# Copy Maven wrapper files (if present)
COPY SanadyaBrahminSmaj/mvnw .
COPY SanadyaBrahminSmaj/.mvn .mvn

# Download dependencies
RUN mvn -B dependency:go-offline

# Copy full source code
COPY SanadyaBrahminSmaj/src ./src

# Build Spring Boot jar
RUN mvn clean package -DskipTests


# ---------- RUNTIME STAGE ----------
FROM eclipse-temurin:17-jre-jammy

WORKDIR /app

# Copy jar from builder stage
COPY --from=builder /app/target/*.jar app.jar

# Render provides PORT automatically
ENV PORT=8080

# Expose port
EXPOSE 8080

# Run application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
