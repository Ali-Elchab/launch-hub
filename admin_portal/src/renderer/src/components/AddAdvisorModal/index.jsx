import React, { useState } from "react";
import InputField from "../InputField";
import "./styles.css";

const AddAdvisor = ({ onClose }) => {
  const [values, setValues] = useState({
    name: "",
    category: "",
    bio: "",
    expertise: "",
    email: "",
    phone: "",
    photo_url: "",
  });
  const HandleOnInputChange = (e) => {
    setValues({ ...values, [e.target.name]: e.target.value });
  };

  const addAdvisor = async () => {
    console.log(values);
    const token = localStorage.getItem("token");
    const headers = {
      Authorization: token,
    };
    try {
      await requestData("admin/add_advisor", "post", values, headers).then(
        (res) => {
          alert("Advisor Added Successfully");
          onClose();
        },
      );
    } catch (err) {
      alert(err.response.data.message);
    }
  };

  return (
    <div className="modal-backdrop">
      <div className="add-content">
        <div className="flex top-row space-between">
          <h2>Add Advisor</h2>
          <button className="exit-button" onClick={onClose}>
            <span>&times;</span>
          </button>
        </div>

        <InputField
          name={"name"}
          text={"Name"}
          value={values.name}
          handleChange={(e) => {
            HandleOnInputChange(e);
          }}
        />
        <InputField
          name={"email"}
          text={"Email"}
          value={values.email}
          handleChange={(e) => {
            HandleOnInputChange(e);
          }}
        />
        <InputField
          name={"phone"}
          text={"Phone"}
          value={values.phone}
          handleChange={(e) => {
            HandleOnInputChange(e);
          }}
        />
        <select id="category" name="category" required>
          <option value="">Select Category</option>
          <option value="finance">Finance</option>
          <option value="legal">Legal</option>
          <option value="marketing">Marketing</option>
        </select>
        <InputField
          name={"expertise"}
          text={"Experties"}
          value={values.expertise}
          handleChange={(e) => {
            HandleOnInputChange(e);
          }}
        />
        <InputField
          name={"bio"}
          text={"Biography"}
          value={values.bio}
          handleChange={(e) => {
            HandleOnInputChange(e);
          }}
        />
        <div className="submit">
          <button className="submit-button" onClick={addAdvisor}>
            Submit
          </button>
        </div>
      </div>
    </div>
  );
};

export default AddAdvisor;
