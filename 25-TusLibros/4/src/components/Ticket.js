class TicketComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      total: 0,
      loading: true
    }
  }

  componentDidMount() {
    let totalCost = 0
    this.props.ticket.forEach( (ticketItem) => {
      totalCost += ticketItem.total
    })

    this.setState({
      loading: false,
      total: totalCost
    })
  }

  renderTicketLines(ticket, classes) {
    let ticketElements = ticket.map((bookSale, ix) => {
      return (
        <TicketLine
          key={"ticketline_" + ix}
          bookSale={bookSale}
          classes={classes}
          catalog={this.props.catalog} />
      )
    })
    return ticketElements
  }

  render() {
    const {
      router,
      classes,
      ticket,
      cartId,
      catalog
    } = this.props

    const {
      total,
      loading
    } = this.state


    if (loading) {return( <div>Loading...</div> )}

    return (
      <div className={classes.ticket}>
        { this.renderTicketLines(ticket, classes) }
      </div>
    )
  }
}

// Add style
const Ticket = withStyles(styles, {
  withTheme: true
})(TicketComponent)
