from sqlalchemy import Column, DateTime
from sqlalchemy.sql import func
from database import Base

class Ping(Base):
    __tablename__ = "ping"
    created_at = Column(DateTime(timezone=True), primary_key=True, server_default=func.now())