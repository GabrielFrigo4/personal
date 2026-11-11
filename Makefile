.POSIX:
.SILENT:

MAKEFLAGS += --no-print-directory -s

# ----------------------------------------------------------------
# Makefile: Personal Hub Orchestrator
# ----------------------------------------------------------------

.PHONY: help clone pull upgit status test audit format prettier lint-format hooks ci main clean

REPOS = Identity/Resumes "Labs/Computer Systems" "Labs/Symbolic Sorcery" Labs/ArqZoo "Engines/Ollama Vision"

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
	cmd "main"           "Alterna todos os submódulos e repositórios clonados para a branch main"; \
	cmd "pull"           "Atualiza todos os submódulos e repositórios com o GitHub"; \
	cmd "upgit"          "Atualiza todos os repositórios Git encontrados recursivamente"; \
	sec "Diagnóstico & Status:"; \
	cmd "status"         "Exibe status Git resumido dos ecossistemas públicos e privados"; \
	cmd "hooks"          "Configura e aplica permissões canônicas em .githooks"; \
	sec "Qualidade & Testes:"; \
	cmd "test"           "Valida integridade e sintaxe de shell scripts"; \
	cmd "format"         "Formata recursivamente arquivos (MD, JSON, YAML, HTML, CSS) exceto OSS"; \
	cmd "prettier"       "Formata recursivamente arquivos (MD, JSON, YAML, HTML, CSS) exceto OSS"; \
	cmd "lint-format"    "Valida formatação recursiva sem alterar arquivos"; \
	cmd "ci"             "Executa pipeline local completa de validação"; \
	sec "Manutenção & Limpeza:"; \
	cmd "clean"          "Remove artefatos temporários, caches e ambientes virtuais (.venv)"; \
	echo ""

### ================================
### REPOSITORIES ORCHESTRATION
### ================================
PRIVATE_REPOS := \
	"Identity/Resumes:GabrielFrigo4/resumes" \
	"Labs/Computer Systems:GabrielFrigo4/ComputerSystems" \
	"Labs/Symbolic Sorcery:GabrielFrigo4/symbolic-sorcery" \
	"Labs/ArqZoo:GabrielFrigo4/ArqZoo" \
	"Engines/Ollama Vision:GabrielFrigo4/ollama-vision"

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
		elif git clone "git@github.com:$$repo.git" "$$dir" 2> "/dev/null"; then \
			echo "  ✅ $$dir clonado com sucesso via SSH!"; \
		elif gh repo clone "$$repo" "$$dir" 2> "/dev/null"; then \
			echo "  ✅ $$dir clonado com sucesso via gh CLI!"; \
		else \
			echo "  ⚠️  $$dir: clone falhou (verifique SSH ou login no gh)."; \
		fi; \
	done
	echo ""
	$(MAKE) main
	echo "🎉 Personal pronto!"

main:
	echo "🌿 Alternando ecossistema para a branch main..."
	git submodule foreach --quiet --recursive 'case "$$sm_path" in */OSS/*|OSS/*) exit 0 ;; esac; git checkout main 2> "/dev/null" || git switch main 2> "/dev/null" || true'
	for r in $(REPOS); do \
		case "$$r" in */OSS/*|OSS/*) continue ;; esac; \
		if [ -e "$$r/.git" ]; then \
			echo "  🌿 $$r -> main"; \
			git -C "$$r" checkout main 2> "/dev/null" || git -C "$$r" switch main 2> "/dev/null" || echo "  ⚠️  $$r: falha ao alternar para main."; \
		else \
			echo "  ⏭️  $$r: não clonado, pulando."; \
		fi; \
	done
	echo "✅ Repositórios ativos configurados na branch main!\n"

pull: main
	echo "🔄 Sincronizando submódulos públicos..."
	git submodule foreach --quiet --recursive 'case "$$sm_path" in */OSS/*|OSS/*) exit 0 ;; esac; echo "⬇️  Pulling $$sm_path..."; git pull --ff-only 2> "/dev/null" || git pull 2> "/dev/null" || echo "⚠️  Falha ao atualizar $$sm_path"'
	echo "⬇️  Atualizando repositórios privados..."
	for r in $(REPOS); do \
		case "$$r" in */OSS/*|OSS/*) continue ;; esac; \
		if [ -e "$$r/.git" ]; then \
			echo "⬇️  Pulling $$r..."; \
			git -C "$$r" pull --ff-only 2> "/dev/null" || git -C "$$r" pull || echo "⚠️  Falha ao atualizar $$r"; \
		fi; \
	done
	echo "✅ Sincronização concluída!"

upgit:
	echo "🔄 Atualizando repositórios Git..."
	find . -not -path "*/OSS/*" \( -type d -name ".git" -print -prune \) -o -not -path "*/OSS/*" \( -type f -name ".git" -print \) 2> "/dev/null" | awk '{ n=split($$0, a, "/"); print n, $$0 }' | sort -n -k1,1 | cut -d' ' -f2- | while read -r g; do \
		d="$$(dirname "$$g")"; \
		case "$$d" in */OSS/*|OSS/*) continue ;; esac; \
		echo "# ----------------------------------------------------------------"; \
		echo "# $$d"; \
		echo "# ----------------------------------------------------------------"; \
		git -C "$$d" pull --ff-only 2> "/dev/null" || git -C "$$d" pull || echo "⚠️  Falha ao atualizar $$d"; \
		echo ""; \
	done
	echo "✅ Repositórios Git atualizados!"

status:
	echo "=== 🌐 Submódulos Públicos ==="
	git submodule status
	echo ""
	echo "=== 🔒 Repositórios Privados ==="
	for r in $(REPOS); do \
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
	echo "🎨 Formatando arquivos (MD, JSON, YAML, HTML, CSS) com Prettier recursivamente (exceto OSS)..."
	if command -v prettier > "/dev/null" 2>&1; then \
		find . -type f \( -name "*.md" -o -name "*.json" -o -name "*.jsonc" -o -name "*.yml" -o -name "*.yaml" -o -name "*.html" -o -name "*.css" \) \
			-not -path "*/OSS/*" -not -path "*/.git/*" -not -path "*/.venv/*" -not -path "*/node_modules/*" \
			-not -path "*/var/*" -not -path "*/tmp/*" -not -path "*/build/*" -not -path "*/dist/*" \
			-not -path "*/target/*" -not -path "*/.cache/*" -not -path "*/Identity/Portfolio/*" \
			-exec prettier --write {} +; \
		if [ -f "Identity/Portfolio/Makefile" ]; then \
			(cd Identity/Portfolio && $(MAKE) format 2> "/dev/null" || true); \
		fi; \
		echo "✅ Todos os arquivos do Personal foram formatados recursivamente (exceto OSS)!"; \
	elif command -v npx > "/dev/null" 2>&1; then \
		find . -type f \( -name "*.md" -o -name "*.json" -o -name "*.jsonc" -o -name "*.yml" -o -name "*.yaml" -o -name "*.html" -o -name "*.css" \) \
			-not -path "*/OSS/*" -not -path "*/.git/*" -not -path "*/.venv/*" -not -path "*/node_modules/*" \
			-not -path "*/var/*" -not -path "*/tmp/*" -not -path "*/build/*" -not -path "*/dist/*" \
			-not -path "*/target/*" -not -path "*/.cache/*" -not -path "*/Identity/Portfolio/*" \
			-exec npx --yes prettier --write {} +; \
		if [ -f "Identity/Portfolio/Makefile" ]; then \
			(cd Identity/Portfolio && $(MAKE) format 2> "/dev/null" || true); \
		fi; \
		echo "✅ Todos os arquivos do Personal foram formatados recursivamente (exceto OSS)!"; \
	else \
		echo "⚠️ Prettier não encontrado no PATH."; \
	fi

prettier: format

lint-format:
	echo "🔍 Validando formatação (MD, JSON, YAML, HTML, CSS) com Prettier..."
	if command -v prettier > "/dev/null" 2>&1; then \
		find . -type f \( -name "*.md" -o -name "*.json" -o -name "*.jsonc" -o -name "*.yml" -o -name "*.yaml" -o -name "*.html" -o -name "*.css" \) \
			-not -path "*/OSS/*" -not -path "*/.git/*" -not -path "*/.venv/*" -not -path "*/node_modules/*" \
			-not -path "*/var/*" -not -path "*/tmp/*" -not -path "*/build/*" -not -path "*/dist/*" \
			-not -path "*/target/*" -not -path "*/.cache/*" -not -path "*/Identity/Portfolio/*" \
			-exec prettier --check {} +; \
		echo "✅ Formatação 100% em conformidade!"; \
	elif command -v npx > "/dev/null" 2>&1; then \
		find . -type f \( -name "*.md" -o -name "*.json" -o -name "*.jsonc" -o -name "*.yml" -o -name "*.yaml" -o -name "*.html" -o -name "*.css" \) \
			-not -path "*/OSS/*" -not -path "*/.git/*" -not -path "*/.venv/*" -not -path "*/node_modules/*" \
			-not -path "*/var/*" -not -path "*/tmp/*" -not -path "*/build/*" -not -path "*/dist/*" \
			-not -path "*/target/*" -not -path "*/.cache/*" -not -path "*/Identity/Portfolio/*" \
			-exec npx --yes prettier --check {} +; \
		echo "✅ Formatação 100% em conformidade!"; \
	else \
		echo "ℹ️ Prettier não instalado; pulando validação."; \
	fi

ci: test lint-format status
	echo "✅ Pipeline local aprovada!"

### ================================
### CLEANUP
### ================================
clean:
	echo "🧹 Limpando artefatos, caches e ambientes virtuais em todos os módulos do Personal..."
	git submodule foreach --quiet --recursive 'case "$$sm_path" in */OSS/*|OSS/*) exit 0 ;; esac; [ -f Makefile ] && (cd . && $(MAKE) clean 2> "/dev/null" || true)' 2> "/dev/null" || true
	for r in $(REPOS); do \
		case "$$r" in */OSS/*|OSS/*) continue ;; esac; \
		if [ -e "$$r/Makefile" ]; then \
			(cd "$$r" && $(MAKE) clean) 2> "/dev/null" || true; \
		fi; \
	done
	rm -rf .venv
	find . -type d -name "__pycache__" -not -path "*/OSS/*" -exec rm -rf {} + 2> "/dev/null" || true
	find . -type d -name ".pytest_cache" -not -path "*/OSS/*" -exec rm -rf {} + 2> "/dev/null" || true
	find . -type d -name ".ruff_cache" -not -path "*/OSS/*" -exec rm -rf {} + 2> "/dev/null" || true
	find . -type d -name ".mypy_cache" -not -path "*/OSS/*" -exec rm -rf {} + 2> "/dev/null" || true
	echo "✅ Limpeza do Personal concluída!"
