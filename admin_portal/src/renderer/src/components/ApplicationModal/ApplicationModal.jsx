import React from "react";
import "./styles.css";
import { BaseURL } from "../../core/helpers/BaseImageURL";

export const ApplicationModal = ({ app, onClose, onDelete }) => {
  return (
    <div className="modal-backdrop">
      <div className="modal-content">
        <div className="flex top-row space-between">
          <h2>{app["job_post"]["job_title"]}</h2>
          <button className="exit-button" onClick={onClose}>
            <span>&times;</span>
          </button>
        </div>
        <div className="flex column about">
          <h3>Job Post Details</h3>
          <p>{app["job_post"]["job_title"]}</p>
          <p>
            <strong>Industry:</strong> {app["job_post"]["job_title"]}
          </p>
          <p>
            <strong>jobpost:</strong> {app["job_post"]["job_title"]}
          </p>
          <p>
            <strong>Phone:</strong> {app["job_post"]["job_title"]}
          </p>
          <p>
            <strong>Registration Num:</strong> {app["job_post"]["job_title"]}
          </p>
          <p>
            <strong>Founding Date:</strong> {app["job_post"]["job_title"]}
          </p>
          <p>
            <strong>Website:</strong> {app["job_post"]["job_title"]}
          </p>
          <p>
            <strong>Address:</strong> {app["job_post"]["job_title"]}
          </p>
          <p>
            <strong>Deadline:</strong> {app["job_post"]["job_title"]}
          </p>
          <p>
            <strong>Status:</strong> {app["job_post"]["job_title"]}
          </p>
        </div>
        <div className="delete">
          <button onClick={onDelete} className="delete-button">
            Remove Application
          </button>
        </div>
      </div>
    </div>
  );
};
