class BookListingItemComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      catalog: null,
      loading: false,
    }
  }

  componentDidMount(){
    this.setState({
      loading: false,
    })
  }

  render() {
    const {
      router,
      book,
      classes,
      cartId
    } = this.props

    const {
      loading
    } = this.state


    if (loading) {return( <div>Loading...</div>)}

    return (
      <div
      className={classes.listingBook}
      key={book.isbn + "_listing"}
       >
        <div
          className={classes.listingBookItem}
          key={book.isbn}
          onClick={ ()=> router.navigate('/details',
              { selectedBook: book })}>
          <div className={classes.listingBookItemName}>{book.name}</div>
          <div className={classes.listingBookItemIsbn}>[ISBN: {book.isbn}]</div>
          <div className={classes.listingBookItemPrice}>${book.price}</div>
        </div>


        <div
          className={classes.listingBookBuy}
          key={book.isbn + "_buy"}>
          <BookAdder
            classes={classes}
            bookIsbn={book.isbn}
            cartId={cartId}
            router={this.props.router}/>
        </div>
      </div>
    )
  }
}

// Add style
const BookListingItem = withStyles(styles, {
  withTheme: true
})(BookListingItemComponent)
