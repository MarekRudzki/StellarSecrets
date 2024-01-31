import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stellar_secrets/features/daily_picture/viewModel/bloc/daily_picture_bloc.dart';

class DailyPictureScreen extends StatelessWidget {
  const DailyPictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DailyPictureBloc>().add(DailyPictureRequested());
    return Scaffold(
      body: BlocBuilder<DailyPictureBloc, DailyPictureState>(
        builder: (context, state) {
          if (state is DailyPictureLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (state is DailyPictureError) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            );
          } else if (state is DailyPictureSuccess) {
            return Center(
              child: Text(state.dailyPicture.title),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
