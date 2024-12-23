import 'package:flutter/material.dart';
import 'package:handyman_provider_flutter/components/price_widget.dart';
import 'package:handyman_provider_flutter/main.dart';
import 'package:handyman_provider_flutter/models/total_earning_response.dart';
import 'package:handyman_provider_flutter/utils/common.dart';
import 'package:handyman_provider_flutter/utils/configs.dart';
import 'package:handyman_provider_flutter/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

class TotalEarningWidget extends StatelessWidget {
  const TotalEarningWidget({Key? key, required this.totalEarning}) : super(key: key);

  final TotalData totalEarning;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8),
      width: context.width(),
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: radius(),
        backgroundColor: context.scaffoldBackgroundColor,
        border: Border.all(color: context.dividerColor, width: 1.0),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(languages.paymentMethod, style: primaryTextStyle()),
              Text(
                totalEarning.paymentMethod.validate().capitalizeFirstLetter(),
                style: boldTextStyle(color: primaryColor),
              ),
            ],
          ),
          if (totalEarning.description.validate().isNotEmpty)
            Column(
              children: [
                16.height,
                Text(totalEarning.description.validate(), style: secondaryTextStyle()),
              ],
            ),
          16.height,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor: context.cardColor,
              borderRadius: radius(),
            ),
            width: context.width(),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(languages.lblAmount, style: secondaryTextStyle(size: 14)),
                    16.width,
                    PriceWidget(price: totalEarning.amount.validate(), color: primaryColor, isBoldText: true, size: 14).flexible(),
                  ],
                ),
                16.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(languages.lblDate, style: secondaryTextStyle(size: 14)),
                    Text(
                      formatDate(totalEarning.createdAt.validate().toString(), format: DATE_FORMAT_9),
                      style: boldTextStyle(size: 14),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
