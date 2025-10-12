import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/theming/app_styles.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../home/logic/cubit/home_cubit.dart';
import '../../../payment/data/model/payment_intent_input_model.dart';
import '../../../payment/logic/cubit/payment_cubit.dart';

class ConsumerPaymentButton extends StatefulWidget {
  const ConsumerPaymentButton({super.key});

  @override
  State<ConsumerPaymentButton> createState() => _ConsumerPaymentButtonState();
}

class _ConsumerPaymentButtonState extends State<ConsumerPaymentButton> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) async {
        if (state is PaymentSuccess) {
          context.read<HomeCubit>().clearCart();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('✅ Payment successful!')),
          );
        } else if (state is PaymentFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('❌ ${state.errMessage}')),
          );
        }
      },
      builder: (context, state) {
        if (state is PaymentLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return AppTextButton(
          buttonText: 'Go To Checkout',
          textStyle: AppStyles.font18whiteBold,
          onPressed: () async {
            final paymentCubit = context.read<PaymentCubit>();
            final cubit = context.read<HomeCubit>();
            final paymentIntentInputModel = PaymentIntentInputModel(
              amount: cubit.totalCartPrice.toInt(),
              currency: 'usd',
              customerId: '',
            );

            paymentCubit.makePayment(
                paymentIntentInputModel: paymentIntentInputModel);
          },
        );
      },
    );
  }
}
