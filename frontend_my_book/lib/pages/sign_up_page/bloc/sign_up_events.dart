abstract class SignUpEvent{
  const SignUpEvent();
}

class UsernameEvent extends SignUpEvent{
  final String username;
  const UsernameEvent(this.username);
}

class EmailEvent extends SignUpEvent{
  final String email;
  const EmailEvent(this.email);
}

class PasswordEvent extends SignUpEvent{
  final String password;
  const PasswordEvent(this.password);
}

class ConfirmPasswordEvent extends SignUpEvent{
  final String confirmPassword;
  const ConfirmPasswordEvent(this.confirmPassword);
}