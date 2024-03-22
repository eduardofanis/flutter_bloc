import 'package:aula_flutter_bloc/app/home/search_cep_bloc.dart';
import 'package:aula_flutter_bloc/app/home/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Home"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cep',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () =>
                context.read<SearchCepBloc>().add(textController.text),
            child: const Text("Buscar"),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<SearchCepBloc, SearchCepState>(builder: (context, state) {
            if (state is LoadingState) {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (state is ErrorState) {
              return Text(
                state.message,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              );
            }

            if (state is SuccessState) {
              return Text(
                "${state.result["localidade"]}/${state.result["uf"]}",
              );
            }

            return Container();
          })
        ],
      ),
    );
  }
}
