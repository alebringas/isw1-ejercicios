class TicketListComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      total: 0,
      costoFinal: 0,
      loading: true
    }
  }

  costoFinalTicketHistory(ticketHistory) {
    let costoFinal = 0
    ticketHistory.forEach((ticket) => {
      ticket.forEach((item) => {
        costoFinal += item.total
      })
    })
    return costoFinal
  }

  componentDidMount() {
    this.setState({
      loading: false,
      costoFinal: this.costoFinalTicketHistory(this.props.tickets)
    })
  }

  ticketHeaderLine() {
    return { quantity: 'CANT', item: 'LIBRO', total: 'TOTAL' }
  }

  render() {
    const {
      router,
      classes,
      tickets,
      catalog,
    } = this.props

    const {
      total,
      loading,
      costoFinal
    } = this.state


    if (loading) {return( <div>Loading...</div> )}

    return (
      <div>

        <TicketLine
          key={"ticketline_header"}
          bookSale={this.ticketHeaderLine()}
          classes={classes}
          catalog={catalog}
          />

        {
          tickets.map((ticket, ix) => {
            return (<Ticket className={classes.ticket}
              key={"ticket_" + ix}
              classes={classes}
              router={router}
              ticket={ticket}
              catalog={catalog}/>)
          })
        }

        <div className={classes.totalPrice}>
          TOTAL: {costoFinal}
        </div>
      </div>
    )
  }
}

// Add style
const TicketList = withStyles(styles, {
  withTheme: true
})(TicketListComponent)
