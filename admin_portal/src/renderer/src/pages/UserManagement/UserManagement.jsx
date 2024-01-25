import React, { useEffect, useState } from "react";
import { requestData } from "../../core/axios";
import "./styles.css";
import { StartupModal } from "../../components/StartupModal/StartupModal";
const baseURL = "http://192.168.0.106:8000/";

const UserManagement = () => {
  const [startups, setStartups] = useState([]);
  const [jobSeekers, setJobSeekers] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [isError, setIsError] = useState(false);
  const [selectedStartup, setSelectedStartup] = useState(null);

  const getStartups = async () => {
    const token = localStorage.getItem("token");
    const headers = {
      Authorization: token,
    };
    try {
      await requestData("admin/startups", "get", null, headers).then((res) => {
        setIsLoading(false);
        setStartups(res.startups);
      });
    } catch (err) {
      console.log(err);
      setIsError(true);
    }
  };

  const getJobSeekers = async () => {
    const token = localStorage.getItem("token");
    const headers = {
      Authorization: token,
    };
    try {
      await requestData("admin/jobSeekers", "get", null, headers).then(
        (res) => {
          setIsLoading(false);
          setJobSeekers(res.jobseekers);
        },
      );
    } catch (err) {
      console.log(err);
      setIsError(true);
    }
  };

  useEffect(() => {
    getStartups();
    getJobSeekers();
  }, []);

  const showStartup = (startup) => {
    setSelectedStartup(startup);
  };

  const closeModal = () => {
    setSelectedStartup(null);
  };
  if (!isLoading) {
    return (
      <div className="flex row user-management-container">
        <div className="flex column table">
          <h2 style={{ color: "#326789" }}>Startups</h2>

          {startups.map((startup, index) => (
            <div
              key={index}
              className="table-row flex row"
              onClick={() => showStartup(startup)}
            >
              <img
                src={`${baseURL}assets/images/profile_pics/${startup["logo_url"]}`}
                alt="Network Image"
                className="profile-pic"
              />
              {startup["company_name"]}
            </div>
          ))}
        </div>
        <div className="flex column table">
          <h2 style={{ color: "#326789" }}>Job Seekers</h2>

          {jobSeekers.map((jobSeeker, index) => (
            <div
              key={index}
              className="table-row flex row"
              onClick={() => showStartup(jobSeeker)}
            >
              <img
                src={`${baseURL}assets/images/profile_pics/${jobSeeker["profile_pic"]}`}
                alt="Network Image"
                className="profile-pic"
              />
              {jobSeeker["first_name"] + " " + jobSeeker["last_name"]}
            </div>
          ))}
        </div>
        {selectedStartup && (
          <StartupModal startup={selectedStartup} onClose={closeModal} />
        )}
      </div>
    );
  } else {
    return <div>Loading...</div>;
  }
};

export default UserManagement;
