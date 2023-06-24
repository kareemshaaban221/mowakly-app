import 'package:flutter/material.dart';
import 'package:fp/component/appbars/secondary_appbar.dart';
import 'package:fp/component/complete_widgets/articles_list_widget.dart';
import 'package:fp/component/side_drawer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ViewAllArticlesScreen extends StatefulWidget {
  const ViewAllArticlesScreen({Key? key}) : super(key: key);

  @override
  State<ViewAllArticlesScreen> createState() => _ViewAllArticlesScreenState();
}

class _ViewAllArticlesScreenState extends State<ViewAllArticlesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(label: 'مقالات',),
      drawer: const SideDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ArticlesListWidget(height: 100.h),
          ],
        ),
      ),
    );
  }
}
