// lib/screens/tela_progresso.dart (VERSÃO ATUALIZADA)

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/tarefa.dart';

class TelaProgresso extends StatelessWidget {
  // Recebemos a lista inteira para calcular mais estatísticas no futuro
  final List<Tarefa> tarefas;

  const TelaProgresso({
    super.key,
    required this.tarefas,
  });

  @override
  Widget build(BuildContext context) {
    final totalTarefas = tarefas.length;
    final totalConcluidas = tarefas.where((t) => t.concluida).length;
    final progresso = totalTarefas == 0 ? 0.0 : totalConcluidas / totalTarefas;
    final corDestaque = Theme.of(context).colorScheme.secondary;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Seu Desempenho',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          
          // Indicador de Progresso Circular
          SizedBox(
            width: 180,
            height: 180,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: progresso,
                  strokeWidth: 12,
                  backgroundColor: Colors.white10,
                  valueColor: AlwaysStoppedAnimation<Color>(corDestaque),
                ),
                Center(
                  child: Text(
                    '${(progresso * 100).toStringAsFixed(0)}%',
                    style: GoogleFonts.poppins(
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: corDestaque,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // Cards de Estatísticas
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context,
                  icon: Icons.check_circle,
                  label: 'Concluídas',
                  value: '$totalConcluidas',
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  context,
                  icon: Icons.format_list_bulleted,
                  label: 'Total de Tarefas',
                  value: '$totalTarefas',
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para criar os cards de estatísticas
  Widget _buildStatCard(BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}