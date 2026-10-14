# ============================================================
# rotas/agendamentos.py — CRUD de Agendamentos
# ============================================================

from fastapi import APIRouter, UploadFile, File
from pydantic import BaseModel
from typing import Optional
from database import conectar
import os

router = APIRouter()


class Agendamento(BaseModel):
    idcliente: int
    idtatuador: int
    dataagendamento: str
    horaagendamento: str
    descricaotatuagem: Optional[str] = None
    valortatuagem: Optional[float] = None
    status: Optional[str] = None


# POST /agendamentos
@router.post("")
def criar_agendamento(agendamento: Agendamento):
    conn = conectar()
    cursor = conn.cursor()

    try:
        cursor.execute(
            """
            INSERT INTO agendamento (
                idcliente, idtatuador, dataagendamento,
                horaagendamento, descricaotatuagem, valortatuagem
            )
            VALUES (%s, %s, %s, %s, %s, %s)
            """,
            (
                agendamento.idcliente,
                agendamento.idtatuador,
                agendamento.dataagendamento,
                agendamento.horaagendamento,
                agendamento.descricaotatuagem,
                agendamento.valortatuagem
            )
        )

        novo_id = cursor.lastrowid
        conn.commit()

        return {
            "mensagem": "Agendamento cadastrado com sucesso",
            "idagendamento": novo_id
        }

    except Exception:
        conn.rollback()
        raise

    finally:
        conn.close()


# GET /agendamentos
@router.get("")
def listar_agendamentos():
    conn = conectar()
    cursor = conn.cursor(dictionary=True)

    try:
        cursor.execute("""
            SELECT agendamento.*,
                   cliente.nome AS cliente,
                   tatuador.nometatuador AS tatuador
            FROM agendamento
            JOIN cliente
                ON agendamento.idcliente = cliente.idcliente
            JOIN tatuador
                ON agendamento.idtatuador = tatuador.idtatuador
        """)

        agendamentos = cursor.fetchall()

        for agendamento in agendamentos:
            hora = agendamento["horaagendamento"]

            if hasattr(hora, "total_seconds"):
                total = int(hora.total_seconds())
                horas, resto = divmod(total, 3600)
                minutos, segundos = divmod(resto, 60)
                agendamento["horaagendamento"] = (
                    f"{horas:02d}:{minutos:02d}:{segundos:02d}"
                )

        return agendamentos

    finally:
        conn.close()


# GET /agendamentos/{id}
@router.get("/{id}")
def buscar_agendamento(id: int):
    conn = conectar()
    cursor = conn.cursor(dictionary=True)

    try:
        cursor.execute(
            "SELECT * FROM agendamento WHERE idagendamento = %s",
            (id,)
        )

        agendamento = cursor.fetchone()

        if not agendamento:
            return {"erro": "Agendamento não encontrado"}

        hora = agendamento["horaagendamento"]

        if hasattr(hora, "total_seconds"):
            total = int(hora.total_seconds())
            horas, resto = divmod(total, 3600)
            minutos, segundos = divmod(resto, 60)
            agendamento["horaagendamento"] = (
                f"{horas:02d}:{minutos:02d}:{segundos:02d}"
            )

        return agendamento

    finally:
        conn.close()


# PUT /agendamentos/{id}
@router.put("/{id}")
def atualizar_agendamento(id: int, agendamento: Agendamento):
    conn = conectar()
    cursor = conn.cursor()

    try:
        cursor.execute(
            """
            UPDATE agendamento
            SET idcliente = %s,
                idtatuador = %s,
                dataagendamento = %s,
                horaagendamento = %s,
                descricaotatuagem = %s,
                valortatuagem = %s,
                status = %s
            WHERE idagendamento = %s
            """,
            (
                agendamento.idcliente,
                agendamento.idtatuador,
                agendamento.dataagendamento,
                agendamento.horaagendamento,
                agendamento.descricaotatuagem,
                agendamento.valortatuagem,
                agendamento.status,
                id
            )
        )

        conn.commit()
        return {"mensagem": "Agendamento atualizado com sucesso"}

    except Exception:
        conn.rollback()
        raise

    finally:
        conn.close()


# DELETE /agendamentos/{id}
@router.delete("/{id}")
def deletar_agendamento(id: int):
    conn = conectar()
    cursor = conn.cursor()

    try:
        cursor.execute(
            "DELETE FROM agendamento WHERE idagendamento = %s",
            (id,)
        )

        conn.commit()
        return {"mensagem": "Agendamento deletado com sucesso"}

    except Exception:
        conn.rollback()
        raise

    finally:
        conn.close()


# POST /agendamentos/{id}/desenho
@router.post("/{id}/desenho")
async def upload_desenho(
    id: int,
    arquivo: UploadFile = File(...)
):
    os.makedirs("uploads", exist_ok=True)

    nome_original = os.path.basename(
        arquivo.filename or "desenho"
    )
    nome_arquivo = f"{id}_{nome_original}"
    caminho = os.path.join("uploads", nome_arquivo)

    conteudo = await arquivo.read()

    conn = conectar()
    cursor = conn.cursor()

    try:
        cursor.execute(
            """
            UPDATE agendamento
            SET desenhoaprovado = %s
            WHERE idagendamento = %s
            """,
            (nome_arquivo, id)
        )

        conn.commit()

        with open(caminho, "wb") as f:
            f.write(conteudo)

        return {
            "mensagem": "Desenho enviado com sucesso",
            "arquivo": nome_arquivo
        }

    except Exception:
        conn.rollback()

        if os.path.exists(caminho):
            os.remove(caminho)

        raise

    finally:
        conn.close()