from pydantic import BaseModel
from typing import Optional

class AutorModel(BaseModel):
    id: Optional[str] = None
    nome: str
    descricao: str
    ano_nascimento: str