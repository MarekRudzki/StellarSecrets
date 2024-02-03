import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stellar_secrets/features/space_fact/viewModel/bloc/space_fact_bloc.dart';

class NewFactButton extends StatelessWidget {
  const NewFactButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: TextButton.icon(
          onPressed: () {
            context.read<SpaceFactBloc>().add(RandomSpaceFactRequsted());
          },
          icon: const Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          label: const Text(
            'New fact',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
