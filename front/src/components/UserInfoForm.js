import React, { PropTypes, Component } from 'react';
import is from 'is_js';
import FlatButton from 'material-ui/FlatButton';
import TextField from 'material-ui/TextField';
import DatePicker from './inputs/DatePicker';
import Dialog from './Dialog';
import { validateDate, validatePhone } from '../helpers/numeral';


const styles = {
  button: {
    margin: '0 5px',
  },
};

class UserInfoForm extends Component {
  constructor(props) {
    super(props);
    this.state = {
      first_name: this.props.user.first_name,
      last_name: this.props.user.last_name,
      birth_date: this.props.user.birth_date,
      email: this.props.user.email,
      phone: this.props.user.phone,
      error: {},
    };
    this.onSubmit = this.onSubmit.bind(this);
  }


  onSubmit() {
    const { first_name, last_name, birth_date, email, phone } = this.state;
    const error = {};
    if (!validatePhone(this.state.phone)) error.phone = 'Debes ingresar un número válido';
    if (!validateDate(this.state.birth_date)) error.date = 'Esta fecha no existe';
    if (is.not.empty(error)) this.setState({ error });
    else {
      this.props.updateUser({
        first_name,
        last_name,
        birth_date,
        email,
        phone,
      });
    }
  }

  disabled() {
    const { first_name, last_name, email } = this.state;
    return first_name === '' || last_name === '' || email === '';
  }

  render() {
    const actions = [
      <FlatButton
        label="Cancelar"
        onTouchTap={this.props.handleClose}
        secondary
      />,
      <FlatButton
        label="Ok"
        onTouchTap={this.onSubmit}
        style={styles.button}
        secondary
        disabled={this.disabled()}
      />,
    ];
    return (
      <Dialog
        title="Información general"
        open={this.props.open}
        actions={actions}
        contentContainerClassName="form-container"
        onRequestClose={this.props.handleClose}
        className="form"
        mobile={this.props.mobile}
        form="edit/user"
      >
        <div className="row">
          <div className="form__field">
            <TextField
              onChange={(e, val) => this.setState({ first_name: val })}
              floatingLabelText="Nombre"
              fullWidth
              value={this.state.first_name}
            />
          </div>
          <div className="form__field">
            <TextField
              onChange={(e, val) => this.setState({ last_name: val })}
              floatingLabelText="Apellido"
              fullWidth
              value={this.state.last_name}
            />
          </div>
        </div>
        <div className="row">
          <div className="form__field">
            <TextField
              onChange={(e, val) => this.setState({ email: val })}
              floatingLabelText="Correo electrónico"
              fullWidth
              value={this.state.email}
            />
          </div>
          <div className="form__field">
            <TextField
              onChange={(e, val) => this.setState({ phone: val, error: {} })}
              floatingLabelText="Teléfono"
              hintText="+56961403258"
              fullWidth
              value={this.state.phone}
              errorText={this.state.error.phone || ''}
            />
          </div>
        </div>
        <div className="col">
          <span className="range-input__title is-margin-left">Cumpleaños</span>
          <div className="form__field form__field-3">
            <DatePicker
              handleChange={val => this.setState({ birth_date: val, error: {} })}
              date={this.state.birth_date}
              errorText={this.state.error.date || ''}
            />
          </div>
        </div>
      </Dialog>
    );
  }
}

UserInfoForm.propTypes = {
  handleClose: PropTypes.func.isRequired,
  open: PropTypes.bool.isRequired,
  user: PropTypes.object.isRequired,
};

export default UserInfoForm;
