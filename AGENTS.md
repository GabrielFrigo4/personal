# 🚀 Personal — AI Agent Briefing

> Este é o **repositório hub** de **Personal** de Gabriel Frigo. Ele orquestra projetos autorais, motores gráficos, protocolos de rede, experimentos de baixo nível, bibliotecas de sistema e identidades públicas.

---

## 🧭 1. Identidade e Papel

O **Personal** é o quartel-general de projetos autorais e experimentação pura, organizado em 5 categorias funcionais:

| Categoria      | Submódulo                                      | Papel                                                         | Repositório Remoto               |
| :------------- | :--------------------------------------------- | :------------------------------------------------------------ | :------------------------------- |
| **`Identity`** | [`Portfolio`](Identity/Portfolio/)             | Site pessoal em Rust + Tokio + Sockets                        | `GabrielFrigo4/gabrielfrigo`     |
|                | [`Profile`](Identity/Profile/)                 | README canônico do perfil do GitHub                           | `GabrielFrigo4/GabrielFrigo4`    |
|                | [`Resumes`](Identity/Resumes/)                 | Currículos e cartas em LaTeX                                  | `GabrielFrigo4/resumes`          |
| **`Engines`**  | [`RNG Engine`](Engines/RNG%20Engine/)          | Engine de jogos e computação gráfica (SDL3 / WebGPU / OpenGL) | `GabrielFrigo4/rng-engine`       |
| **`Systems`**  | [`Posix Socket`](Systems/Posix%20Socket/)      | Servidor HTTP concorrente em C/POSIX explorando FDs           | `GabrielFrigo4/unix-sock`        |
|                | [`BSD Lib`](Systems/BSD%20Lib/)                | Standard BSD Libraries em C23                                 | `GabrielFrigo4/SBL`              |
|                | [`BSD Emacs`](Systems/BSD%20Emacs/)            | Manifesto e arquitetura da nova máquina                       | `GabrielFrigo4/bsd-emacs`        |
|                | [`Orb Kernel`](Systems/Orb%20Kernel/)          | Microkernel assíncrono para Lua em Rust                       | `GabrielFrigo4/orb`              |
| **`Labs`**     | [`Computer Systems`](Labs/Computer%20Systems/) | CS:APP Attack Lab e laboratórios de arquitetura               | `GabrielFrigo4/ComputerSystems`  |
|                | [`Symbolic Sorcery`](Labs/Symbolic%20Sorcery/) | Common Lisp & computação simbólica                            | `GabrielFrigo4/symbolic-sorcery` |
|                | [`ArqZoo`](Labs/ArqZoo/)                       | Simulação algorítmica e grafos em Rust                        | `GabrielFrigo4/ArqZoo`           |
| **`OSS`**      | [`PackageKit`](OSS/PackageKit/)                | Contribuições upstream e código aberto                        | `PackageKit/PackageKit`          |

---

## ⚠️ 2. Regras Críticas para Agentes de IA

1. **A Regra de Ouro:** Ao modificar código de um submódulo específico, leia o `AGENTS.md` e `PRINCIPLES.md` correspondente.
2. **Independência dos Projetos:** Cada projeto mantém sua própria branch, histórico e testes.
3. **Hermetismo de Produção (`rm -rf .agents`):** Nenhuma compilação ou script deve depender de arquivos em `.agents/`.
4. **Makefile como Orquestrador:** Use a raiz para inspecionar e atualizar os submódulos de forma unificada.
5. **Zero-Tweaks Invariant:** O hub deve ser clonável e navegável imediatamente via `git clone --recursive`.

---

## 🌲 3. Estrutura do Repositório

```
Personal/
├── .agents/                   # Governança e runbooks locais de IA
├── .githooks/                 # Quality gates de pre-commit e commit-msg
├── .github/                   # Workflows de CI
├── Engines/                   # Computação gráfica, engines e jogos
│   └── RNG Engine
├── Identity/                  # Portfólio, perfil e currículos
│   ├── Portfolio
│   ├── Profile
│   └── Resumes
├── Labs/                      # Estudos de arquitetura, Lisp e grafos
│   ├── ArqZoo
│   ├── Computer Systems
│   └── Symbolic Sorcery
├── OSS/                       # Código aberto upstream
│   └── PackageKit
├── Systems/                   # Protocolos, runtimes e baixo nível
│   ├── BSD Emacs
│   ├── BSD Lib
│   ├── Orb Kernel
│   └── Posix Socket
├── AGENTS.md                  # Este briefing de engenharia
├── LICENSE                    # Licença MIT
├── Makefile                   # Orquestrador POSIX silencioso
├── PRINCIPLES.md              # 18 Princípios de Engenharia aplicados
└── README.md                  # Apresentação executiva do Personal Hub
```

---

## ⚡ 4. Comandos de Verificação Rápida

| Comando       | Finalidade                                        |
| :------------ | :------------------------------------------------ |
| `make help`   | Exibe o catálogo completo de tarefas operacionais |
| `make status` | Inspeciona o estado Git de todos os submódulos    |
| `make pull`   | Sincroniza todos os submódulos com seus remotos   |
| `make test`   | Valida sintaxe e scripts locais                   |
