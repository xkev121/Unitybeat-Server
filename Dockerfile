FROM ubuntu:22.04

RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    openjdk-21-jdk \
    wget \
    git \
    tesseract-ocr \
    tesseract-ocr-eng \
    libfreetype6 \
    xdg-utils \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/Audiveris/audiveris/releases/download/5.10.0/Audiveris-5.10.0-ubuntu22.04-x86_64.deb -O /tmp/audiveris.deb \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y /tmp/audiveris.deb \
    && rm /tmp/audiveris.deb

WORKDIR /app
COPY . .
RUN ./gradlew bootJar -x test
EXPOSE 8080
CMD ["java", "-jar", "build/libs/server-0.0.1-SNAPSHOT.jar"]