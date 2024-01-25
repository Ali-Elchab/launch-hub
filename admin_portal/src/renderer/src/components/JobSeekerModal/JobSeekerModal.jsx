import React from "react";
import "./styles.css";
import { BaseURL } from "../../core/helpers/BaseImageURL";

export const JobSeekerModal = ({ jobSeeker, onClose, onDelete }) => {
  return (
    <div className="modal-backdrop">
      <div className="modal-content">
        <div className="flex top-row space-between">
          <div className="flex center">
            <img
              src={`${BaseURL}assets/images/profile_pics/${jobSeeker["profile_pic"]}`}
              alt="Network Image"
              className="profile-pic"
            />
            <h2> {jobSeeker["first_name"] + " " + jobSeeker["last_name"]}</h2>
          </div>
          <button className="exit-button" onClick={onClose}>
            <span>&times;</span>
          </button>
        </div>
        <div className="flex column about">
          <h3>About</h3>
          <p>{jobSeeker["bio"]}</p>
          <p>
            <strong>Industry:</strong> {jobSeeker["industry_id"]}
          </p>
          <p>
            <strong>Speciality:</strong> {jobSeeker["specialization_id"]}
          </p>
          <p>
            <strong>dob:</strong> {jobSeeker["dob"]}
          </p>
          <p>
            <strong>Phone:</strong> {jobSeeker["phone"]}
          </p>
          <p>
            <strong>Address:</strong> {jobSeeker["address"]}
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
