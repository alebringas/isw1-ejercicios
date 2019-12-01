class CatalogView extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      loading: true,
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
      classes,
      cartId,
      catalog
    } = this.props

    const {
      loading,
      error,
    } = this.state

    if (loading) {return( <div>Loading...</div>)}
    if (error) {return(<ErrorMessage error={error} />)}

    return (
      <div>
        <Typography variant="h4" component="h4" gutterBottom>
          CATÁLOGO
        </Typography>

        <BookListing
          bookListing={catalog}
          router={router}
          classes={classes}
          cartId={cartId}
        />
      </div>
    )
  }
}

// Add style
const CatalogViewStyle = withStyles(styles, {
  withTheme: true
})(CatalogView)
