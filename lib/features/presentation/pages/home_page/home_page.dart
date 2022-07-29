import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_test/features/presentation/bloc/current_section_bloc/current_section_bloc.dart';
import 'package:news_app_test/features/presentation/bloc/news_page_content_bloc/news_page_content_bloc.dart';
import 'package:news_app_test/features/presentation/pages/home_page/widgets/news_page_content.dart';
import 'package:news_app_test/utils/main_colors.dart';

import '../../../../utils/news_section_names.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context
        .read<NewsPageContentBloc>()
        .add(OnCreatePageEvent(sectionName: 'home'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentSectionBloc, int>(
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(context, state),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: _buildPageBody(context, state),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(BuildContext context, int state) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: const Icon(
        Icons.menu,
        color: MainColors.mainBlue,
      ),
      title: const Text(
        'News',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.all(8.0),
          width: 200,
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: MainColors.mainBlue))),
          ),
        ),
        IconButton(
          color: MainColors.mainBlue,
          icon: const Icon(Icons.search_rounded),
          onPressed: () {
            context.read<NewsPageContentBloc>().add(OnSearchArticleEvent(
                searchedString: searchController.text,
                sectionName: SectionNames.sectionNames[state]));
          },
        ),
      ],
    );
  }

  Widget _buildPageBody(BuildContext context, int state) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            titleSpacing: 4.0,
            pinned: true,
            snap: false,
            stretch: true,
            automaticallyImplyLeading: false,
            collapsedHeight: 60,
            backgroundColor: Colors.white,
            title: _buildSectionListViewWidget(state: state, context: context),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              NewsPageContent(state: state),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionListViewWidget(
      {required int state, required BuildContext context}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 8),
          width: MediaQuery.of(context).size.width,
          height: 55,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 20,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                context
                    .read<CurrentSectionBloc>()
                    .add(OnPressTabEvent(index: index));

                context.read<NewsPageContentBloc>().add(OnCreatePageEvent(
                    sectionName: SectionNames.sectionNames[index]));
              },
              child: Container(
                width: 100.0,
                height: 50.0,
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: state == index
                      ? MainColors.mainBlue.withAlpha(50)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  SectionNames.sectionNames[index].toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
