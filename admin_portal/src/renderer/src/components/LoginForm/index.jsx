import React, { useState } from "react";
import "./styles.css";
import InputField from "../InputField";
import { Link, useNavigate } from "react-router-dom";
import Button from "../Button";
import { setUser } from "../../core/redux/user/userSlice";
import { useDispatch } from "react-redux";
import { requestData } from "../../core/axios";

const LoginForm = () => {
  const navigate = useNavigate();
  const dispatch = useDispatch();
  const [values, setValues] = useState({
    email: "",
    password: "",
  });
  const HandleOnInputChange = (e) => {
    setValues({ ...values, [e.target.name]: e.target.value });
  };
  const handleLogin = async () => {
    try {
      const res = await requestData("login", "post", values);
      if (res.status == "success") {
        localStorage.setItem("token", `Bearer ${res.authorisation.token}`);
        if (res.user["user_type_id"] == 3) {
          dispatch(setUser(res.user));
          navigate("/statistics");
        } else {
          return alert("You are not an admin");
        }
      }
    } catch (err) {
      console.log(err.response.data);
      alert(err.response.data.message);
    }
  };
  return (
    <form className="login-form">
      <h2 className="form-title">Enter Admin Credentials</h2>
      <div className="form-body">
        <div className="email-field-wrapper">
          <InputField
            name={"email"}
            type={"email"}
            text={"Email"}
            value={values.email}
            handleChange={(e) => {
              HandleOnInputChange(e);
            }}
          />
        </div>
        <div className="password-field-wrapper">
          <InputField
            name={"password"}
            type={"password"}
            text={"Password"}
            value={values.password}
            handleChange={(e) => {
              HandleOnInputChange(e);
            }}
          />
        </div>
        <div className="btn-wrapper">
          <Button text={"Login"} type={"submit"} handleOnClick={handleLogin} />
        </div>
      </div>
    </form>
  );
};

export default LoginForm;
