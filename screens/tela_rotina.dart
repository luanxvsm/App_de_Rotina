import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/tarefa.dart';

class TelaRotina extends StatelessWidget {
  final List<Tarefa> tarefas;
  final Function(String) onToggle;

  const TelaRotina({super.key, required this.tarefas, required this.onToggle});

  String get _dataDeHojeFormatada {
    final agora = DateTime.now();
    return DateFormat('EEEE, d \'de\' MMMM', 'pt_BR').format(agora);
  }

  // Função para formatar o texto do subtítulo da tarefa na lista
  String _formatarIntervalo(BuildContext context, Tarefa tarefa) {
    if (tarefa.horarioInicio == null) return "Horário não definido";
    final inicioFormatado = tarefa.horarioInicio!.format(context);
    if (tarefa.horarioFim == null) return "A partir das $inicioFormatado";
    final fimFormatado = tarefa.horarioFim!.format(context);
    return "$inicioFormatado - $fimFormatado";
  }

  @override
  Widget build(BuildContext context) {
    final hoje = DateTime.now().weekday;
    final tarefasDeHoje = tarefas.where((t) => t.diasDaSemana.contains(hoje)).toList();

    // ATUALIZADO: Ordena a lista pelo horário de início
    tarefasDeHoje.sort((a, b) {
      if (a.horarioInicio == null && b.horarioInicio == null) return 0;
      if (a.horarioInicio == null) return 1;
      if (b.horarioInicio == null) return -1;
      final aTotalMinutos = a.horarioInicio!.hour * 60 + a.horarioInicio!.minute;
      final bTotalMinutos = b.horarioInicio!.hour * 60 + b.horarioInicio!.minute;
      return aTotalMinutos.compareTo(bTotalMinutos);
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Text(
            _dataDeHojeFormatada,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ),
        Expanded(
          child: tarefasDeHoje.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.celebration_outlined, size: 80, color: Colors.white24),
                      const SizedBox(height: 16),
                      Text(
                        'Nenhuma tarefa para hoje.\nBom descanso!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.white54),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: tarefasDeHoje.length,
                  itemBuilder: (ctx, index) {
                    final tarefa = tarefasDeHoje[index];
                    return Card(
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        leading: Checkbox(
                          value: tarefa.concluida,
                          onChanged: (_) => onToggle(tarefa.id),
                        ),
                        title: Text(
                          tarefa.nome,
                          style: TextStyle(
                            fontSize: 17,
                            decoration: tarefa.concluida ? TextDecoration.lineThrough : TextDecoration.none,
                            color: tarefa.concluida ? Colors.white38 : Colors.white.withOpacity(0.9),
                          ),
                        ),
                        // ATUALIZADO: Mostra o intervalo de tempo no subtítulo
                        subtitle: Text(
                          _formatarIntervalo(context, tarefa),
                          style: TextStyle(
                            color: tarefa.concluida ? Colors.white24 : Colors.white54,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}