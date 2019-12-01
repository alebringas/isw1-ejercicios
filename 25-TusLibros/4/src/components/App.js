class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      path: "/",
      selectedBook: "",
      cartSize: 0,
      user: "",
      pass:"",
      catalog:"",
    };
    this.userCreditCards = {
      "pepe"  : {ccn: "1111222233334444", cced: "012030", cco: "Jose"},
      "abrete": {ccn: "4815163248151632", cced: "012000", cco: "AliBaba"},
      "juana"  : {ccn: "1111222233334444", cced: "012030", cco: "JuanaDeArcor"},
    }
  }

  userCreditCard() {
    return this.userCreditCards[this.state.user];
  }

  componentDidMount(){

    getLocalAsJson(`catalog?`)
      .then(function (response) {
        return response.json()
      })
      .then((json)=>{
        this.setState({
          catalog: json.result,
        })
        return json.result
      })
      .catch((error)=> {
        console.log('Looks like there was a problem: \n', error);
        this.setState({ error: error})
      });
  }

  render() {
    let title = "TusLibros Puntocón"
    let content = "Where am I?"
    const router = {
      current: () => this.state.path,
      navigate: (path, state) => {
        // http://es6-features.org/#SpreadOperator
        this.setState({ ...state, path: path })
      },
      resetCartSize: () => {this.setState({cartSize : 0})},
      addToCartSize: (amountToChage) => {this.setState({cartSize : this.state.cartSize + amountToChage})},
      }

    if (this.state.path === "/") {
      content = (<LoginView
        router={router}
      />)
    } else if (this.state.path === "/catalog") {
      content = (<CatalogView
        router={router}
        cartId={this.state.cartId}
        catalog={this.state.catalog}
      />)
    } else if (this.state.path === "/cartList") {
      content = (<CartView
        router={router}
        cartId={this.state.cartId}
        creditCard={this.userCreditCard()}
      />)
    } else if (this.state.path === "/details") {
      content = (<BookDetailsView
        router={router}
        cartId={this.state.cartId}
        selectedBook={this.state.selectedBook}
      />)
    } else if (this.state.path === "/history") {
      content = (<HistoryView
        router={router}
        cartId={this.state.cartId}
        user={this.state.user}
        pass={this.state.pass}
        catalog={this.state.catalog}
      />)
    } else if (this.state.path === "/ticket") {
      content = (<PurchaseDetailView
        router={router}
        ticket={this.state.ticket}
        catalog={this.state.catalog}
      />)
    }

    return (
      <div>
        <MyToolBar
          title={title}
          router={router}
          cartSize={this.state.cartSize}
        />
        <Container maxWidth="sm">
          <div style={{ marginTop: 24 , marginBottom: 200}}>
            {content}
          </div>
        </Container>
      </div>
    );
  }
}
