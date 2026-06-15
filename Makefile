.PHONY: help build up down logs train shell-jupyter shell-dl clean

# ── Configuration ──────────────────────────────────────────────────────────────
COMPOSE = docker compose
SERVICE_TRAIN = dl
SERVICE_JUPYTER = jupyter

# ── Aide ───────────────────────────────────────────────────────────────────────
help:
	@echo ""
	@echo "Usage: make <cible>"
	@echo ""
	@echo "  build          Construit les images Docker"
	@echo "  up             Démarre Jupyter en arrière-plan"
	@echo "  down           Arrête et supprime les conteneurs"
	@echo "  train          Lance un run d'entraînement"
	@echo "  logs           Affiche les logs Jupyter (Ctrl+C pour quitter)"
	@echo "  shell-jupyter  Ouvre un shell dans le conteneur Jupyter (doit être up)"
	@echo "  shell-dl       Ouvre un shell dans un conteneur dl temporaire"
	@echo "  clean          Supprime les conteneurs, images et volumes orphelins"
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

# ── Shells ─────────────────────────────────────────────────────────────────────
shell-jupyter:
	$(COMPOSE) exec $(SERVICE_JUPYTER) bash

shell-dl:
	$(COMPOSE) run --rm $(SERVICE_TRAIN) bash

# ── Nettoyage ──────────────────────────────────────────────────────────────────
clean:
	$(COMPOSE) down --rmi local --volumes --remove-orphans