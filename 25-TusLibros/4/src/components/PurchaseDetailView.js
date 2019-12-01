class PurchaseDetailViewComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      loading: true
    }
  }

  componentDidMount() {
    this.setState({
      loading: false
    })
  }

  render() {
    const {
      router,
      classes,
      ticket,
      cartId,
      catalog,
    } = this.props

    const {
      loading
    } = this.state


    if (loading) {return( <div>Loading...</div> )}

    return (
      <div>
        <Typography component="h3" gutterBottom>
          TICKET
        </Typography>

        <TicketList
          router={router}
          classes={classes}
          tickets={[ticket]}
          catalog={catalog}
        />

      </div>
    )
  }
}

// Add style
const PurchaseDetailView = withStyles(styles, {
  withTheme: true
})(PurchaseDetailViewComponent)
