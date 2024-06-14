//Exception class for handling various platform-related errors

class TPlatformException implements Exception {
  final String code;
  TPlatformException(this.code);

  String get message {
    switch(code){
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials. Please double-check yur information.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'invalid-argument':
        return 'Invalid argument provided to the authentication method.';
      case 'invalid-password':
        return 'Incorrect password. Please try again.';
      case 'operation-not-allowed':
        return 'The sign-in provider is disabled for your Firebase project.';
      case 'session-cookie-expired':
        return 'The Firebase session cookie has expired. Please sign in again.';
      case 'uid-already-expired':
        return 'The provided user ID is already in use by another user.';
      case 'sign_in_failed':
        return 'Sign-in failed. Please try again.';
      case 'network-request-failed':
        return 'Network request failed. Please check your internet connection.';
      case 'internal-error':
        return 'Internal error. Please try again later.';
      case 'invalid-verification-id':
        return 'Invalid verification ID. Please request a new verificaiton code.';
      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later.';
      default:
        return 'An unexpected platform error occured. Please try again later.';
    }
  }
}