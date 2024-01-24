import React, { useEffect, useState } from "react";
import { requestData } from "../../core/axios";

import "./styles.css";
import TotalRegistrations from "../../components/Dashboard/TotalRegistrations";
import MyResponsivePie from "../../components/Dashboard/UserDemographics";
import MyResponsiveBar from "../../components/Dashboard/ApplicationsStats";

const Statistics = () => {
  const [values, setValues] = useState({
    startups: 0,
    jobSeekers: 0,
    pendingApplications: 0,
    rejectedApplications: 0,
    totalRegisteredUsers: 0,
    leadingIndustry: "",
  });
  const [isLoading, setIsLoading] = useState(true);

  const getStatistics = async () => {
    const token = localStorage.getItem("token");
    const headers = {
      Authorization: token,
    };
    try {
      const res = await requestData(
        "admin/statistics",
        "get",
        null,
        headers,
      ).then((res) => {
        setIsLoading(false);

        console.log(values.totalRegisteredUsers);
        setValues(res);
      });
    } catch (err) {
      console.log(err);
    }
  };
  useEffect(() => {
    getStatistics();
  }, []);
  if (!isLoading) {
    return (
      <div className="content-container ">
        <TotalRegistrations
          totalRegisteredUsers={values.totalRegisteredUsers}
        />
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
  } else {
    return null;
  }
};

export default Statistics;
