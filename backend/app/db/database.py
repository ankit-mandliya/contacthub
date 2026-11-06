from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from urllib.parse import quote_plus
from app.core.config import settings


# DATABASE_URL = (
#     f"mssql+pyodbc://{settings.DB_USER}:{settings.DB_PASSWORD}"
#     f"@{settings.DB_SERVER}/{settings.DB_NAME}"
#     "?driver=ODBC+Driver+17+for+SQL+Server"
#     "&TrustServerCertificate=yes"
# )

# engine = create_engine(
#     DATABASE_URL,
#     pool_pre_ping=True,
# )

engine = create_engine(
    f"mssql+pyodbc:///?odbc_connect={quote_plus(settings.odbc_connection_string)}",
    pool_pre_ping=True,
    pool_size=5,
    max_overflow=10,
    # Batches multi-row INSERT/UPDATE executions into a single round trip to
    # the driver instead of one round trip per row (pyodbc default). Cuts
    # down latency-bound endpoints like checkpoint creation that insert
    # several CheckpointFile rows per request.
    fast_executemany=True,
)

# SessionLocal = sessionmaker(bind=engine, autocommit=False, autoflush=False)

SessionLocal = sessionmaker(
    autocommit=False,
    autoflush=False,
    bind=engine,
)