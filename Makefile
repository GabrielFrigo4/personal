.POSIX:
.SILENT:

MAKEFLAGS += --no-print-directory -s

# ----------------------------------------------------------------
# Makefile: Personal Hub Orchestrator
# ----------------------------------------------------------------

.PHONY: help clone pull status test audit format prettier lint-md hooks ci

PRIVATE_REPOS = Identity/Resumes "Labs/Computer Systems" "Labs/Symbolic Sorcery" Labs/ArqZoo

### ================================
### HELP & DOCUMENTATION
### ================================
help:
	_e=$$'\e'; \
	cmd() { printf "    $${_e}[36mmake %-22s$${_e}[0m %s\n" "$$1" "$$2"; }; \
	sec() { printf "\n  $${_e}[1;33m%s$${_e}[0m\n" "$$1"; }; \
	printf "\n  $${_e}[1;37mPersonal Hub — Orquestrador Soberano de Projetos Autorais & Sistemas$${_e}[0m\n"; \
	printf "  =========================================================================\n"; \
	sec "Sincronização & Repositórios:"; \
	cmd "clone"          "Inicializa submódulos públicos e clona repositórios privados via SSH"; \
	cmd "pull"           "Atualiza todos os submódulos e repositórios com o GitHub"; \
	sec "Diagnóstico & Status:"; \
	cmd "status"         "Exibe status Git resumido dos ecossistemas públicos e privados"; \
	cmd "hooks"          "Configura e aplica permissões canônicas em .githooks"; \
	sec "Qualidade & Testes:"; \
	cmd "test"           "Valida integridade e sintaxe de shell scripts"; \
	cmd "format"         "Formata documentações Markdown com Prettier"; \
	cmd "prettier"       "Formata documentações Markdown com Prettier"; \
	cmd "lint-md"        "Valida formatação de Markdown sem alterar arquivos"; \
	cmd "ci"             "Executa pipeline local completa de validação"; \
	echo ""

### ================================
### REPOSITORIES ORCHESTRATION
### ================================
PRIVATE_REPOS := \
	"Identity/Resumes:GabrielFrigo4/resumes" \
	"Labs/Computer Systems:GabrielFrigo4/ComputerSystems" \
	"Labs/Symbolic Sorcery:GabrielFrigo4/symbolic-sorcery" \
	"Labs/ArqZoo:GabrielFrigo4/ArqZoo"

clone:
	echo "📦 Inicializando submódulos públicos..."
	git submodule update --init --recursive
	echo "✅ Submódulos públicos inicializados!\n"
	echo "🔐 Verificando repositórios privados..."
	for entry in $(PRIVATE_REPOS); do \
		dir=$${entry%%:*}; \
		repo=$${entry##*:}; \
		if [ -e "$$dir/.git" ]; then \
			echo "  ℹ️  $$dir já clonado."; \
		elif git clone "git@github.com:$$repo.git" "$$dir" 2>/dev/null; then \
			echo "  ✅ $$dir clonado com sucesso via SSH!"; \
		elif gh repo clone "$$repo" "$$dir" 2>/dev/null; then \
			echo "  ✅ $$dir clonado com sucesso via gh CLI!"; \
		else \
			echo "  ⚠️  $$dir: clone falhou (verifique SSH ou login no gh)."; \
		fi; \
	done
	echo ""
	echo "🎉 Personal pronto!"

pull:
	echo "🔄 Sincronizando submódulos públicos..."
	git submodule update --remote --merge
	echo "⬇️  Atualizando repositórios privados..."
	for r in Identity/Resumes "Labs/Computer Systems" "Labs/Symbolic Sorcery" Labs/ArqZoo; do \
		if [ -e "$$r/.git" ]; then \
			echo "⬇️  Pulling $$r..."; \
			git -C "$$r" pull --ff-only 2> "/dev/null" || git -C "$$r" pull || echo "⚠️  Falha ao atualizar $$r"; \
		fi; \
	done
	echo "✅ Sincronização concluída!"

status:
	echo "=== 🌐 Submódulos Públicos ==="
	git submodule status
	echo ""
	echo "=== 🔒 Repositórios Privados ==="
	for r in Identity/Resumes "Labs/Computer Systems" "Labs/Symbolic Sorcery" Labs/ArqZoo; do \
		if [ -e "$$r/.git" ]; then \
			echo "[$$(git -C "$$r" branch --show-current 2> "/dev/null" || echo "detached")] $$r:"; \
			git -C "$$r" status -s; \
		else \
			echo "[não clonado] $$r (privado)"; \
		fi; \
	done

### ================================
### QUALITY GATES & AUDIT
### ================================
hooks:
	chmod 0755 .githooks/* 2> "/dev/null" || true
	git config core.hooksPath .githooks 2> "/dev/null" || true
	echo "✅ Hooks configurados com sucesso em .githooks!"

test:
	echo "🧪 Validando integridade e scripts de automação..."
	find . -name "*.sh" -not -path "*/.git/*" -not -path "*/OSS/*" -exec sh -n {} +
	echo "✅ Validação de sintaxe aprovada!"

format:
	echo "🎨 Formatando arquivos Markdown com Prettier..."
	if command -v prettier > "/dev/null" 2>&1; then \
		find . -maxdepth 1 -name "*.md" -exec prettier --write {} +; \
		echo "✅ Markdown formatado!"; \
	fi

prettier: format

lint-md:
	echo "🔍 Validando formatação de Markdown..."
	if command -v prettier > "/dev/null" 2>&1; then \
		find . -maxdepth 1 -name "*.md" -exec prettier --check {} +; \
		echo "✅ Markdown em conformidade!"; \
	fi

ci: test lint-md status
	echo "✅ Pipeline local aprovada!"
