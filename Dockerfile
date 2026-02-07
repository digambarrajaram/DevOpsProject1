# Multi-stage build for better performance and security
FROM maven:3.8-openjdk-11-slim AS builder

WORKDIR /app

# Copy pom.xml first for better caching
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Production stage
FROM tomcat:9.0-jre11-alpine

# Set environment variables
ENV CATALINA_HOME=/usr/local/tomcat
ENV APP_HOME=/usr/local/tomcat/webapps

# Create non-root user for security
RUN addgroup -g 1000 tomcat && \
    adduser -u 1000 -G tomcat -s /bin/sh -D tomcat

# Copy pre-built webapps
RUN cp -r /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps/

# Copy the built WAR file
COPY --from=builder /app/target/webapp.war $APP_HOME/

# Change ownership to non-root user
RUN chown -R tomcat:tomcat $APP_HOME/

# Switch to non-root user
USER tomcat

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:8080/webapp/ || exit 1

# Start Tomcat
CMD ["catalina.sh", "run"]
