import React, { useEffect, useState } from "react";
import { requestData } from "../../core/axios";
import "./styles.css";
import { StartupModal } from "../../components/StartupModal/StartupModal";
import { JobSeekerModal } from "../../components/JobSeekerModal/JobSeekerModal";
import Spinner from "../../components/Spinnes";
const baseURL = "http://192.168.0.106:8000/";

const UserManagement = () => {
  const [startups, setStartups] = useState([]);
  const [jobSeekers, setJobSeekers] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [isError, setIsError] = useState(false);
  const [selectedStartup, setSelectedStartup] = useState(null);
  const [selectedJobSeeker, setSelectedJobSeeker] = useState(null);

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
      alert(err.response.data.message);

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
      alert(err.response.data.message);

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
  const showJobSeeker = (jobSeeker) => {
    setSelectedJobSeeker(jobSeeker);
  };

  const closeModal = () => {
    setSelectedStartup(null);
    setSelectedJobSeeker(null);
  };

  const deleteStartup = async (startup) => {
    const token = localStorage.getItem("token");
    const headers = {
      Authorization: token,
    };
    try {
      await requestData(
        `admin/startup/${startup["user_id"]}`,
        "delete",
        null,
        headers,
      ).then((res) => {
        setIsLoading(false);
        const updatedStartups = startups.filter(
          (s) => s["id"] !== startup["id"],
        );
        setStartups(updatedStartups);
        setSelectedStartup(null);
      });
    } catch (err) {
      alert(err.response.data.message);
      setIsError(true);
    }
  };
  const deleteJobSeeker = async (jobSeeker) => {
    const token = localStorage.getItem("token");
    const headers = {
      Authorization: token,
    };
    try {
      await requestData(
        `admin/jobseeker/${jobSeeker["user_id"]}`,
        "delete",
        null,
        headers,
      ).then((res) => {
        setIsLoading(false);
        const updatedjobSeekers = jobSeekers.filter(
          (s) => s["id"] !== jobSeeker["id"],
        );
        setJobSeekers(updatedjobSeekers);
        setSelectedJobSeeker(null);
      });
    } catch (err) {
      alert(err.response.data.message);
      setIsError(true);
    }
  };

  if (!isLoading) {
    return (
      <div className="content-container">
        <h1 style={{ marginBottom: "1rem" }}>User Management</h1>
        <div className="flex row user-management-container">
          <div className="flex column table">
            <h2 style={{ color: "#326789" }}>Startups</h2>

            {startups.map((startup, index) => (
              <div
                key={index}
                className="users-table-row flex row"
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
                className="users-table-row flex row"
                onClick={() => showJobSeeker(jobSeeker)}
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
            <StartupModal
              startup={selectedStartup}
              onClose={closeModal}
              onDelete={() => deleteStartup(selectedStartup)}
            />
          )}
          {selectedJobSeeker && (
            <JobSeekerModal
              jobSeeker={selectedJobSeeker}
              onClose={closeModal}
              onDelete={() => deleteJobSeeker(selectedJobSeeker)}
            />
          )}
        </div>
      </div>
    );
  } else {
    return <Spinner />;
  }
};

export default UserManagement;
