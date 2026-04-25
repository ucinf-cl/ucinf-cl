SHELL := /bin/bash

VENV ?= .venv
PYTHON ?= python3
PIP := $(VENV)/bin/pip
MKDOCS := $(VENV)/bin/mkdocs

.PHONY: help venv install build serve clean rebuild check

help:
	@echo "Targets disponibles:"
	@echo "  make venv     - Crea el entorno virtual en .venv"
	@echo "  make install  - Instala dependencias de MkDocs"
	@echo "  make build    - Compila el sitio en ./site (modo estricto)"
	@echo "  make serve    - Levanta servidor local en http://127.0.0.1:8000"
	@echo "  make clean    - Elimina artefactos de build (./site)"
	@echo "  make rebuild  - clean + build"
	@echo "  make check    - Alias de build para CI/local"

$(VENV)/bin/python:
	$(PYTHON) -m venv $(VENV)

venv: $(VENV)/bin/python

install: $(VENV)/bin/python requirements.txt
	$(PIP) install -r requirements.txt

build: install
	$(MKDOCS) build --strict

serve: install
	$(MKDOCS) serve -a 127.0.0.1:8000 --livereload

clean:
	rm -rf site

rebuild: clean build

check: build
