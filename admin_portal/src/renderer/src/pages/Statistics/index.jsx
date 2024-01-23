import React from "react";
import "./styles.css";
import TotalRegistrations from "../../components/Dashboard/TotalRegistrations";
import MyResponsivePie from "../../components/Dashboard/UserDemographics";
import MyResponsiveBar from "../../components/Dashboard/ApplicationsStats";

const Statistics = () => {
  return (
    <div className="content-container ">
      <TotalRegistrations />
      <div className="flex row " style={{ gap: 30 }}>
        <div className="userStats" style={{ height: 500, width: "40%" }}>
          <h2 style={{ color: "#326789" }}>Number of Users</h2>
          <MyResponsivePie jobSeekers={13} startups={50} />
        </div>
        <div className="userStats" style={{ height: 500, width: " 60% " }}>
          <h2 style={{ color: "#326789" }}>Number of Applications</h2>
          <MyResponsiveBar pending={55} rejected={9} />
        </div>
      </div>
    </div>
  );
};

export default Statistics;
