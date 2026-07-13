import 'package:flutter/material.dart';
import 'package:myfolio_flutter/utils/work_tab_assets.dart';

/// Preloads WorkTab project backgrounds into the image cache.
Future<void> precacheWorkTabImages(BuildContext context) async {
  await Future.wait(
    workTabProjectImages.map(
      (path) => precacheImage(AssetImage(path), context),
    ),
  );
}
