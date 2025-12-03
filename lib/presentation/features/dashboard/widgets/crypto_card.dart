import 'package:cached_network_image/cached_network_image.dart';
import 'package:final_l3/core/constants/color_constants.dart';
import 'package:final_l3/core/themes/app_text_styles.dart';
import 'package:final_l3/domain/entity/crypto_entity.dart';
import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  final bool? favoriteScreen;
  final CryptoEntity coin;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const CryptoCard({
    required this.coin,
    this.favoriteScreen,
    super.key,
    this.onTap,
    this.onDelete,
  });

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
          padding: const EdgeInsets.all(16),
          child: Row(
            spacing: 16,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: coin.image,
                  height: 42,
                  width: 42,
                ),
              ),

              Expanded(
                child: Column(
                  spacing: 12,
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

                    Row(
                      children: [
                        Text(
                          coin.symbol.toUpperCase(),
                          style: AppTextStyles.label.copyWith(
                            color: ColorConstants.grey,
                          ),
                        ),
                        const SizedBox(width: 8),

                        Container(
                          padding: const EdgeInsets.all(8),
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

              favoriteScreen == true
                  ? IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: onDelete,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
