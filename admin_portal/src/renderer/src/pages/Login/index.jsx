import LoginForm from "../../components/LoginForm";
import logo from "../../assets/images/logo.png";
import "./styles.css";
const Login = () => {
  return (
    <div className=" flex column login">
      <img src={logo} alt="logo" className="logo" />
      <LoginForm />
    </div>
  );
};

export default Login;
