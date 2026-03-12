FROM ubuntu:22.04

RUN apt-get update && apt-get install -y wget openjdk-17-jdk

RUN wget https://github.com/Audiveris/audiveris/releases/download/5.10.0/Audiveris-5.10.0-ubuntu22.04-x86_64.deb -O /tmp/audiveris.deb \
    && apt-get install -y /tmp/audiveris.deb \
    && rm /tmp/audiveris.deb

WORKDIR /app
COPY . .
RUN ./gradlew bootJar -x test
EXPOSE 8080
CMD ["java", "-jar", "build/libs/server-0.0.1-SNAPSHOT.jar"]