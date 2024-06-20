# Use an official Maven image to build the project
FROM maven:3.8.1-openjdk-17 AS build
WORKDIR /app

# Copy the project files to the container
COPY pom.xml .
COPY src ./src

# Build the project with detailed logs
RUN mvn -e -B -DskipTests clean package -Dfile.encoding=UTF-8

# Use an official OpenJDK 17 runtime as a parent image
FROM openjdk:17-jre-slim

# Set the working directory
WORKDIR /app

# Copy the built artifact from the build image
COPY --from=build /app/target/*.jar /app/app.jar

# Expose port 8080
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
