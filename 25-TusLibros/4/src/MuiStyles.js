const theme = createMuiTheme({
  palette: {
    primary: {
      main: '#556cd6',
    },
    secondary: {
      main: '#19857b',
    },
    error: {
      main: colors.red.A400,
    },
    background: {
      default: '#fff',
      paper: '#f5f5f5',
    },
  },
});

const styles = theme => ({
  root: {
    margin: theme.spacing(6, 0, 3),
  },
  lightBulb: {
    verticalAlign: 'middle',
    // marginRight: theme.spacing(1),
  },
  rootToolBar: {
    flexGrow: 1,
  },
  menuButton: {
    marginRight: theme.spacing(2),
  },
  logo: {
    marginRight: theme.spacing(2),
    fontSize: '40px'
  },
  textField: {
    marginTop: theme.spacing(2),
    marginBottom: theme.spacing(2),
  },
  title: {
    flexGrow: 1,
  },
  rootList: {
    width: '100%',
    backgroundColor: theme.palette.background.paper,
    position: 'relative',
    overflow: 'auto',
    maxHeight: 300,
  },
  textFieldDetails: {
    margin: theme.spacing(2),
  },

  headerButton: {
    color: '#FFFFFF',
    backgroundColor: '#7b7bff',
    padding: '6px 8px',
    margin: '0 8px'
  },

// --------- Book Adder

  bookAdder: {

  },

  bookAdderCantidad: {
    textAlign: "center",
    minWidth: "20px",
    display: "inline-block"
  },


// --------- Book Listing
  listingBook: {
    marginBottom: '10px',
    width: '100%',
    backgroundColor: '#e8e8e8',
    borderRadius: '10px',
   },

  listingBookItem: {
    width: '65%',
    display: 'inline-block',
    padding: '10px',

    '&:hover': {
      borderRadius: '10px',
      cursor: 'pointer',
      backgroundColor: '#c9c9c9'
    }
  },

  listingBookItemName: {
    'fontSize': '16px',
    'fontWeight': 'bold'
  },
  listingBookItemIsbn: {
    fontStyle: 'italic'
  },
  listingBookItemPrice: {
    'fontSize': '16px',
  },

  listingBookBuy: {
    display: 'inline-block',
    verticalAlign: 'top',
    marginTop: '25px',
    paddingLeft: '19px',
    width: '35%',
  },

// --------- Tickets

  ticket: {

    width: '100%',
    display: 'inline-block',
    padding: '5px',
    marginTop: '7px',
    borderRadius: '10px',
    backgroundColor: '#e8e8e8',
  },

  ticketElement: {
    width: '100%'
  },

  ticketQuantity: {
    width: '10%',
    display: 'inline-block',
    textAlign: 'center'
  },
  ticketBook: {
    width: '70%',
    display: 'inline-block'
  },
  ticketPrice: {
    width: '20%',
    display: 'inline-block',
    textAlign: 'right',
    paddingRight: '22px',
  },
  totalPrice: {
    textAlign: 'right',
    marginTop: '20px',
    marginRight: '25px',
    fontWeight: 'bold',
    fontSize: '20px',
  }

})

const useStyles = makeStyles(styles);
