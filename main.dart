import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'models/tarefa.dart';
import 'screens/tela_rotina.dart';
import 'screens/tela_gerenciar.dart';
import 'screens/tela_progresso.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    const corPrimaria = Color(0xFF1A1A2E);
    const corSecundaria = Color(0xFF16213E);
    const corDestaque = Color(0xFF00BFA6);
    final textoBase = GoogleFonts.poppinsTextTheme();

    return MaterialApp(
      title: 'App de Rotina',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: corPrimaria,
          brightness: Brightness.dark,
          primary: corPrimaria,
          secondary: corDestaque,
          background: corPrimaria,
          surface: corSecundaria,
        ),
        scaffoldBackgroundColor: corPrimaria,
        textTheme: textoBase
            .copyWith(
              headlineSmall:
                  textoBase.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              bodyLarge: textoBase.bodyLarge?.copyWith(fontSize: 16),
            )
            .apply(
              bodyColor: Colors.white,
              displayColor: Colors.white.withOpacity(0.8),
            ),
        cardTheme: CardThemeData(
          color: corSecundaria,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: corPrimaria,
          elevation: 0,
          centerTitle: true,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: corSecundaria,
          selectedItemColor: corDestaque,
          unselectedItemColor: Colors.white54,
          showUnselectedLabels: false,
          elevation: 10,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: corDestaque,
          foregroundColor: Colors.white,
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return corDestaque;
            }
            return Colors.white54;
          }),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ),
      home: const TelaPrincipal(),
    );
  }
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  int _indiceTelaSelecionada = 0;

  final List<Tarefa> _listaDeTarefas = [
    // ATUALIZADO: Usando o novo modelo com início e fim
    Tarefa(id: 't1', nome: 'Academia', diasDaSemana: [1, 3, 5], horarioInicio: const TimeOfDay(hour: 7, minute: 0), horarioFim: const TimeOfDay(hour: 8, minute: 0)),
    Tarefa(id: 't2', nome: 'Ler 20 páginas', diasDaSemana: [1, 2, 3, 4, 5, 6, 7]),
    Tarefa(id: 't3', nome: 'Estudar Flutter', diasDaSemana: [2, 4], concluida: true, horarioInicio: const TimeOfDay(hour: 20, minute: 30)),
  ];

  // ATUALIZADO: Função de adicionar com intervalo de tempo
  void _adicionarTarefa(String nome, List<int> dias, TimeOfDay? inicio, TimeOfDay? fim) {
    final novaTarefa = Tarefa(
      id: DateTime.now().toString(),
      nome: nome,
      diasDaSemana: dias,
      horarioInicio: inicio,
      horarioFim: fim,
    );
    setState(() => _listaDeTarefas.add(novaTarefa));
  }

  // ATUALIZADO: Função de editar com intervalo de tempo
  void _editarTarefa(String id, String novoNome, List<int> novosDias, TimeOfDay? novoInicio, TimeOfDay? novoFim) {
    setState(() {
      final tarefa = _listaDeTarefas.firstWhere((t) => t.id == id);
      tarefa.nome = novoNome;
      tarefa.diasDaSemana = novosDias;
      tarefa.horarioInicio = novoInicio;
      tarefa.horarioFim = novoFim;
    });
  }

  void _removerTarefa(String id) {
    setState(() => _listaDeTarefas.removeWhere((tarefa) => tarefa.id == id));
  }

  void _alternarStatusTarefa(String id) {
    setState(() {
      final tarefa = _listaDeTarefas.firstWhere((t) => t.id == id);
      tarefa.concluida = !tarefa.concluida;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _telas = [
      TelaRotina(tarefas: _listaDeTarefas, onToggle: _alternarStatusTarefa),
      // ATUALIZADO: Passando as funções com as novas assinaturas
      TelaGerenciar(
        tarefas: _listaDeTarefas,
        onAdd: _adicionarTarefa,
        onEdit: _editarTarefa,
        onRemove: _removerTarefa,
      ),
      TelaProgresso(tarefas: _listaDeTarefas),
    ];

    final List<String> _titulos = ['Sua Rotina', 'Gerenciar Tarefas', 'Progresso'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titulos[_indiceTelaSelecionada],
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
      body: _telas[_indiceTelaSelecionada],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceTelaSelecionada,
        onTap: (index) => setState(() => _indiceTelaSelecionada = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.checklist), label: 'Rotina'),
          BottomNavigationBarItem(icon: Icon(Icons.edit_note), label: 'Gerenciar'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Progresso'),
        ],
      ),
    );
  }
}