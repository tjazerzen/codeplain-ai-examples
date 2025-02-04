import os
from fastapi import FastAPI, Security, HTTPException, Depends
from fastapi.security import APIKeyHeader
from dotenv import load_dotenv
from sqlalchemy.orm import Session
from database import get_db
from models import Ping

# Load environment variables
load_dotenv()

# Initialize FastAPI app
app = FastAPI(title="API Server")

# Get master API key
MASTER_API_KEY = os.getenv("MASTER_API_KEY")
if not MASTER_API_KEY:
    raise ValueError("MASTER_API_KEY environment variable is not set")

# Define API key security scheme
api_key_header = APIKeyHeader(name="X-API-Key", auto_error=False)

async def verify_api_key(api_key: str = Security(api_key_header)):
    if not api_key:
        print("Authentication failed: No API key provided")
        raise HTTPException(
            status_code=401,
            detail="No API key provided"
        )
    if api_key != MASTER_API_KEY:
        print("Authentication failed: Invalid API key")
        raise HTTPException(
            status_code=401,
            detail="Invalid API key"
        )
    print("Authentication successful")
    return api_key

@app.get("/")
async def root(api_key: str = Security(verify_api_key)):
    print(f"Received request to root endpoint")  # Request logging
    return {"message": "API Server is running"}

@app.get("/hello-world")
async def hello_world(api_key: str = Security(verify_api_key), db: Session = Depends(get_db)):
    print(f"Received request to hello-world endpoint")  # Request logging
    db.add(Ping())
    db.commit()
    return {"message": "Hello, World!"}

if __name__ == "__main__":
    import uvicorn
    print("Starting API Server...")
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)