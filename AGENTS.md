# 🚀 Personal — AI Agent Briefing

> Este é o **repositório hub** de **Personal** de Gabriel Frigo. Ele orquestra projetos autorais, motores gráficos, protocolos de rede, experimentos de baixo nível, bibliotecas de sistema e identidades públicas.

---

## 🧭 Identidade e Papel

O **Personal** é o quartel-general de projetos autorais e experimentação pura, organizado em 5 categorias funcionais:

| Categoria      | Submódulo                                      | Papel                                                         | Repositório Remoto               |
| :------------- | :--------------------------------------------- | :------------------------------------------------------------ | :------------------------------- |
| **`Identity`** | [`Portfolio`](Identity/Portfolio/)             | Site pessoal em SvelteKit Estático (Zero Bloat)               | `GabrielFrigo4/gabrielfrigo`     |
|                | [`Profile`](Identity/Profile/)                 | README canônico do perfil do GitHub                           | `GabrielFrigo4/GabrielFrigo4`    |
|                | [`Resumes`](Identity/Resumes/)                 | Currículos e cartas em LaTeX                                  | `GabrielFrigo4/resumes`          |
| **`Engines`**  | [`RNG Engine`](Engines/RNG%20Engine/)          | Engine de jogos e computação gráfica (SDL3 / WebGPU / OpenGL) | `GabrielFrigo4/rng-engine`       |
|                | [`Ollama Vision`](Engines/Ollama%20Vision/)    | Pipeline paleográfico local (Ollama + Gemma Vision)           | `GabrielFrigo4/ollama-vision`    |
| **`Systems`**  | [`Posix Socket`](Systems/Posix%20Socket/)      | Servidor HTTP concorrente em C/POSIX explorando FDs           | `GabrielFrigo4/unix-sock`        |
|                | [`BSD Lib`](Systems/BSD%20Lib/)                | Standard BSD Libraries em C23                                 | `GabrielFrigo4/SBL`              |
|                | [`BSD Emacs`](Systems/BSD%20Emacs/)            | Manifesto e arquitetura da nova máquina                       | `GabrielFrigo4/bsd-emacs`        |
|                | [`Orb Kernel`](Systems/Orb%20Kernel/)          | Microkernel assíncrono para Lua em Rust                       | `GabrielFrigo4/orb`              |
| **`Labs`**     | [`Computer Systems`](Labs/Computer%20Systems/) | CS:APP Attack Lab e laboratórios de arquitetura               | `GabrielFrigo4/ComputerSystems`  |
|                | [`Symbolic Sorcery`](Labs/Symbolic%20Sorcery/) | Common Lisp & computação simbólica                            | `GabrielFrigo4/symbolic-sorcery` |
|                | [`ArqZoo`](Labs/ArqZoo/)                       | Simulação algorítmica e grafos em Rust                        | `GabrielFrigo4/ArqZoo`           |
| **`OSS`**      | [`PackageKit`](OSS/PackageKit/)                | Contribuições upstream e código aberto                        | `PackageKit/PackageKit`          |

---

## 📦 Os Repositórios Federados

```text
Personal/
├── .agents/                   # Governança e runbooks locais de IA
├── .githooks/                 # Quality gates de pre-commit e commit-msg
├── .github/                   # Workflows de CI
├── Engines/                   # Computação gráfica, engines e jogos
├── Identity/                  # Portfólio, perfil e currículos
├── Labs/                      # Estudos de arquitetura, Lisp e grafos
├── OSS/                       # Código aberto upstream
├── Systems/                   # Protocolos, runtimes e baixo nível
├── AGENTS.md                  # Este briefing de engenharia
├── LICENSE                    # Licença MIT
├── Makefile                   # Orquestrador POSIX silencioso
├── PRINCIPLES.md              # 22 Princípios de Engenharia aplicados
├── README.md                  # Apresentação executiva do Personal Hub
└── TODO.md                    # Matriz de status operacional e roadmap
```

---

## ⚠️ Regras Críticas para Agentes de IA

1. **A Regra de Ouro:** Ao modificar código de um submódulo específico, leia o `AGENTS.md` e `PRINCIPLES.md` correspondente.
2. **Independência dos Projetos:** Cada projeto mantém sua própria branch, histórico e testes.
3. **Hermetismo de Produção (`rm -rf .agents`):** Nenhuma compilação ou script deve depender de arquivos em `.agents/`.
4. **Makefile como Orquestrador:** Use a raiz para inspecionar e atualizar os submódulos de forma unificada.
5. **Zero-Tweaks Invariant:** O hub deve ser clonável e navegável imediatamente via `git clone --recursive`.

---

## 🛡️ Regra da Proatividade e Correção Contínua (Boy Scout Rule)

O agente de IA atua de forma proativa na manutenção e aplicação dos padrões canônicos deste repositório.

Ao identificar linhas ou artefatos fora dos padrões estabelecidos:

1. **Notificar concisamente** o usuário sobre o ajuste realizado.
2. **Corrigir a inconformidade**, aplicando o padrão correspondente:
    - **Comentários Narrativos:** Eliminar comentários óbvios que apenas narram código executável.
    - **Banners Estruturais:** Ajustar réguas para exatamente 64 hífens no topo ou 32 caracteres com `### ` no corpo (ou 64 `=` em `.gitignore`), com títulos sempre em MAIÚSCULO.
    - **Portabilidade POSIX:** Substituir bashismos (`[[ ]]`, `&>`, arrays, `source`) por sintaxe estrita POSIX `/bin/sh`.
    - **Shebang Universal:** Garantir sempre `#!/usr/bin/env sh` ou `#!/usr/bin/env python3`.
    - **Sequências ANSI & Escapes:** Não use octais (`\033`, `\001`) para caracteres ou escapes. Use `[ -t 1 ] && echo -n $\x27\e...\x27` ou notação hexadecimal (`\x01`, `\x1b`). Octal é exclusivo para permissões POSIX (`chmod 0755`, `chmod 0644`, `umask`).
    - **Redirecionamento Seguro:** Envolver destinos em aspas duplas (ex: `> "/dev/null" 2>&1`).
    - **Makefiles:** Assegurar cabeçalho `.POSIX: .SILENT:`, `MAKEFLAGS += --no-print-directory -s`, alinhamento estético de variáveis e zero `@` redundante.
    - **Permissões Canônicas:** Aplicar 4 dígitos octais (`chmod 0755`, `chmod 0644`, `chmod 0700`, `chmod 0600`).
    - **Invariante Out-of-the-Box:** Garantir modos octais corretos no Git Index e auto-cura em tempo de execução sem requerer intervenção manual pós-clone.
    - **Emissão Semântica de UI:** Substituir `echo` avulsos com emojis pelas rotinas canônicas `_ui_*`.
    - **Antifragilidade & Resiliência:** Resolução ativa de caminhos em cascata, auto-cura de permissões (0600 em chaves/segredos) e validação defensiva de pré-requisitos.
    - **Curadoria Cognitiva:** Capturar decisões estruturais e regras tácitas em skills locais compactas (`.agents/skills/`), mantendo-as atualizadas e expurgando ruído obsoleto.
    - **Refatoração Sem Legado:** Expurgar aliases obsoletos, variáveis mortas e shims de compatibilidade em renomeações.
    - **Elevação Antifrágil & Shift Seguro:** Usar o bloco explícito `if [ "$(id -u)" -ne 0 ]` para resolução de `ELEVATE` (evitando término fatal sob `set -e` como root) e proteger todo comando `shift` com validação prévia de parâmetros (`[ "$#" -ge N ] && shift N`).
    - **Simetria de Documentação:** Mover regras ou invariantes universais documentadas erroneamente em sub-membros específicos para o documento de arquitetura do grupo correspondente, eliminando falsas assimetrias.

---

## 🚀 Comandos de Verificação Rápida (Quality Gates)

| Comando            | Finalidade Operacional                                      |
| :----------------- | :---------------------------------------------------------- |
| `make help`        | Exibe o catálogo completo de tarefas operacionais           |
| `make status`      | Inspeciona o estado Git de todos os submódulos              |
| `make pull`        | Sincroniza todos os submódulos com seus remotos             |
| `make test`        | Valida sintaxe e scripts locais nos submódulos              |
| `make audit`       | Executa rotinas de auditoria nos componentes                |
| `make format`      | Aplica formatação automática em arquivos suportados         |
| `make prettier`    | Formata arquivos Markdown e JSON com Prettier               |
| `make lint-format` | Valida conformidade de formatação sem modificar arquivos    |
| `make hooks`       | Configura permissões e ganchos Git em todos os repositórios |
| `make ci`          | Executa pipeline local completa de validação integrada      |

---

## 📖 Referências Obrigatórias

Antes de qualquer modificação neste ecossistema, consulte:

- [README.md](README.md) — Apresentação executiva do Personal Hub
- [PRINCIPLES.md](PRINCIPLES.md) — 22 Princípios de Engenharia aplicados
- [TODO.md](TODO.md) — Matriz de status operacional e roadmap
- [LICENSE](LICENSE) — Licença MIT do projeto
