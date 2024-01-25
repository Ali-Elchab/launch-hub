import React, { useEffect, useState } from "react";
import "./styles.css";
import { useDispatch, useSelector } from "react-redux";
import { useNavigate } from "react-router";
import { extractUserSlice } from "../../core/redux/user/userSlice";
import { ImExit } from "react-icons/im";
import InputField from "../../components/InputField";
import { setUser } from "../../core/redux/user/userSlice";
import { requestData } from "../../core/axios";

export const AdminProfile = () => {
  const dispatch = useDispatch();

  const navigate = useNavigate();
  const userState = useSelector(extractUserSlice);
  const { user } = userState;
  const [values, setValues] = useState({
    email: userState.email,
    password: "",
  });
  const signOut = () => {
    localStorage.removeItem("token");
    navigate("/");
  };

  const HandleOnInputChange = (e) => {
    setValues({ ...values, [e.target.name]: e.target.value });
  };
  const handleEdit = async () => {
    if (values.password.length < 6) {
      return alert("Password must be at least 6 characters");
    }

    try {
      const token = localStorage.getItem("token");
      const headers = {
        Authorization: token,
      };
      const res = await requestData(
        "admin/edit_profile",
        "post",
        values,
        headers,
      );
      if (res.status == "success") {
        if (res.user["user_type_id"] == 3) {
          dispatch(setUser(res.user));
          alert("Successfully updated");
          navigate("/statistics");
        } else {
          return alert("You are not an admin");
        }
      }
    } catch (err) {
      alert(err.response.data.message);
    }
  };

  return (
    <div className=" profile-container">
      <div className="profile-form">
        <div className="form-top flex center space-between">
          <div>
            <h2>{userState.email}</h2>
            <p style={{ marginTop: 20, fontWeight: 700, fontSize: 24 }}>
              Admin
            </p>
          </div>
          <ImExit
            onClick={signOut}
            size={30}
            style={{ marginRight: 45, color: "#326789", cursor: "pointer" }}
          />
        </div>
        <div className="form-bottom">
          <div className="flex column inputs">
            <div className="input-row flex full-width ">
              <p> Email</p>
              <div style={{ width: 300 }}>
                <InputField
                  value={values.email}
                  type={"text"}
                  name={"email"}
                  handleChange={(e) => {
                    HandleOnInputChange(e);
                  }}
                />
              </div>
            </div>
            <div className="input-row flex full-width ">
              <p> Password</p>
              <div style={{ width: 300 }}>
                <InputField
                  fontSize={25}
                  value={values.password}
                  type={"password"}
                  name={"password"}
                  handleChange={(e) => {
                    HandleOnInputChange(e);
                  }}
                />
              </div>
            </div>
            <div className="edit">
              <button onClick={handleEdit} className="edit-button">
                Submit Form
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};
