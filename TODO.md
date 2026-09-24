# 🗺️ Roadmap & Backlog do Personal Hub

> Planejamento estratégico, status operacional e visão de futuro para projetos autorais, sistemas e laboratórios de Gabriel Frigo.

---

## 📊 Status dos Módulos & Sistemas

| Módulo               | Domínio                              |    Maturidade    | Tecnologias Centrais             |
| :------------------- | :----------------------------------- | :--------------: | :------------------------------- |
| **RNG Engine**       | Engine & Jogo em Computação Gráfica  | 🟡 Em Construção | C/C++, SDL3, WebGPU, QRhi, ImGui |
| **Posix Socket**     | Servidor Concorrente via FDs         |    🟢 Estável    | C, POSIX.1, kqueue / epoll       |
| **BSD Lib (SBL)**    | Standard BSD Libraries em C23        | 🟡 Em Desenvolv. | C23, bmake, BSD 3-Clause         |
| **BSD Emacs**        | Arquitetura & Kernel da Nova Máquina | 📜 Prototipagem  | Rust, Tokio, Lua, SDL3, Vulkan   |
| **Orb Kernel**       | Microkernel Assíncrono para Lua      | 🟡 Em Desenvolv. | Rust, Lua 5.5, Async             |
| **Portfolio**        | Site Institucional & Servidor        |     🟢 Ativo     | Rust, Tokio, Axum, Sockets       |
| **Profile**          | Manifesto & Identidade GitHub        |    🟢 Estável    | Markdown, Shields.io, Mermaid    |
| **Resumes**          | Acervo Curricular Soberano           |     🟢 Ativo     | LaTeX, Make, GitHub Actions      |
| **Computer Systems** | Laboratório de Sistemas & Binários   |    🔒 Privado    | C, Assembly x86_64, GDB          |
| **Symbolic Sorcery** | Computação Simbólica & Homoicone     |    🔒 Privado    | Common Lisp, SBCL                |
| **ArqZoo**           | Estruturas de Dados e Algoritmos     |    🔒 Privado    | Rust, Cargo                      |

---

## 🎯 Grandes Épicos do Hub

### 1. 🎮 RNG Engine & Gráficos Modernos

- [ ] **Integração com SDL3 & WebGPU:** Estabelecer pipeline limpo de renderização sem dependência de OpenGL legado.
- [ ] **Gerenciador de Janelas & Contexto:** Validação multiplataforma no FreeBSD (Wayland), Linux e Windows.

### 2. ⚙️ Systems & Baixo Nível Soberano

- [ ] **BSD Lib (SBL):** Implementação de estruturas canônicas em C23 com atributos `[[nodiscard]]` e aritmética imune a overflow (`<stdckdint.h>`).
- [ ] **Posix Socket:** Benchmarking de I/O concorrente sob alta carga com `kqueue` no FreeBSD e `epoll` no Linux.
- [ ] **BSD Emacs:** Protótipo da FFI entre o Kernel Rust e a Userland Lua via SDL3.
