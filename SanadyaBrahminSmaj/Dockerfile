# ---------- BUILD STAGE ----------
FROM maven:3.9.9-eclipse-temurin-17 AS builder

WORKDIR /app

# 1) Copy ONLY the build definition files first.
#    This layer only changes when pom.xml / wrapper change,
#    so dependency downloads are cached across builds.
COPY pom.xml .
COPY .mvn .mvn
COPY mvnw mvnw
COPY mvnw.cmd mvnw.cmd

# 2) Download all dependencies & plugins WITHOUT compiling source.
#    This layer is cached and reused until pom.xml changes.
RUN mvn -B dependency:go-offline

# 3) Now copy the actual source code (invalidates only this layer).
COPY src src

# 4) Build using the cached dependencies.
RUN mvn -B clean package -DskipTests

# ---------- RUNTIME STAGE ----------
FROM tomcat:10.1-jdk17-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8081

CMD ["catalina.sh", "run"]
