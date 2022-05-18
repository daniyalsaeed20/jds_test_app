// ignore_for_file: unnecessary_string_interpolations

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jds_test_app/controller/payment_bloc/bloc/payment_bloc.dart';
import 'package:jds_test_app/model/error_model.dart';
import 'package:jds_test_app/model/order_model.dart';
import 'package:jds_test_app/model/package_model.dart';

class PaymentServices {
  /* -------------------------------------------------------------------------- */
  /*                                  Variables                                 */
  /* -------------------------------------------------------------------------- */

  String mainUrl = "some url here";
  String ordersUrl = "/v2/orders";

  /* -------------------------------------------------------------------------- */
  /*                                    Lists                                   */
  /* -------------------------------------------------------------------------- */

  /* -------------------------------------------------------------------------- */
  /*                                  Functions                                 */
  /* -------------------------------------------------------------------------- */

  payNow({
    required PackageModel packageModel,
    var read,
  }) async {
    try {
      read.add(
        PayNowEventResponse(
          status: PaymentStatus.payNowResponse,
        ),
      );
      http.Response response = await http.post(
        Uri.parse(mainUrl + ordersUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'packages': packageModel.toJson(),
        }),
      );
      /* --------------------------- if response is 200 --------------------------- */
      if (response.statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        /* ----------------------- if parsed data is incorrect ---------------------- */
        if (res.containsKey("code")) {
          ErrorModel errorModel =
              ErrorModel.fromJson(jsonDecode(response.body));
          return {
            'message': 'Error: ${errorModel.description}',
            'code': '${errorModel.code}',
            'heading': 'False Data',
          };
        }
        /* ------------------------ if parsed data is correct ----------------------- */
        else {
          OrderModel orderModel =
              OrderModel.fromJson(jsonDecode(response.body));
          return {
            'message': 'Your orderId is: ' + orderModel.orderId,
            'code': '',
            'heading': 'Success',
          };
        }
      }
      /* ------------------------- if response is not 200 ------------------------- */
      else {
        return {
          'message': 'Error: ',
          'code': '${response.statusCode}',
          'heading': 'Error',
        };
      }
    }
    /* --------------------------- if some other error -------------------------- */
    catch (e) {
      return {
        'message': 'Error: ',
        'code': e.toString(),
        'heading': 'Connection Error',
      };
    }
  }
}
