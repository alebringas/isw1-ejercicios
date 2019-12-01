class BookListing extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      loading: true
    }
  }

  renderBookListing() {
    const {
      bookListing,
      router,
      classes,
      cartId
    } = this.props

    let bookListingsCart = bookListing.map((book) => {
     return (
        <BookListingItem
          key={book.isbn + "_listing"}
          router={router}
          book={book}
          classes={classes}
          cartId={cartId}
        /> )
      })

    return bookListingsCart
  }

  componentDidMount(){
    this.setState({
      loading: false
    })
  }

  render() {
    const {
      loading
    } = this.state

    if (loading) {return( <div>Loading...</div>)}

    return (
      <div>
        { this.renderBookListing() }
      </div>
    )
  }
}

// Add style
const BookListingStyle = withStyles(styles, {
  withTheme: true
})(BookListing)
