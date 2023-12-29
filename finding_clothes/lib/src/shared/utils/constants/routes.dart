class Routes {
  static const initial = "/";
  static const initialSubpath = "";

  static const login = "/login";
  static const register = "/register";

  static const dashboard = "/dashboard";

  static const result = "/result";

  static const subscrition = "/subscrition";

  static const emailValidation = "/emailValidation/:${RouteParameters.email}/:${RouteParameters.password}";
}

class RouteParameters {
  static const loanId = "loanId";

  static const email = "email";
  static const password = "password";

}