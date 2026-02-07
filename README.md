# DevOps Web Application

A modern web application demonstrating CI/CD pipeline with Maven, Docker, and Tomcat.

## 🚀 Features

- **Maven Build System**: Automated build and dependency management
- **Docker Containerization**: Container-ready with multi-stage builds
- **CI/CD Ready**: Designed for continuous integration and deployment
- **Responsive Design**: Modern, mobile-friendly UI

## 📁 Project Structure

```
DevOpsProject1/
├── pom.xml                          # Maven configuration
├── Dockerfile                       # Docker image build
├── README.md                        # This file
└── src/
    └── main/
        └── webapp/
            ├── index.jsp            # Main application page
            └── WEB-INF/
                └── web.xml          # Web application configuration
```

## 🛠️ Technology Stack

- **Java 11**
- **Maven 3.8+**
- **Tomcat 9.0**
- **Docker**
- **JSP/Servlet**

## 📦 Build Instructions

### Local Build with Maven

```bash
# Clean and build the project
mvn clean package

# Run tests
mvn test

# Clean build
mvn clean
```

### Docker Build

```bash
# Build the Docker image
docker build -t devops-webapp:latest .

# Run the container
docker run -p 8080:8080 devops-webapp:latest

# Access the application
# Open http://localhost:8080/webapp/
```

### Using Docker Compose

Create a `docker-compose.yml` file:

```yaml
version: '3.8'
services:
  webapp:
    build: .
    ports:
      - "8080:8080"
    restart: unless-stopped
```

Then run:

```bash
docker-compose up -d
```

## 🔧 Configuration

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `CATALINA_HOME` | Tomcat installation directory | `/usr/local/tomcat` |
| `APP_HOME` | Application webapps directory | `/usr/local/tomcat/webapps` |

### Ports

| Port | Service |
|------|---------|
| 8080 | HTTP access to Tomcat |

## 🧪 Testing

```bash
# Run unit tests
mvn test

# Generate test reports
mvn surefire-report:report
```

## 📈 CI/CD Pipeline

This project is designed to work with CI/CD systems:

1. **Build**: Maven compiles and packages the application
2. **Test**: Unit tests are executed
3. **Containerize**: Docker image is built
4. **Deploy**: Container is deployed to target environment

### Example GitHub Actions Workflow

Create `.github/workflows/ci.yml`:

```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up JDK 11
        uses: actions/setup-java@v3
        with:
          java-version: '11'
          distribution: 'temurin'
      
      - name: Build with Maven
        run: mvn clean package -DskipTests
      
      - name: Build Docker image
        run: docker build -t devops-webapp:${{ github.sha }} .
```

## 🔒 Security

- Non-root user in Docker container
- Minimal base image (Alpine)
- Health checks enabled

## 📝 License

This project is open source and available under the MIT License.

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📞 Support

For issues and questions, please open a GitHub issue.
