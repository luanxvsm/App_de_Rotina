# 🤳 App de Rotina

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Status](https://img.shields.io/badge/status-em%20desenvolvimento-yellow?style=for-the-badge)

Um aplicativo mobile elegante e funcional, desenvolvido com Flutter, para ajudar usuários a organizar, gerenciar e acompanhar suas tarefas e rotinas diárias. O projeto foca em uma interface de usuário limpa, com tema escuro, e funcionalidades essenciais para a criação de hábitos.

---

## ✨ Telas do Aplicativo

Aqui estão algumas das telas que implementamos, demonstrando a identidade visual e as funcionalidades do app.

![Tela1](https://github.com/user-attachments/assets/93fa0410-826b-4fef-a3e1-13ecfcdec080)

![Tela2](https://github.com/user-attachments/assets/75171c5a-88e4-4704-863c-ff6ef99e4d1e)

![Tela3](https://github.com/user-attachments/assets/e4d2c8df-5869-445a-a094-2bb0f82c4ad6)

---

## 🚀 Funcionalidades Principais

-   **Visualização da Rotina Diária:** A tela principal exibe de forma clara e ordenada as tarefas agendadas para o dia atual.
-   **Gerenciamento Completo de Tarefas:** Crie, edite e exclua tarefas com facilidade.
-   **Agendamento Flexível:**
    -   Defina em quais dias da semana cada tarefa deve se repetir.
    -   Adicione um intervalo de tempo (horário de início e fim) para atividades específicas.
-   **Acompanhamento de Progresso:** Marque tarefas como concluídas e visualize estatísticas de desempenho em uma tela dedicada.
-   **Interface Moderna:** Tema escuro (`Dark Mode`) elegante e consistente, construído com uma paleta de cores coesa e a fonte Poppins para melhor legibilidade.
-   **Experiência Profissional:** Tela de inicialização (`Splash Screen`) personalizada com a logo do aplicativo, garantindo uma identidade visual desde o primeiro momento.

---

## 🛠️ Tecnologias e Pacotes Utilizados

-   **Framework:** [Flutter](https://flutter.dev/)
-   **Linguagem:** [Dart](https://dart.dev/)
-   **Pacotes Principais:**
    -   [`google_fonts`](https://pub.dev/packages/google_fonts): Para utilizar fontes customizadas do Google Fonts.
    -   [`intl`](https://pub.dev/packages/intl): Para formatação de datas e horários de acordo com a localidade (pt_BR).
    -   [`flutter_native_splash`](https://pub.dev/packages/flutter_native_splash): Para criar e gerenciar a tela de inicialização nativa.

---

## ⚙️ Como Executar o Projeto

Para rodar este projeto localmente, siga os passos abaixo:

### Pré-requisitos

-   Ter o [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado.
-   Ter um emulador Android/iOS configurado ou um dispositivo físico conectado.
-   Ter o [Git](https://git-scm.com/) instalado.

### Passos

1.  **Clone o repositório:**
    ```sh
    git clone [https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git](https://github.com/SEU_USUARIO/SEU_REPOSITORIO.git)
    ```
    *(Lembre-se de substituir `SEU_USUARIO` e `SEU_REPOSITORIO` pelos seus dados)*

2.  **Navegue até a pasta do projeto:**
    ```sh
    cd projeto_app_rotina
    ```

3.  **Instale as dependências:**
    ```sh
    flutter pub get
    ```

4.  **Gere a tela de inicialização (se necessário):**
    ```sh
    dart run flutter_native_splash:create
    ```

5.  **Execute o aplicativo:**
    ```sh
    flutter run
    ```

---

## 📂 Estrutura do Projeto

O código-fonte está organizado da seguinte forma para manter a clareza e escalabilidade:

lib/
├── main.dart         # Ponto de entrada principal, tema e navegação
|
├── models/           # Contém as classes de modelo (ex: tarefa.dart)
│   └── tarefa.dart
|
└── screens/          # Contém os widgets que representam cada tela do app
├── tela_rotina.dart
├── tela_gerenciar.dart
└── tela_progresso.dart

---

## 🔮 Próximas Funcionalidades (Roadmap)

-   [ ] **Persistência de Dados:** Salvar as tarefas localmente usando `shared_preferences` ou `sqflite` para que não se percam ao fechar o app.
-   [ ] **Notificações:** Enviar lembretes para o usuário sobre o horário das tarefas.
-   [ ] **Animações:** Adicionar micro-interações e animações para melhorar a experiência do usuário.
-   [ ] **Categorias:** Permitir que o usuário organize suas tarefas por categorias (ex: Trabalho, Estudo, Saúde).

---

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

---

Feito com ❤️ por **Luan Victor Santana de Macêdo, Gabriel Figueiredo de Andrade, João Evangelista Neto, Caio Gomes**
