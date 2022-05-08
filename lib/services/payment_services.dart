import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jds_test_app/global/generic_functions.dart';
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

  payNow(PackageModel packageModel) async {
    try {
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
          GenericFunctions().toast(text: "Error: " + errorModel.code);
        }
        /* ------------------------ if parsed data is correct ----------------------- */
        else {
          OrderModel orderModel =
              OrderModel.fromJson(jsonDecode(response.body));
          GenericFunctions()
              .toast(text: "Your orderId is: " + orderModel.orderId);
        }
      }
      /* ------------------------- if response is not 200 ------------------------- */
      else {
        GenericFunctions()
            .toast(text: "Error: " + response.statusCode.toString());
      }
    }
    /* --------------------------- if some other error -------------------------- */
    catch (e) {
      GenericFunctions().toast(text: "Error: " + e.toString());
    }
  }
}
