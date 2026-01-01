# Projeto Mobile: Portal EBD - AD Dirceu

Este documento descreve as especificações de interface (UI) e navegação para o desenvolvimento de um aplicativo em Flutter.

## 🛠 Tech Stack
- **Framework:** Flutter
- **Linguagem:** Dart
- **Gerenciamento de Estado:** (Sugestão: Use `setState` simples para o MVP ou Provider)

## 🎨 Design System
- **Paleta de Cores:**
  - **Primária:** Tons de Azul (Blue / LightBlue).
  - **Fundo (Background):** Branco (White).
  - **Estilo:** Minimalista, limpo e profissional.

---

## 📱 Estrutura de Navegação (Shell)
O aplicativo deve utilizar uma estrutura de `Scaffold` persistente contendo:

### 1. AppBar (Superior)
- **Título:** Texto "ADDIRCEU EBD" alinhado à esquerda.
- **Actions (Direita):** Espaço reservado (vazio por enquanto).
- **Cor:** Azul (Primary).

### 2. Bottom Navigation Bar (Inferior)
Menu de navegação inferior com 4 itens:
1.  **Início** (Ícone: `Icons.home`) - *Tela de Lições*
2.  **Turmas** (Ícone: `Icons.group`) - *Tela de Listagem de Turmas*
3.  **Cadastros** (Ícone: `Icons.person_add`) - *Tela de Alunos*
4.  **Painel** (Ícone: `Icons.dashboard`) - *Placeholder*

---

## 📄 Detalhamento das Telas

### 1. Tela de Login (Auth)
*Deve ser a tela inicial se o usuário não estiver logado.*
- **Layout:** Centralizado.
- **Campos:**
  - `TextField` para **E-mail**.
  - `TextField` para **Senha** (obscureText).
- **Ação:** Botão "Entrar" (ElevatedButton) estilizado na cor primária.

### 2. Tela Início (Listagem de Lições)
*Conteúdo da tab "Início".*
- **Objetivo:** Listar o histórico de lições ministradas.
- **Componente:** `ListView.builder`.
- **Card da Lição (Item da Lista):**
  - Deve conter um card visualmente agradável com:
    - **Título:** Número da Lição (Ex: "Lição 12").
    - **Subtítulo:** Dia da semana e Data (Ex: "Domingo - 05/01/2026").
    - **Métricas (Linha inferior):**
      - Quantidade de Presentes (Ex: "35 Presentes").
      - Quantidade de Ausentes (Ex: "5 Ausentes").
      - Badge ou Texto de destaque com a **% de Presença** (Ex: "87%").

### 3. Tela de Turmas
*Conteúdo da tab "Turmas".*
- **Objetivo:** Listar as classes da EBD.
- **Componente:** `ListView.builder`.
- **Card da Turma:**
  - **Título:** Nome da Turma (Ex: "Jovens", "Senhoras", "Adolescentes").
  - **Subtítulo:** Quantidade total de alunos matriculados (Ex: "42 Alunos").

### 4. Tela de Cadastros (Alunos)
*Conteúdo da tab "Cadastros".*
- **Objetivo:** Listagem global de todos os alunos.
- **Componente:** `ListView.separated` ou `ListView.builder`.
- **Item da Lista:**
  - **Leading:** Avatar circular (pode ser uma inicial ou ícone genérico).
  - **Título:** Nome do Aluno.
  - **Subtítulo:** Nome da Turma a que pertence.

### 5. Tela Painel
*Conteúdo da tab "Painel".*
- Por enquanto, exibir apenas um `Center` com o texto "Em construção".

---

## 💡 Instruções para a IA
1. Gere o código com dados "mockados" (fictícios) para preencher as listas, para que eu possa visualizar o layout imediatamente.
2. Separe as telas em arquivos diferentes dentro da pasta `lib/screens/` para manter a organização.
3. Use o widget `MaterialApp` configurando o tema base com a cor azul solicitada.