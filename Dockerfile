FROM eclipse-temurin:17-jdk-alpine

RUN apk add --no-cache wget unzip

RUN wget https://github.com/Audiveris/audiveris/releases/latest/download/Audiveris.zip -O /tmp/audiveris.zip \
    && unzip /tmp/audiveris.zip -d /opt/audiveris \
    && rm /tmp/audiveris.zip

WORKDIR /app
COPY . .
RUN ./gradlew bootJar -x test
EXPOSE 8080
CMD ["java", "-jar", "build/libs/server-0.0.1-SNAPSHOT.jar"]