import React from "react";
import "./styles.css";
import { FiArrowUpCircle } from "react-icons/fi";

const TotalRegistrations = () => {
  return (
    <div className="total-registrations flex center ">
      <div className="total-registrations_this_month flex row ">
        <div>
          <FiArrowUpCircle size={80} color="#16384d" fill="white" />
        </div>
        <div className="flex column ">
          <h2>Total Registrations</h2>
          <h6>This Month</h6>
          <h2 style={{ marginTop: "20px" }}>1958</h2>
        </div>
      </div>
      <div className="total-registrations_this_month flex row ">
        <div>
          <FiArrowUpCircle size={80} color="#16384d" fill="white" />
        </div>
        <div className="flex column ">
          <h2>The Leading Industry</h2>
          <h6>Startups' Top Choice</h6>
          <h2 style={{ marginTop: "20px" }}>Technology</h2>
        </div>
      </div>
    </div>
  );
};

export default TotalRegistrations;
