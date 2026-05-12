# Stage 1 - Build the application
FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app

# Clone source code
RUN git clone https://github.com/devopsinsiders/JavaLoginPracticeApp.git

# Enter project directory
WORKDIR /app/JavaLoginPracticeApp

# Build WAR file
RUN mvn clean package

# Stage 2 - Run on Tomcat
FROM tomcat:9.0

# Copy WAR file from build stage
# Copy WAR file from build stage and rename to ROOT.war
COPY --from=build /app/JavaLoginPracticeApp/target/*.war /usr/local/tomcat/webapps/ROOT.war

RUN sed -i 's/port="8080"/port="8081"/' /usr/local/tomcat/conf/server.xml

EXPOSE 8081

CMD ["catalina.sh", "run"]