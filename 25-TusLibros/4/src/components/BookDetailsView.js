class BookDetailsComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      details: {},
      loading: true,
      error: null,
    }
  }

  componentDidMount() {
    this.setState({
      loading: false,
      error: null,
    })
  }

  // Podria usar un compoente de react para que sea consistente el render
  bookDetailsComponent(name, value, classes) {
    return (<TextField
      id="outlined-read-only-input"
      label={name}
      defaultValue={value}
      className={classes.textFieldDetails}
      margin="normal"
      InputProps={{
        readOnly: true,
      }}
      variant="outlined"
    />)
  }

  render() {
    const {
      router,
      cartId,
      selectedBook,
      classes,
    } = this.props

    const {
      details,
      loading,
      error,
    } = this.state

    if (loading) return <div>Loading...</div>
    if (error) return <div>{error}</div>

    return (
      <div>
        <Typography variant="h4" component="h4" gutterBottom>
          Detalles de <b>{selectedBook.name}</b>
        </Typography>

        {this.bookDetailsComponent("Nombre", selectedBook.name, classes)}
        {this.bookDetailsComponent("Autor", selectedBook.author, classes)}
        {this.bookDetailsComponent("Precio", selectedBook.price, classes)}
        {this.bookDetailsComponent("ISBN", selectedBook.isbn, classes)}

        <BookAdder
          classes={classes}
          bookIsbn={selectedBook.isbn}
          cartId={cartId}
          router={router}/>

      </div>
    )
  }
}

// Add style
const BookDetailsView = withStyles(styles, {
  withTheme: true
})(BookDetailsComponent)
