import 'package:flutter/material.dart';

class Tarefa {
  String id;
  String nome;
  List<int> diasDaSemana;
  bool concluida;
  // ATUALIZADO: Trocando um horário por um intervalo de tempo
  TimeOfDay? horarioInicio;
  TimeOfDay? horarioFim;

  Tarefa({
    required this.id,
    required this.nome,
    required this.diasDaSemana,
    this.concluida = false,
    // ATUALIZADO: Construtor agora aceita início e fim
    this.horarioInicio,
    this.horarioFim,
  });
}