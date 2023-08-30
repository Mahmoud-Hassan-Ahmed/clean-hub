// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clean_hub/service/book_confirmation_service.dart';
import 'package:clean_hub/service/booking_services/book_service.dart';
import 'package:clean_hub/service/booking_services/personalization_service.dart';
import 'package:clean_hub/service/booking_services/place_order_service.dart';
import 'package:clean_hub/service/jobs_service/job_request_service.dart';
import 'package:clean_hub/service/order_details_service.dart';
import 'package:clean_hub/service/profile_service.dart';
import 'package:clean_hub/service/wallet_service.dart';
import 'package:clean_hub/view/payments/razorpay_payment_page.dart';

class RazorpayService {
  payByRazorpay(BuildContext context,
      {bool isFromOrderExtraAccept = false,
      bool isFromWalletDeposite = false,
      bool isFromHireJob = false}) {
    //========>
    Provider.of<PlaceOrderService>(context, listen: false).setLoadingFalse();

    var amount;

    String name;
    String phone;
    String email;
    String orderId;

    name = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .name ??
        'test';
    phone = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .phone ??
        '111111111';
    email = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .email ??
        'test@test.com';
    if (isFromOrderExtraAccept == true) {
      amount = Provider.of<OrderDetailsService>(context, listen: false)
          .selectedExtraPrice;
      // amount = '10.0';
      amount = double.parse(amount).toStringAsFixed(1);
      orderId = Provider.of<OrderDetailsService>(context, listen: false)
          .selectedExtraId
          .toString();
    } else if (isFromWalletDeposite) {
      amount = Provider.of<WalletService>(context, listen: false).amountToAdd;
      amount = double.parse(amount).toStringAsFixed(1);
      orderId = 'wallet' +
          Provider.of<WalletService>(context, listen: false)
              .walletHistoryId
              .toString();
    } else if (isFromHireJob) {
      amount = Provider.of<JobRequestService>(context, listen: false)
          .selectedJobPrice;

      amount = double.parse(amount).toStringAsFixed(1);
      orderId = 'hireJob$name';
    } else {
      var bcProvider =
          Provider.of<BookConfirmationService>(context, listen: false);
      var pProvider =
          Provider.of<PersonalizationService>(context, listen: false);
      var bookProvider = Provider.of<BookService>(context, listen: false);

      name = bookProvider.name ?? '';
      phone = bookProvider.phone ?? '';
      email = bookProvider.email ?? '';

      if (pProvider.isOnline == 0) {
        amount = bcProvider.totalPriceAfterAllcalculation.toStringAsFixed(2);
      } else {
        amount = bcProvider.totalPriceOnlineServiceAfterAllCalculation
            .toStringAsFixed(2);
      }
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => RazorpayPaymentPage(
            amount: amount,
            name: name,
            phone: phone,
            email: email,
            isFromOrderExtraAccept: isFromOrderExtraAccept,
            isFromWalletDeposite: isFromWalletDeposite,
            isFromHireJob: isFromHireJob),
      ),
    );
  }
}
