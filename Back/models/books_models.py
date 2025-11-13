from pydantic import BaseModel
from typing import Optional

class BookModel(BaseModel):
    id: Optional[str] = None
    title: str
    preco: float
    description: str
    foto_url: str
    autor_id: Optional[str] = None