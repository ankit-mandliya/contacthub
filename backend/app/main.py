from fastapi import FastAPI

app = FastAPI(
    title="Contact Hub API"
)


@app.get("/")
def root():
    return {
        "message": "Contact Hub API Running"
    }


@app.get("/health")
def health():
    return {
        "status": "UP"
    }