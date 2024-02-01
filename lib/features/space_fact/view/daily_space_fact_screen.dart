import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stellar_secrets/features/space_fact/view/picture_info.dart';
import 'package:stellar_secrets/features/space_fact/viewModel/bloc/space_fact_bloc.dart';

class DailySpaceFactScreen extends StatelessWidget {
  const DailySpaceFactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SpaceFactBloc>().add(DailySpaceFactRequested());
    return Scaffold(
      body: BlocBuilder<SpaceFactBloc, SpaceFactState>(
        builder: (context, state) {
          if (state is SpaceFactLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (state is SpaceFactError) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            );
          } else if (state is SpaceFactSuccess) {
            return PictureInfo(
              copyright: state.spaceFact.copyright,
              description: state.spaceFact.description,
              hdUrl: state.spaceFact.hdUrl,
              title: state.spaceFact.title,
              url: state.spaceFact.url,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
