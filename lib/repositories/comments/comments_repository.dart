import 'dart:convert';

import 'package:flutter/services.dart';

import '../../models/products/prodetail_comment_model.dart';

class CommentsRepository {
  Future<ProdetailCommentModel> getComment() async {
    var jsonStr =
        await rootBundle.loadString('assets/datas/prodetailComments.json');
    return ProdetailCommentModel.fromJson(json.decode(jsonStr));
  }
}
