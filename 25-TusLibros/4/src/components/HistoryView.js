class HistoryComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      error:"",
      ticketHistory: [],
      loading: true,
    }
  }

  componentDidMount(){
    getLocalAsJson(`listPurchases?clientId=${this.props.user}&password=${this.props.pass}`)
      .then((response) => {
        return response.json()
      })
      .then((json)=>{
        return json.result
      })
      .then((ticketHistory) => {
        this.setState({
          loading: false,
          ticketHistory: ticketHistory
        })
      })
      .catch((error)=> {
        console.log('Looks like there was a problem: \n', error);
        this.setState({ error: error , loading: false})
      });
  }

  render() {
    const {
      router,
      classes,
      cartId,
      catalog
    } = this.props

    const {
      ticketHistory,
      loading,
      error,
    } = this.state

    if (loading) {return( <div>Loading...</div>)}
    if (error) {return( <ErrorMessage error={error} />)}

    return (
      <div>
        <Typography variant="h4" component="h4" gutterBottom>
          HISTORIAL
        </Typography>

        <TicketList
          router={router}
          classes={classes}
          tickets={ticketHistory}
          catalog={catalog}
        />

      </div>
    )
  }
}

// Add style
const HistoryView = withStyles(styles, {
  withTheme: true
})(HistoryComponent)
