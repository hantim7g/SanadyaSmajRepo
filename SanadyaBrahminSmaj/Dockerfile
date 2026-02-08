# ---------- BUILD STAGE ----------
FROM maven:3.9.9-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy only required files first (for caching)
COPY pom.xml .
COPY mvnw .
COPY .mvn .mvn

# Download dependencies (faster rebuilds)
RUN mvn -B dependency:go-offline

# Copy source
COPY src ./src

# Build jar
RUN mvn clean package -DskipTests


# ---------- RUNTIME STAGE ----------
FROM eclipse-temurin:17-jre-jammy

WORKDIR /app

# Copy jar from builder
COPY --from=builder /app/target/*.jar app.jar

# Render / Cloud provides PORT dynamically
ENV PORT=8080

# expose port
EXPOSE 8080

# Run Spring Boot properly with dynamic port
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
