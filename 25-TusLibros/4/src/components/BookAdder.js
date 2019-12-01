class BookAdderComponent extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      cantidadEnCart: 0,
      loading: true,
    }
  }

  modifyCart(cartAction, booksToChange) {
    getLocalAsJson(`${cartAction}?bookQuantity=${Math.abs(booksToChange)}&bookIsbn=${this.props.bookIsbn}&cartId=${this.props.cartId}`)
      .then((response) => {
        return response.json()
      })
      .then((json) => {
        if (!json.result) { throw json.error }
      })
      .then(() => {
        this.setState({
          loading: false,
          cantidadEnCart: this.state.cantidadEnCart + booksToChange
        })
        this.props.router.addToCartSize(booksToChange);
      })
      .catch(err => {
        console.log('Che ojo, modifyCart', cartAction ,', : \n', err);
        this.setState({
          loading: false
        })
      });
  }

  clickAddBook() {
    this.modifyCart("addToCart", 1)
  }

  clickRemoveBook() {
    this.modifyCart("removeFromCart", -1)
  }

  componentDidMount(){
    getLocalAsJson(`listCart?cartId=${this.props.cartId}`)
      .then((response) => {
        return response.json()
      })
      .then((json) => {
        let amountByIsbn = json.result
        return amountByIsbn[this.props.bookIsbn] || 0
      })
      .then((cantEnServer) => {
        this.setState({
          loading: false,
          cantidadEnCart: cantEnServer
        })
      })
      .catch(err => {
        console.log('HUBO UN ERROR: \n', err);
        this.setState({
          loading: false,
          error: err,
        })
      });
  }

  render() {
    const {
      cartId,
      bookIsbn,
      router,
      classes,
    } = this.props

    const {
      cantidadEnCart,
      loading,
      error,
    } = this.state


    if (loading) {return( <div>Loading...</div>)}
    if (error) { return( <ErrorMessage error={error} />)}

    return (
       <div className={classes.bookAdder}>

        <Button onClick={(ev)=>this.clickRemoveBook()}>
          [-]
        </Button>

        <div className={classes.bookAdderCantidad}>
          {cantidadEnCart}
        </div>

        <Button onClick={(ev)=>this.clickAddBook()}>
          [+]
        </Button>

      </div>
    )
  }
}

// Add style
const BookAdder = withStyles(styles, {
  withTheme: true
})(BookAdderComponent)
