class MyToolBarComponent extends React.Component {
  constructor(props) {
    super(props)
  }

  onHeaderButtonClick(path) {
    this.props.router.navigate(path)
  }
  onHeaderLogoutButtonClick(path){
    this.props.router.resetCartSize()
    this.onHeaderButtonClick(path)
  }

  renderHeaderButtons(current_path, classes) {
    return current_path == "/" ? null : (
      <div>
        <Button className={classes.headerButton}
          onClick={() => {this.onHeaderLogoutButtonClick("/")}}>
          Logout
        </Button>

        <Button className={classes.headerButton} disabled={current_path=="/catalog"}
          onClick={() => {this.onHeaderButtonClick("/catalog")}}>
          Catálogo
        </Button>

        <Button className={classes.headerButton} disabled={current_path=="/history"}
          onClick={() => {this.onHeaderButtonClick("/history")}}>
          Historial
        </Button>

        <Button className={classes.headerButton} disabled={current_path=="/cartList"}
          onClick={() => {this.onHeaderButtonClick("/cartList")}}>
          <Icon className="material-icons">
              shopping_cart
          </Icon>
          ({this.props.cartSize})
        </Button>
      </div>)
  }

  render() {
    const {
      router,
      title,
      classes,
    } = this.props

    const current_path = router.current()

    return (
      <div className={classes.rootToolBar}>
        <AppBar position="static">
          <Toolbar>

            <Icon className={classes.logo}> import_contacts </Icon>

            <Typography variant="h6" className={classes.title}>
              {title}
            </Typography>

            {this.renderHeaderButtons(current_path, classes)}

          </Toolbar>
        </AppBar>
      </div>
    )
  }

}

// Add style
const MyToolBar = withStyles(styles, {
  withTheme: true
})(MyToolBarComponent)
