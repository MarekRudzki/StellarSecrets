import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stellar_secrets/features/space_fact/view/fact_details.dart';
import 'package:stellar_secrets/features/space_fact/viewModel/bloc/space_fact_bloc.dart';
import 'package:stellar_secrets/utils/enums.dart';

class SpaceFactScreen extends StatelessWidget {
  final CurrentView currentView;

  const SpaceFactScreen({
    super.key,
    required this.currentView,
  });

  @override
  Widget build(BuildContext context) {
    if (currentView == CurrentView.daily) {
      context.read<SpaceFactBloc>().add(DailySpaceFactRequested());
    } else {
      context.read<SpaceFactBloc>().add(RandomSpaceFactRequsted());
    }

    return Scaffold(
      floatingActionButton: currentView == CurrentView.random
          ? SizedBox(
              height: 45,
              child: FloatingActionButton.extended(
                  onPressed: () {
                    context
                        .read<SpaceFactBloc>()
                        .add(RandomSpaceFactRequsted());
                  },
                  label: const Row(
                    children: [
                      Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'New fact',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )),
            )
          : null,
      body: BlocBuilder<SpaceFactBloc, SpaceFactState>(
        builder: (context, state) {
          if (state is SpaceFactLoading) {
            return Container(
              height: double.infinity,
              child: Image.asset(
                'assets/loading.png',
                fit: BoxFit.cover,
              ),
            );
          } else if (state is SpaceFactError) {
            return const Center(
              child: Text(
                'An error occured, please reload the page',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            );
          } else if (state is SpaceFactSuccess) {
            String date = '';
            if (currentView == CurrentView.random) {
              date = state.spaceFact.date;
            }
            return FactDetails(
              copyright: state.spaceFact.copyright,
              description: state.spaceFact.description,
              hdUrl: state.spaceFact.hdUrl,
              title: state.spaceFact.title,
              url: state.spaceFact.url,
              date: date,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
