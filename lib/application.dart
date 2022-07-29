import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_test/features/presentation/bloc/news_page_content_bloc/news_page_content_bloc.dart';

import 'features/presentation/bloc/current_section_bloc/current_section_bloc.dart';
import 'features/presentation/pages/home_page/home_page.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CurrentSectionBloc()),
        BlocProvider(create: (_) => NewsPageContentBloc()),
      ],
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
