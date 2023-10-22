import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:public_toilets/repositories/toilet_repository.dart';

import '../../models/toilet.dart';

class ToiletDetailsPage extends ConsumerStatefulWidget {
  const ToiletDetailsPage({super.key});

  @override
  ConsumerState<ToiletDetailsPage> createState() => _ToiletDetailsPageState();
}

class _ToiletDetailsPageState extends ConsumerState<ToiletDetailsPage> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final toiletId = ModalRoute.of(context)!.settings.arguments as int;

    var toilets = ref.watch(toiletProvider);
    Toilet? toilet;
    if (toilets != null) {
      toilet = toilets.firstWhere((item) => item.id == toiletId);
    }

    buildLoadingOverlay() => Container(
        color: Colors.black.withOpacity(0.2),
        child: Center(child: CircularProgressIndicator()));

    handleClickAddReview() {
      var toiletRepo = ref.read(toiletProvider.notifier);
      toiletRepo.addReview(
          toiletId: toiletId, review: 'ทดสอบ รีวิว', rating: 1);
    }

    buildContent() => SingleChildScrollView(
          child: Column(children: [
            Row(children: []),
            Text(toilet!.name, style: textTheme.displaySmall),
            for (var review in toilet.reviews) Card(child: Text(review.review)),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: handleClickAddReview,
                  child: Text('ADD REVIEW', style: textTheme.bodyLarge),
                ))
          ]),
        );

    return Scaffold(
        appBar: AppBar(title: Text('TOILET DETAILS')),
        body: Stack(children: [
          if (toilet != null) buildContent(),
          if (_isLoading) buildLoadingOverlay()
        ]));
  }
}
