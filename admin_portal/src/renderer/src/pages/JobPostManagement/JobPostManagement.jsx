import React, { useEffect, useState } from "react";
import { requestData } from "../../core/axios";
import "./styles.css";
import { FaArrowRight } from "react-icons/fa";
import { JobPostModal } from "../../components/JobPostModal/JobPostModal";
import { ApplicationModal } from "../../components/ApplicationModal/ApplicationModal";
import Spinner from "../../components/Spinnes";

const JobPostManagement = () => {
  const [jobPosts, setJobPosts] = useState([]);
  const [applications, setApplications] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [isError, setIsError] = useState(false);
  const [selectedJobPost, setSelectedJobPost] = useState(null);
  const [selectedApplication, setSelectedApplication] = useState(null);

  const getJobPosts = async () => {
    const token = localStorage.getItem("token");
    const headers = {
      Authorization: token,
    };
    try {
      await requestData("admin/jobposts", "get", null, headers).then((res) => {
        setIsLoading(false);
        setJobPosts(res);
      });
    } catch (err) {
      alert(err.response.data.message);
      setIsError(true);
    }
  };

  const getApplications = async () => {
    const token = localStorage.getItem("token");
    const headers = {
      Authorization: token,
    };
    try {
      await requestData("admin/applications", "get", null, headers).then(
        (res) => {
          setIsLoading(false);
          setApplications(res);
        },
      );
    } catch (err) {
      alert(err.response.data.message);
      setIsError(true);
    }
  };

  useEffect(() => {
    getJobPosts();
    getApplications();
  }, []);

  const showJobPost = (JobPost) => {
    setSelectedJobPost(JobPost);
  };
  const showApplication = (Application) => {
    setSelectedApplication(Application);
  };

  const closeModal = () => {
    setSelectedApplication(null);
    setSelectedJobPost(null);
  };

  const deleteJobPost = async (jobPost) => {
    const token = localStorage.getItem("token");
    const headers = {
      Authorization: token,
    };
    try {
      await requestData(
        `admin/jobpost/${jobPost["id"]}`,
        "delete",
        null,
        headers,
      ).then((res) => {
        setIsLoading(false);
        const updatedjobPosts = jobPosts.filter(
          (s) => s["id"] !== jobPost["id"],
        );
        setJobPosts(updatedjobPosts);
        setSelectedJobPost(null);
      });
    } catch (err) {
      setIsError(true);
    }
  };
  const deleteApplication = async (application) => {
    const token = localStorage.getItem("token");
    const headers = {
      Authorization: token,
    };
    try {
      await requestData(
        `admin/application/${application["id"]}`,
        "delete",
        null,
        headers,
      ).then((res) => {
        setIsLoading(false);
        const updatedapplications = applications.filter(
          (s) => s["id"] !== application["id"],
        );
        setApplications(updatedapplications);
        setSelectedApplication(null);
      });
    } catch (err) {
      setIsError(true);
    }
  };

  const getStartup = async (startup) => {
    const token = localStorage.getItem("token");
    const headers = {
      Authorization: token,
    };
    try {
      await requestData(
        `admin/startup/${startup["id"]}`,
        "get",
        null,
        headers,
      ).then((res) => {
        setIsLoading(false);
        return res.startup;
      });
    } catch (err) {
      alert(err.response.data.message);
      setIsError(true);
    }
  };

  if (!isLoading) {
    return (
      <div className="content-container">
        <h1 style={{ marginBottom: "1rem" }}>Job Posts Management</h1>
        <div className="flex row user-management-container">
          <div className="flex column table">
            <h2 style={{ color: "#326789" }}>Job Posts</h2>
            {jobPosts.map((jobPost, index) => (
              <div
                key={index}
                className="table-row flex row "
                onClick={() => showJobPost(jobPost)}
              >
                {jobPost["job_title"]}

                <p style={{ fontSize: 10 }}>Deadline:{jobPost["deadline"]}</p>
              </div>
            ))}
          </div>
          <div className="flex column table">
            <h2 style={{ color: "#326789" }}>Applications</h2>
            {applications.map((app, index) => (
              <div
                key={index}
                className="table-row flex row space-between"
                onClick={() => showApplication(app)}
              >
                {app.job_seeker && <h4>{app.job_seeker.first_name}</h4>}
                <h4>
                  <FaArrowRight />
                </h4>
                <h4> {app["job_post"]["job_title"]}</h4>
              </div>
            ))}
          </div>
          {selectedJobPost && (
            <JobPostModal
              jobpost={selectedJobPost}
              onClose={closeModal}
              onDelete={() => deleteJobPost(selectedJobPost)}
            />
          )}
          {selectedApplication && (
            <ApplicationModal
              app={selectedApplication}
              onClose={closeModal}
              onDelete={() => deleteApplication(selectedApplication)}
            />
          )}
        </div>
      </div>
    );
  } else {
    return <Spinner />;
  }
};

export default JobPostManagement;
