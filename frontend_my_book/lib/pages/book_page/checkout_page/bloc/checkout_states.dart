class CheckoutState{
  final String url;

  const CheckoutState({this.url=""});

  CheckoutState copyWith({String? url}){
    return CheckoutState(url: url ?? this.url);
  }
}