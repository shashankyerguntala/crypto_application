import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_l3/core/constants/color_constants.dart';
import 'package:final_l3/core/themes/app_text_styles.dart';
import 'package:final_l3/domain/entity/crypto_entity.dart';
import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  final CryptoEntity coin;
  final VoidCallback? onTap;

  const CryptoCard({required this.coin, super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isPositive = coin.priceChangePercentage24h >= 0;
    final priceColor = isPositive
        ? ColorConstants.success
        : ColorConstants.error;

    return Card(
      elevation: 2,
      surfaceTintColor: ColorConstants.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: coin.image,
                  height: 42,
                  width: 42,
                ),
              ),
              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coin.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),

                    Row(
                      children: [
                        Text(
                          coin.symbol.toUpperCase(),
                          style: AppTextStyles.label.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 8),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstants.primary.withAlpha(8),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "#${coin.marketCapRank}",
                            style: AppTextStyles.label.copyWith(
                              color: ColorConstants.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${coin.currentPrice}",
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: priceColor.withAlpha(12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "${coin.priceChangePercentage24h}%",
                      style: AppTextStyles.label.copyWith(
                        color: priceColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 12),
            ],
          ),
        ),
      ),
    );
  }
}
