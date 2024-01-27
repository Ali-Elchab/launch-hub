import React, { useEffect, useState } from "react";
import "./styles.css";
import { BaseURL } from "../../core/helpers/BaseImageURL";
import { requestData } from "../../core/axios";

export const JobSeekerModal = ({ jobSeeker, onClose, onDelete }) => {
  const [industry, setIndustry] = useState("");
  const [specialization, setSpecialization] = useState("");

  useEffect(() => {
    const getIndustry = async () => {
      try {
        const res = await requestData(
          `industries/${jobSeeker["industry_id"]}`,
          "get",
        );
        if (res.status == "success") {
          setIndustry(res.industry.name);
        }
      } catch (err) {
        console.log(err);
      }
    };
    const getSpecialization = async () => {
      try {
        const res = await requestData(
          `specializations/${jobSeeker["specialization_id"]}`,
          "get",
        );
        if (res.status == "success") {
          setSpecialization(res.specialization.name);
        }
      } catch (err) {
        console.log(err);
      }
    };
    getIndustry();

    getSpecialization();
  }, []);
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
          <p>
            <strong>Biography</strong> {jobSeeker["bio"]}
          </p>
          <p>
            <strong>Industry</strong> {industry}
          </p>
          <p>
            <strong>Speciality</strong> {specialization}
          </p>
          <p>
            <strong>dob</strong> {jobSeeker["dob"]}
          </p>
          <p>
            <strong>Phone</strong> {jobSeeker["phone"]}
          </p>
          <p>
            <strong>Address</strong> {jobSeeker["address"]}
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
