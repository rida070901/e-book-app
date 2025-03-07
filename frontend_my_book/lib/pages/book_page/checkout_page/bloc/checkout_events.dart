abstract class CheckoutEvent{
  const CheckoutEvent();
}

class TriggerCheckout extends CheckoutEvent{
  final String url;
  const TriggerCheckout(this.url);
}