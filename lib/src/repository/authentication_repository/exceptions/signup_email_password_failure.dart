class SignUpWithEmailAndPasswordFailure {
  final String message;

  //Constructor
  const SignUpWithEmailAndPasswordFailure([this.message = "An Unknown error occurred."]);
  factory SignUpWithEmailAndPasswordFailure.code(String code){
    switch(code){
      case 'invalidCredentialMessage': return SignUpWithEmailAndPasswordFailure('Incorrect Email or Password');
      case 'tooManyAttemptMessage': return SignUpWithEmailAndPasswordFailure('Too many failed login attempts. \n Please try again later.');
      case 'emptyInputMessage': return SignUpWithEmailAndPasswordFailure('Empty input. Please try again.');
      case 'unknownErrorMessage': return SignUpWithEmailAndPasswordFailure('Unknown error. Please try again.');
      default: return SignUpWithEmailAndPasswordFailure();
    }
  }
}