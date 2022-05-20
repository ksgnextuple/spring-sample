FROM openjdk:11
WORKDIR /
ADD /initial/build/libs/rest-service-0.0.1-SNAPSHOT.jar rest-service-0.0.1-SNAPSHOT.jar
EXPOSE 8080
RUN chmod 777 rest-service-0.0.1-SNAPSHOT.jar
#RUN apt update && apt install python3
CMD java -jar rest-service-0.0.1-SNAPSHOT.jar
