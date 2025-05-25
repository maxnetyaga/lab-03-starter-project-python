from fastapi import APIRouter
from pydantic import BaseModel
import numpy as np

router = APIRouter()


@router.get("")
def hello_world() -> dict:
    return {"msg": "Hello, World!"}


class MatrixRes(BaseModel):
    matrix_a: list
    matrix_b: list
    product: list


@router.get("/matrix")
def matrix() -> MatrixRes:
    m_a = np.random.rand(10, 10)
    m_b = np.random.rand(10, 10)
    product = m_a * m_b
    return MatrixRes(
        matrix_a=m_a.tolist(), matrix_b=m_b.tolist(), product=product.tolist()
    )
