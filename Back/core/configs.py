from pydantic import BaseSettings
import firebase_admin
from firebase_admin import credentials, firestore

class Settings(BaseSettings):
    API_V1_STR: str = "/api/v1"
    