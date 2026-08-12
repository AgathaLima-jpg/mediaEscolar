import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MediaEscolarPage(),
    );
  }
}

class MediaEscolarPage extends StatefulWidget {
  const MediaEscolarPage({super.key});

  @override
  State<MediaEscolarPage> createState() => _MediaEscolarPageState();
}

class _MediaEscolarPageState extends State<MediaEscolarPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController nota1Controller = TextEditingController();
  final TextEditingController nota2Controller = TextEditingController();
  final TextEditingController nota3Controller = TextEditingController();

  String nomeAluno = '';
  double? media;
  String situacao = '';
  IconData? iconeSituacao;

  void mostrarMensagemErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
      ),
    );
  }

  void limparCampos() {
    nomeController.clear();
    nota1Controller.clear();
    nota2Controller.clear();
    nota3Controller.clear();

    setState(() {
      nomeAluno = '';
      media = null;
      situacao = '';
      iconeSituacao = null;
    });
  }

  void calcularMedia() {
    String nome = nomeController.text.trim();

    double? nota1 =
        double.tryParse(nota1Controller.text.replaceAll(",", "."));
    double? nota2 =
        double.tryParse(nota2Controller.text.replaceAll(",", "."));
    double? nota3 =
        double.tryParse(nota3Controller.text.replaceAll(",", "."));

    if (nome.isEmpty || nota1 == null || nota2 == null || nota3 == null) {
      mostrarMensagemErro(
        'Por favor, preencha todos os campos corretamente.',
      );
      return;
    }

    if (nota1 < 0 ||
        nota1 > 10 ||
        nota2 < 0 ||
        nota2 > 10 ||
        nota3 < 0 ||
        nota3 > 10) {
      mostrarMensagemErro(
        'Por favor, insira notas válidas (de 0 a 10).',
      );
      return;
    }

    double mediaCalculada = (nota1 + nota2 + nota3) / 3;

    String situacaoCalculada;
    IconData iconeCalculado;

    if (mediaCalculada >= 7) {
      situacaoCalculada = 'APROVADO';
      iconeCalculado = Icons.check_circle;
    } else if (mediaCalculada >= 5) {
      situacaoCalculada = 'RECUPERAÇÃO';
      iconeCalculado = Icons.warning;
    } else {
      situacaoCalculada = 'REPROVADO';
      iconeCalculado = Icons.cancel;
    }

    setState(() {
      nomeAluno = nome;
      media = mediaCalculada;
      situacao = situacaoCalculada;
      iconeSituacao = iconeCalculado;
    });
  }

  Color obterCorSituacao() {
    if (situacao == 'APROVADO') {
      return Colors.green;
    } else if (situacao == 'RECUPERAÇÃO') {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Média Escolar'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.school,
              size: 80,
              color: Colors.blue,
            ),

            const Text(
              'Calculadora de Média Escolar',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 5),

            const Text(
              'Digite o nome e as três notas do aluno para calcular a média.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 25),

            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do Aluno',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: nota1Controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Nota 1',
                hintText: 'Digite uma nota de 0 a 10',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.grade_outlined),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: nota2Controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Nota 2',
                hintText: 'Digite uma nota de 0 a 10',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.grade_outlined),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: nota3Controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Nota 3',
                hintText: 'Digite uma nota de 0 a 10',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.grade_outlined),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: calcularMedia,
              icon: const Icon(Icons.calculate),
              label: const Text('Calcular Média'),
            ),

            const SizedBox(height: 10),

            OutlinedButton.icon(
              onPressed: limparCampos,
              icon: const Icon(Icons.delete),
              label: const Text('Limpar'),
            ),

            const SizedBox(height: 25),

            if (situacao.isNotEmpty && media != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      const Text(
                        'Resultado',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        'Nome do Aluno: $nomeAluno',
                        style: const TextStyle(fontSize: 16),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Média: ${media!.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 16),
                      ),

                      const SizedBox(height: 15),

                      Icon(
                        iconeSituacao,
                        size: 50,
                        color: obterCorSituacao(),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        situacao,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: obterCorSituacao(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}