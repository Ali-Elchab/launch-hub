import React from "react";
import "./styles.css";
import { BaseURL } from "../../core/helpers/BaseImageURL";

export const StartupModal = ({ startup, onClose, onDelete }) => {
  return (
    <div className="modal-backdrop">
      <div className="modal-content">
        <div className="flex top-row space-between">
          <div className="flex center">
            <img
              src={`${BaseURL}assets/images/profile_pics/${startup["logo_url"]}`}
              alt="Network Image"
              className="profile-pic"
            />
            <h2>{startup["company_name"]}</h2>
          </div>
          <button className="exit-button" onClick={onClose}>
            <span>&times;</span>
          </button>
        </div>
        <div className="flex column about">
          <h3>About</h3>
          <p>{startup["company_description"]}</p>
          <p>
            <strong>Industry:</strong> {startup["industry_id"]}
          </p>
          <p>
            <strong>Startup:</strong> {startup["company_name"]}
          </p>
          <p>
            <strong>Phone:</strong> {startup["company_phone"]}
          </p>
          <p>
            <strong>Registration Num:</strong> {startup["registration_number"]}
          </p>
          <p>
            <strong>Founding Date:</strong> {startup["founding_date"]}
          </p>
          <p>
            <strong>Address:</strong> {startup["company_address"]}
          </p>
          <p>
            <strong>Website:</strong> {startup["website_url"]}
          </p>
        </div>
        <div className="delete">
          <button onClick={onDelete} className="delete-button">
            Delete Account
          </button>
        </div>
      </div>
    </div>
  );
};
