import React from "react";
import "./styles.css";
import TotalRegistrations from "../../components/Dashboard/TotalRegistrations";
import MyResponsivePie from "../../components/Dashboard/UserDemographics";

const Statistics = () => {
  return (
    <div className="content-container ">
      <TotalRegistrations />
      <div className="flex row " style={{ height: 500, gap: 30 }}>
        <div className="userStats" style={{ width: "40%" }}>
          <h2 style={{ color: "#326789" }}>Number of Users</h2>
          <MyResponsivePie jobSeekers={13} startups={50} />
        </div>
      </div>
    </div>
  );
};

export default Statistics;
