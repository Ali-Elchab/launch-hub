import React from "react";
import "./styles.css";
import { BaseURL } from "../../core/helpers/BaseImageURL";

export const JobPostModal = ({ jobpost, onClose, onDelete }) => {
  return (
    <div className="modal-backdrop">
      <div className="modal-content">
        <div className="flex top-row space-between">
          <h2>{jobpost["job_title"]}</h2>
          <button className="exit-button" onClick={onClose}>
            <span>&times;</span>
          </button>
        </div>
        <div className="flex column about">
          <h3>Job Post Details</h3>
          <p>{jobpost["job_description"]}</p>
          <p>
            <strong>Industry:</strong> {jobpost["industry_id"]}
          </p>
          <p>
            <strong>jobpost:</strong> {jobpost["job_type"]}
          </p>
          <p>
            <strong>Phone:</strong> {jobpost["company_phone"]}
          </p>
          <p>
            <strong>Registration Num:</strong> {jobpost["job_salary"]}
          </p>
          <p>
            <strong>Founding Date:</strong> {jobpost["job_qualification"]}
          </p>
          <p>
            <strong>Website:</strong> {jobpost["experience_level"]}
          </p>
          <p>
            <strong>Address:</strong> {jobpost["job_location"]}
          </p>
          <p>
            <strong>Deadline:</strong> {jobpost["deadline"]}
          </p>
          <p>
            <strong>Status:</strong> {jobpost["job_status"]}
          </p>
        </div>
        <div className="delete">
          <button onClick={onDelete} className="delete-button">
            Remove Job Post
          </button>
        </div>
      </div>
    </div>
  );
};
