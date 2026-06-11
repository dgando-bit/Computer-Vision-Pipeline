.PHONY: help build up down logs train jupyter clean

# ── Configuration ──────────────────────────────────────────────────────────────
COMPOSE = docker compose
SERVICE_TRAIN = dl
SERVICE_JUPYTER = jupyter

# ── Aide ───────────────────────────────────────────────────────────────────────
help:
	@echo ""
	@echo "Usage: make <cible>"
	@echo ""
	@echo "  build      Construit les images Docker"
	@echo "  up         Démarre Jupyter en arrière-plan"
	@echo "  down       Arrête et supprime les conteneurs"
	@echo "  train      Lance un run d'entraînement"
	@echo "  logs       Affiche les logs Jupyter (Ctrl+C pour quitter)"
	@echo "  clean      Supprime les conteneurs, images et volumes orphelins"
	@echo ""

# ── Build ──────────────────────────────────────────────────────────────────────
build:
	$(COMPOSE) build

# ── Jupyter ────────────────────────────────────────────────────────────────────
up:
	$(COMPOSE) up -d $(SERVICE_JUPYTER)
	@echo "Jupyter disponible sur http://localhost:8888"

down:
	$(COMPOSE) down

logs:
	$(COMPOSE) logs -f $(SERVICE_JUPYTER)

# ── Training ───────────────────────────────────────────────────────────────────
train:
	$(COMPOSE) run --rm $(SERVICE_TRAIN)

# ── Nettoyage ──────────────────────────────────────────────────────────────────
clean:
	$(COMPOSE) down --rmi local --volumes --remove-orphans