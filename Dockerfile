<<<<<<< HEAD
# Etapa de construção
FROM maven:3.8.1-openjdk-17 AS build

# Define o diretório de trabalho
WORKDIR /app

# Copia os arquivos de configuração do Maven e o código-fonte
COPY pom.xml .
COPY src ./src

# Compila o aplicativo
RUN mvn -e -B -DskipTests clean package

# Etapa de execução
FROM openjdk:17-jdk-slim

# Define o diretório de trabalho
WORKDIR /app

# Copia o artefato construído da etapa anterior
COPY --from=build /app/target/*.jar app.jar

# Expor a porta da aplicação
EXPOSE 8080

# Comando para executar a aplicação
CMD ["java", "-jar", "app.jar"]
=======
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
>>>>>>> 07b2bbd7c8d57232350210c70b6af5fa8440f241
