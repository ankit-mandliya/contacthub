from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    APP_NAME: str
    API_PREFIX: str

    DB_SERVER: str
    DB_NAME: str
    DB_USER: str
    DB_PASSWORD: str

    JWT_SECRET_KEY: str
    JWT_ALGORITHM: str

    CORS_ORIGINS: str

    class Config:
        env_file = ".env"

    @property
    def odbc_connection_string(self) -> str:
        return (
            f"DRIVER={{ODBC Driver 17 for SQL Server}};"
            f"SERVER={self.DB_SERVER};"
            f"DATABASE={self.DB_NAME};"
            f"UID={self.DB_USER};"
            f"PWD={self.DB_PASSWORD};"
            f"TrustServerCertificate=yes;"
        )


settings = Settings()