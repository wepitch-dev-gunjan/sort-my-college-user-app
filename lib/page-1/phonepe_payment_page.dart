/*import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

class PhonePayPaymentScreen extends StatefulWidget {
  const PhonePayPaymentScreen({super.key});

  @override
  State<PhonePayPaymentScreen> createState() => _PhonePayPaymentScreenState();
}

class _PhonePayPaymentScreenState extends State<PhonePayPaymentScreen> {
  String environment = "SANDBOX";
  String appId = "";
  String merchantId = "PGTESTPAYUAT";
  bool enableLogging = true;
  String checkSum = "";
  String saltKey = "099eb0cd-02cf-4e2a-8aca-3e6c6aff0399";
  String saltIndex = "1";
  String callBackUrl =
      "https://webhook.site/a53375c1-0ed6-432e-8c25-ad324fed6c2a";

  String body = "";
  Object? result;
  String apiEndPoint = "/pg/v1/pay";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PhonePayInit();
    body = getCheckSum().toString();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PhonePay Payment gateway'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: startPgTransaction,
                child: const Text('Start Transition'),
              ),
              const SizedBox(
                height: 20,
              ),
              Text('Result : $result'),
            ],
          ),
        ),
      ),
    );
  }

  void startPgTransaction() {
    try {
      var response = PhonePePaymentSdk.startPGTransaction(
        body,
        callBackUrl,
        checkSum,
        {},
        apiEndPoint,
        "",
      );
      response
          .then((val) => {
        setState(() {
          if (val != null) {
            String status = val["status"].toString();
            String error = val["error"].toString();

            if (status == "SUCCESS") {
              result = "Flow complete - status : SUCCESS";
            } else {
              result =
              "Flow complete - status : $status and error :$error";
            }
          } else {
            result = "Flow Incomplete";
          }
        })
      })
          .catchError((error) {
        handleError(error);
        return <dynamic>{};
      });
    } catch (error) {
      handleError(error);
    }
  }

  getCheckSum() {
    var requestData = {
      "merchantId": merchantId,
      "merchantTransactionId": "transaction_123",
      "merchantUserId": "90223250",
      "amount": 1000,
      "mobileNumber": "9999999999",
      "callbackUrl": callBackUrl,
      "paymentInstrument":{"type": "PAY_PAGE"}
    };

    String base64Body = base64.encode(utf8.encode(json.encode(requestData)));

    checkSum =
    '${sha256.convert(utf8.encode(base64Body + apiEndPoint + saltKey)).toString()}###$saltIndex';

    return base64Body;
  }

  void PhonePayInit() {
    PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
        .then((val) => {
      setState(() {
        result = 'PhonePe SDK Initialized - $val';
        print(result);
        //handleException: Invalid appId!
      })
    })
        .catchError((error) {
      handleError(error);
      return <dynamic>{};
    });
  }

  void handleError(error) {
    setState(() {
      result = {"error": error};
      print(result);
    });
  }
}
*/

