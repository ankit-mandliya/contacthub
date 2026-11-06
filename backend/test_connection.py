from app.db.database import engine

try:
    with engine.connect() as conn:
        print("Connected Successfully!")
except Exception as ex:
    print(ex)