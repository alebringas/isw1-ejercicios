class TicketLineComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      total: 0,
      loading: true
    }
  }

  componentDidMount() {
    this.setState({
      loading: false
    })
  }

  getBookName(item) {

    let book = this.props.catalog.find( (book) => { return book.isbn == item } )

    return book ? book.name : item
  }

  render() {
    const {
      classes,
      bookSale,
      catalog
    } = this.props

    const {
      loading
    } = this.state


    if (loading) {return( <div>Loading...</div> )}

    return (
      <div key={bookSale.item} className={classes.ticketElement}>
        <div className={classes.ticketQuantity}>{bookSale.quantity}</div>
        <div className={classes.ticketBook}>{this.getBookName(bookSale.item)}</div>
        <div className={classes.ticketPrice}>{bookSale.total}</div>
      </div>
    )
  }
}

// Add style
const TicketLine = withStyles(styles, {
  withTheme: true
})(TicketLineComponent)
