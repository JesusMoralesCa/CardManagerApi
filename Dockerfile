# Usa una imagen de Maven para compilar el proyecto
FROM maven:3.8.5-openjdk-17 AS build

# Establece el directorio de trabajo en /app
WORKDIR /app

# Copia los archivos del proyecto al contenedor
COPY . .

# Ejecuta la compilación de Maven para empaquetar la aplicación
RUN mvn clean package -DskipTests

FROM openjdk:17-jdk-slim

# Establece el directorio de trabajo en /app
WORKDIR /app

# Copia el archivo JAR generado desde el contenedor de compilación
COPY --from=build /app/target/*.jar app.jar

# Expone el puerto de la aplicación
EXPOSE 9191

ENTRYPOINT ["java", "-jar", "app.jar"]
