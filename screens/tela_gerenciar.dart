import 'package:flutter/material.dart';
import '../models/tarefa.dart';

class TelaGerenciar extends StatelessWidget {
  final List<Tarefa> tarefas;
  final Function(String, List<int>, TimeOfDay?, TimeOfDay?) onAdd;
  final Function(String, String, List<int>, TimeOfDay?, TimeOfDay?) onEdit;
  final Function(String) onRemove;

  const TelaGerenciar({
    super.key,
    required this.tarefas,
    required this.onAdd,
    required this.onEdit,
    required this.onRemove,
  });

  String _formatarIntervalo(BuildContext context, Tarefa tarefa) {
    if (tarefa.horarioInicio == null) return "Sem horário definido";
    final inicioFormatado = tarefa.horarioInicio!.format(context);
    if (tarefa.horarioFim == null) return "A partir das $inicioFormatado";
    final fimFormatado = tarefa.horarioFim!.format(context);
    return "$inicioFormatado - $fimFormatado";
  }

  void _abrirModalGerenciarTarefa(BuildContext context, {Tarefa? tarefaExistente}) {
    final bool isEditing = tarefaExistente != null;
    final nomeController = TextEditingController(text: isEditing ? tarefaExistente.nome : '');
    final diasSelecionados = (isEditing ? tarefaExistente.diasDaSemana : <int>[]).toSet();
    TimeOfDay? horarioInicio = isEditing ? tarefaExistente.horarioInicio : null;
    TimeOfDay? horarioFim = isEditing ? tarefaExistente.horarioFim : null;

    final corDestaque = Theme.of(context).colorScheme.secondary;

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF16213E),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Text(isEditing ? 'Editar Tarefa' : 'Adicionar Nova Tarefa'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ATUALIZADO: Adicionando estilo ao TextField para corrigir a cor
                    TextField(
                      controller: nomeController,
                      decoration: InputDecoration(
                        labelText: 'Nome da Tarefa',
                        labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white24),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: corDestaque),
                        ),
                      ),
                      autofocus: true,
                    ),
                    const SizedBox(height: 20),
                    const Text('Repetir nos dias:'),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      alignment: WrapAlignment.center,
                      children: List.generate(7, (index) {
                        final dia = index + 1;
                        final diasNomes = ['S', 'T', 'Q', 'Q', 'S', 'S', 'D'];
                        final selecionado = diasSelecionados.contains(dia);
                        return ChoiceChip(
                          label: Text(diasNomes[index]),
                          selected: selecionado,
                          selectedColor: corDestaque,
                          backgroundColor: Colors.white10,
                          labelStyle: TextStyle(color: selecionado ? Colors.white : Colors.white70),
                          onSelected: (bool selecionado) {
                            setDialogState(() {
                              if (selecionado) {
                                diasSelecionados.add(dia);
                              } else {
                                diasSelecionados.remove(dia);
                              }
                            });
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          child: Text(horarioInicio?.format(context) ?? 'Início', style: const TextStyle(color: Colors.white70)),
                          onPressed: () async {
                            final tempoEscolhido = await showTimePicker(context: context, initialTime: horarioInicio ?? TimeOfDay.now());
                            if (tempoEscolhido != null) {
                              setDialogState(() => horarioInicio = tempoEscolhido);
                            }
                          },
                        ),
                        const Text("-", style: TextStyle(color: Colors.white70)),
                        TextButton(
                          child: Text(horarioFim?.format(context) ?? 'Fim', style: const TextStyle(color: Colors.white70)),
                          onPressed: () async {
                            final tempoEscolhido = await showTimePicker(context: context, initialTime: horarioFim ?? horarioInicio ?? TimeOfDay.now());
                            if (tempoEscolhido != null) {
                              setDialogState(() => horarioFim = tempoEscolhido);
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Cancelar', style: TextStyle(color: Colors.white70)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: corDestaque, foregroundColor: Colors.white),
                  onPressed: () {
                    if (nomeController.text.isNotEmpty && diasSelecionados.isNotEmpty) {
                      if (isEditing) {
                        onEdit(tarefaExistente.id, nomeController.text, diasSelecionados.toList(), horarioInicio, horarioFim);
                      } else {
                        onAdd(nomeController.text, diasSelecionados.toList(), horarioInicio, horarioFim);
                      }
                      Navigator.of(ctx).pop();
                    }
                  },
                  child: const Text('Salvar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tarefas.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.note_add_outlined, size: 80, color: Colors.white24),
                  const SizedBox(height: 16),
                  Text('Nenhuma tarefa criada ainda.', style: TextStyle(fontSize: 18, color: Colors.white54)),
                  const SizedBox(height: 8),
                  Text('Toque no botão "+" para começar!', style: TextStyle(fontSize: 16, color: Colors.white38)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: tarefas.length,
              itemBuilder: (ctx, index) {
                final tarefa = tarefas[index];
                return Card(
                  child: ListTile(
                    title: Text(tarefa.nome),
                    subtitle: Text(
                      _formatarIntervalo(context, tarefa),
                      style: const TextStyle(color: Colors.white54),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit_outlined, color: Theme.of(context).colorScheme.secondary),
                          onPressed: () => _abrirModalGerenciarTarefa(context, tarefaExistente: tarefa),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete_outline, color: Colors.red.shade300),
                          onPressed: () => onRemove(tarefa.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirModalGerenciarTarefa(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}