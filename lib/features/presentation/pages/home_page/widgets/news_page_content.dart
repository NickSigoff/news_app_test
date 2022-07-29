import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_test/features/presentation/bloc/news_page_content_bloc/news_page_content_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../../utils/main_colors.dart';
import '../../../../../utils/news_section_names.dart';
import '../../../../data/models/results_model.dart';
import '../../article_page/article_page.dart';

class NewsPageContent extends StatefulWidget {
  final int state;

  const NewsPageContent({Key? key, required this.state}) : super(key: key);

  @override
  State<NewsPageContent> createState() => _NewsPageContentState();
}

class _NewsPageContentState extends State<NewsPageContent> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsPageContentBloc, NewsPageContentState>(
      listener: (context, state) {
        if (state is NewsPageContentSuccess) {
          context.read<NewsPageContentBloc>().add(NewsUpdateEvent(
              sectionName: SectionNames.sectionNames[widget.state],
              news: state.news));
        }
      },
      builder: (context, state) {
        return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: state is NewsPageContentLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state is NewsPageContentSuccess
                    ? ListView.separated(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 24.0, bottom: 150.0),
                        itemCount: state.news.numResults!,
                        itemBuilder: (BuildContext context, int index) =>
                            _buildArticleWidget(
                                articleInfo: state.news.results![index]),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          height: 24.0,
                        ),
                      )
                    : state is NewsPageContentLocalSuccess
                        ? ListView.separated(
                            padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                top: 24.0,
                                bottom: 150.0),
                            itemCount: state.news.numResults!,
                            itemBuilder: (BuildContext context, int index) =>
                                _buildArticleWidget(
                                    articleInfo: state.news.results![index]),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                              height: 24.0,
                            ),
                          )
                        : const Center(child: Text('Error by fetching data')));
      },
    );
  }

  Widget _buildArticleWidget({required Results articleInfo}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticlePage(
                      url: articleInfo.url!,
                    )));
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.9),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 2),
          )
        ], color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                    spacing: 8.0,
                    alignment: WrapAlignment.start,
                    children: articleInfo.subsection == null ||
                            articleInfo.subsection == ''
                        ? [_buildWrapItem(articleInfo.section!)]
                        : [
                            _buildWrapItem(articleInfo.section!),
                            _buildWrapItem(articleInfo.subsection!)
                          ]),
                Text(
                  articleInfo.createdDate!,
                  style: const TextStyle(fontSize: 12),
                )
              ],
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 150,
              child: CachedNetworkImage(
                imageUrl: articleInfo.multimedia == null
                    ? 'https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image.png'
                    : articleInfo.multimedia![0].url!,
                imageBuilder: (context, imageProvider) {
                  return _buildImageWidget(imageProvider);
                },
                placeholder: (context, url) {
                  return const Center(child: CircularProgressIndicator());
                },
                errorWidget: (context, url, error) {
                  return _buildImageWidget(
                      const AssetImage('assets/images/no_image.png'));
                },
              ),
            ),
            Text(
              articleInfo.title!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              articleInfo.abstract!,
              style: TextStyle(color: MainColors.hintColor),
            )
          ],
        ),
      ),
    );
  }

  Container _buildWrapItem(String sectionName) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey.withAlpha(80),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(sectionName),
    );
  }

  Widget _buildImageWidget(ImageProvider<Object> imageProvider) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
      ),
    );
  }
}
