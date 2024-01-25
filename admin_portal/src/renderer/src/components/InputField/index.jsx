import React, { useEffect, useState } from "react";
import "./styles.css";

const InputField = ({ value, handleChange, type, text, name }) => {
  const [visible, setVisible] = useState(true);

  useEffect(() => {
    if (value === "") {
      setVisible(true);
    } else {
      setVisible(false);
    }
  }, [value]);

  return (
    <div className="form-input-wrapper">
      <input
        type={type}
        name={name}
        id={text}
        className="form-input"
        value={value}
        onChange={handleChange}
      />
      <label
        htmlFor="email"
        className={visible ? "form-label" : "form-label visible-value"}
      >
        {text}
      </label>
    </div>
  );
};

export default InputField;
