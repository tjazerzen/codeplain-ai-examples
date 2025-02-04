# API Server

A FastAPI-based API server with PostgreSQL database integration.

## Prerequisites

- Python 3.13
- PostgreSQL
- Docker and Docker Compose (optional, for containerized setup)

## Local Setup Instructions

### 1. Create Virtual Environment

```bash
# Create virtual environment
python3.13 -m venv venv

# Activate virtual environment
# On Windows:
venv\Scripts\activate
# On Unix or MacOS:
source venv/bin/activate
```

### 2. Install Dependencies

```bash
pip install -r requirements.txt
```

### 3. Environment Configuration

```bash
# Copy the template file
cp .env.template .env

# Edit .env file with your configurations
# Ensure to set MASTER_API_KEY and DATABASE_URL
```

### 4. Database Migrations

```bash
# Initialize migrations (if not already done)
alembic init alembic

# Create a new migration
alembic revision --autogenerate -m "description"

# Apply migrations
alembic upgrade head
```

### 5. Running Tests

```bash
# Run unit tests
python -m pytest tests/unit/

# Run e2e tests
python -m pytest tests/e2e/
```

### 6. Starting the Server

```bash
uvicorn main:app --reload
```

## Docker Setup

1. Ensure Docker and Docker Compose are installed
2. Run `docker-compose up --build`

## API Documentation

Once the server is running, visit:
- Swagger UI: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc

## Troubleshooting

1. Database Connection Issues:
   - Verify PostgreSQL is running
   - Check DATABASE_URL in .env
   - Ensure database exists

2. API Key Issues:
   - Verify MASTER_API_KEY is set in .env
   - Include X-API-Key header in requests
1. Create virtual environment: