class LoginComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      error: "",
      user: "",
      pass: "",
      response: "",
      cartID: ""
    }
  }

  handleUserChange(event) {
    this.setState({
      user: event.target.value
    })
  };
  handlePasswordChange(event) {
    this.setState({
      pass: event.target.value
    })
  };

  handleKeyPress(event) {
    if (event.key === "Enter") {
      this.handleSend();
    }
  };

  handleSend() {
    const {
      router,
    } = this.props

    const {
      user,
      pass,
      response,
    } = this.state

    getLocalAsJson(`createCart?clientId=${user}&password=${pass}`)
      .then(function (response) {
        return response.json()
      })
      .then((json) => {
        if (json.error) {
          throw json.error
        }
        return json.result
      })
      .then((cartId) => {
        this.setState({ cartId: cartId })

        console.log('Seteado el id como', this.state.cartId)

        router.navigate('/catalog', { cartId: this.state.cartId,
                                      user: this.state.user,
                                      pass: this.state.pass })
      })
      .catch((error) => {
        console.log('Looks like there was a problem: \n', error);
        this.setState({ error: error })
      });
  }


  render() {
    const {
      error,
      user,
      pass,
      response,
      cartId
    } = this.state

    const {
      classes,
    } = this.props

    return (
      <div>
        <Typography component="h1" gutterBottom>
          Iniciar sesión
        </Typography>
        <FormControl fullWidth className={classes.textField} variant="outlined">

          <OutlinedInput
            id="user"
            value={user}
            onChange={(ev)=>this.handleUserChange(ev)}
            placeholder="Usuario"
            rows="1"
          />
        </FormControl>

        <FormControl fullWidth className={classes.textField} variant="outlined">

          <OutlinedInput
            id="password"
            type="password"
            value={pass}
            onChange={(ev)=>this.handlePasswordChange(ev)}
            placeholder="Contraseña"
            rows="1"
            onKeyPress={(ev)=>this.handleKeyPress(ev)}
          />
        </FormControl>

        <Button
          color="inherit"
          onClick={(ev)=>this.handleSend(ev)}>
          Create cart
        </Button>


        <ErrorMessage error={error} />

      </div>
    )
  }
}

// Add style
const LoginView = withStyles(styles, {
  withTheme: true
})(LoginComponent)
