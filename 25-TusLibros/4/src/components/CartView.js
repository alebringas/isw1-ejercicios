class CartListComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      cartListing: [],
      catalog: null,
      loading: true,
      error: "",
    }
  }

  clickCheckout() {

    let userCard = this.props.creditCard
    let cartID = this.props.cartId

    getLocalAsJson(`checkOutCart?cartId=${cartID}&ccn=${userCard.ccn}&cced=${userCard.cced}&cco=${userCard.cco}`)
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        if (!json.result) {
          throw json.error
        }
        return json.result
      })
      .then( (checketOutItems) => {
        this.props.router.resetCartSize()
        this.props.router.navigate('/ticket',
              { ticket: checketOutItems })
      })
      .catch((error) => {
        console.log('Looks like there was a problem: \n', error)
        this.setState({error: error})
      });
  }

  completeCartInfoFromCatalog(catalog, amountByIsbn) {
    let cartListing = []
    catalog.forEach( (book) => {
      if (book.isbn in amountByIsbn) {
        book.amount = amountByIsbn[book.isbn]
        cartListing.push(book)
      }
    })
    return cartListing
  }

  renderCheckoutButton() {
    return this.state.cartListing.length
      ? (<Button
          key={"checkoutButton"}
          onClick={ ()=>this.clickCheckout() }>
          CHECKOUT
        </Button>)
      : "No hay elementos en el carrito";
  }

  // TODO: Refactor esto esta horrible
  componentDidMount(){
    this.setState({
      loading: true,
    })

    let amountByIsbn = {}

    getLocalAsJson(`listCart?cartId=${this.props.cartId}`)
      .then(function (response) {
        return response.json()
      })
      .then((json)=> {
        amountByIsbn = json.result
      })
      .then(()=> {
        return getLocalAsJson(`catalog?`)
      })
      .then((response) => {
        return response.json()
      })
      .then((json)=>{
        return this.completeCartInfoFromCatalog(json.result, amountByIsbn)
      })
      .then((listing) => {
        this.setState({
          loading: false,
          cartListing: listing
        })
      })
      .catch(function (error) {
        console.log('Looks like there was a problem: \n', error);
      });
  }

  render() {
    const {
      router,
      classes,
      cartId,
      creditCard,
    } = this.props

    const {
      cartListing,
      loading,
      error,
    } = this.state

    if (loading) {return( <div>Loading...</div>)}

    return (
      <div>
        <Typography variant="h4" component="h4" gutterBottom>
          CARRITO
        </Typography>

        <BookListing
          bookListing={cartListing}
          router={router}
          classes={classes}
          cartId={cartId}
        />

        { this.renderCheckoutButton() }

        <ErrorMessage error={error} />

      </div>
    )
  }
}

// Add style
const CartView = withStyles(styles, {
  withTheme: true
})(CartListComponent)
