/*Route<dynamic>? gerarRota(RouteSettings settings) {
  switch(settings.name) {
    case LANDING_PAGE_ROUTE:
      return _getPageRoute(LandingPage(), settings);
    case CADASTRO_ROUTE:
      if (UsuarioAtual.retornarUsuarioLogado() != null) {
        return _getPageRoute(TelaCadastro(), settings);
      }
      return _getPageRoute(LandingPage(), settings);
    case LOGIN_ROUTE:
      if (UsuarioAtual.retornarUsuarioLogado() != null) {
        return _getPageRoute(TelaLogin(), settings);
      }
      return _getPageRoute(LandingPage(), settings);
    case HOME_ROUTE:
      if (UsuarioAtual.retornarUsuarioLogado() != null) {
        return _getPageRoute(TelaHome(), settings);
      }
      return _getPageRoute(LandingPage(), settings);
    case PERFIL_ROUTE:
      if (UsuarioAtual.retornarUsuarioLogado() != null) {
        return _getPageRoute(TelaPerfil(), settings);
      }
      return _getPageRoute(LandingPage(), settings);
    default:
      return null;
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _MudaRota(child, settings);
}

class _MudaRota extends PageRouteBuilder {
  final Widget child;
  final RouteSettings settings;

  _MudaRota(this.child, this.settings) : super(
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation
    ) => child,
    transitionDuration: Duration(milliseconds: 10),
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) => FadeTransition(opacity: animation, child: child)
  );
}*/