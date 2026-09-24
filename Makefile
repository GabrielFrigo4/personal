.POSIX:
.SILENT:

MAKEFLAGS += --no-print-directory -s

# ----------------------------------------------------------------
# Makefile: Personal Hub Orchestrator
# ----------------------------------------------------------------

.PHONY: help clone pull status test audit format hooks ci

### ================================
### HELP & DOCUMENTATION
### ================================
help:
	cmd() { printf "    \033[36mmake %-20s\033[0m %s\n" "$$1" "$$2"; }; \
	sec() { printf "\n  \033[1;33m%s\033[0m\n" "$$1"; }; \
	printf "\n  \033[1;37mPersonal Hub — Orquestrador de Projetos Autorais & Sistemas\033[0m\n"; \
	printf "  ============================================================\n"; \
	sec "Sincronização & Submódulos:"; \
	cmd "clone"          "Inicializa e atualiza todos os submódulos recursivamente"; \
	cmd "pull"           "Atualiza todos os submódulos com seus remotos no GitHub"; \
	sec "Diagnóstico & Status:"; \
	cmd "status"         "Exibe status Git de todos os submódulos do Personal"; \
	cmd "hooks"          "Configura e aplica permissões canônicas em .githooks"; \
	sec "Qualidade & Testes:"; \
	cmd "test"           "Valida integridade e scripts de shell"; \
	cmd "format"         "Formata documentações Markdown com Prettier"; \
	cmd "ci"             "Executa pipeline local de validação"; \
	echo ""

### ================================
### SUBMODULES ORCHESTRATION
### ================================
clone:
	echo "📦 Inicializando submódulos do Personal..."
	git submodule update --init --recursive
	echo "✅ Submódulos inicializados com sucesso!"

pull:
	echo "🔄 Sincronizando todos os submódulos autorais..."
	git submodule update --remote --merge
	echo "✅ Submódulos sincronizados!"

status:
	echo "📊 Status dos Submódulos do Personal:"
	git submodule status

### ================================
### QUALITY GATES & AUDIT
### ================================
hooks:
	chmod 0755 .githooks/* 2> "/dev/null" || true
	git config core.hooksPath .githooks
	echo "✅ Hooks configurados com sucesso em .githooks!"

test:
	echo "🧪 Validando integridade e scripts de automação..."
	find . -name "*.sh" -not -path "*/.git/*" -exec sh -n {} +
	echo "✅ Validação concluída!"

format:
	if command -v prettier > "/dev/null" 2>&1; then \
		prettier --write "*.md"; \
		echo "✅ Documentação formatada com Prettier!"; \
	fi

ci: test status
	echo "✅ Pipeline local aprovada!"
