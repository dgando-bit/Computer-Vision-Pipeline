# =============================================================================
# Stage de base — commun à training et jupyter
# =============================================================================
FROM python:3.12-slim AS base

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONPATH="/app"

WORKDIR /app

#RUN apt-get update && apt-get install -y --no-install-recommends \
#    build-essential \
#    libpq-dev \
#    git \
#    && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    git \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*
RUN useradd -m -u 1000 appuser

# Dépendances
COPY --chown=appuser:appuser dl/requirements.txt /app/dl-requirements.txt
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r /app/dl-requirements.txt

COPY --chown=appuser:appuser dl/ /app/dl/

# =============================================================================
# Stage training — image légère pour l'entraînement automatisé
# =============================================================================
FROM base AS training

USER appuser
CMD ["python", "-u", "dl/src/main.py"]

# =============================================================================
# Stage jupyter — image complète avec JupyterLab
# =============================================================================
FROM base AS jupyter

ENV PATH="/home/appuser/.local/bin:${PATH}"

RUN pip install --no-cache-dir \
    "jupyterlab==4.3.6" \
    "ipykernel==6.29.5" \
    && python -m ipykernel install --sys-prefix --name python3 --display-name "Python 3"

USER appuser
EXPOSE 8888
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--notebook-dir=/app"]