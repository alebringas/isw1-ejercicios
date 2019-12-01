class ErrorMessageComponent extends React.Component {
  constructor(props) {
    super(props)
  }

  renderErrorIfExists() {
    let error = this.props.error
    return error
      ? (<div style={{color: "red"}}> {error} </div>)
      : null;
  }

  render() {
    const {
      router,
      classes,
      error,
    } = this.props

    return (
      <div>
        { this.renderErrorIfExists()}
      </div>
    )
  }
}

// Add style
const ErrorMessage = withStyles(styles, {
  withTheme: true
})(ErrorMessageComponent)
