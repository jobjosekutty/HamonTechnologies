import 'package:flutter/material.dart';

class CommonAppbar extends StatelessWidget {
  const CommonAppbar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      pinned: true,
      expandedHeight: 100,
      surfaceTintColor: Colors.white,
      flexibleSpace: FlexibleSpaceBarSettings(
        toolbarOpacity: 1,
        minExtent: 50,
        maxExtent: 120,
        currentExtent: 120,
        child: FlexibleSpaceBar(
          titlePadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          centerTitle: true,
          title: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
