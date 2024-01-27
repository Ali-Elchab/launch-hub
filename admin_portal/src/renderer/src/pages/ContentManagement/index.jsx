import React, { useEffect, useState } from "react";
import { requestData } from "../../core/axios";
import "./styles.css";
import Spinner from "../../components/Spinnes";
import { AdvisorModal } from "../../components/AdvisorModal";
import AddAdvisor from "../../components/AddAdvisorModal";
const baseURL = "http://192.168.0.106:8000/";

const ContentManagement = () => {
  const [advisors, setAdvisors] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [isError, setIsError] = useState(false);
  const [selectedAdvisor, setSelectedAdvisor] = useState(null);
  const [legal, setLegal] = useState([]);
  const [finance, setFinance] = useState([]);
  const [marketing, setMarketing] = useState([]);
  const [addAdvisor, setAddAdvisor] = useState(false);

  const getAdvisors = async () => {
    const token = localStorage.getItem("token");
    const headers = {
      Authorization: token,
    };
    try {
      await requestData("admin/advisors", "get", null, headers).then((res) => {
        setIsLoading(false);
        setAdvisors(res);
        const legal = res.filter((advisor) => advisor["category"] === "legal");
        const finance = res.filter(
          (advisor) => advisor["category"] === "finance",
        );
        const marketing = res.filter(
          (advisor) => advisor["category"] === "marketing",
        );
        setLegal(legal);
        setFinance(finance);
        setMarketing(marketing);
      });
    } catch (err) {
      alert(err.response.data.message);
      setIsError(true);
    }
  };

  useEffect(() => {
    getAdvisors();
  }, []);

  const showAdvisor = (advisor) => {
    setSelectedAdvisor(advisor);
  };

  const closeModal = () => {
    setSelectedAdvisor(null);
    setAddAdvisor(null);
  };

  const deleteAdvisor = async (advisorId) => {
    const token = localStorage.getItem("token");
    const headers = {
      Authorization: token,
    };
    try {
      await requestData(
        `admin/advisor/${advisorId}`,
        "delete",
        null,
        headers,
      ).then((res) => {
        setIsLoading(false);
        const updatedLegalAdvisors = legal.filter((s) => s["id"] !== advisorId);
        const updatedFinanceAdvisors = finance.filter(
          (s) => s["id"] !== advisorId,
        );
        const updatedMarketingAdvisors = marketing.filter(
          (s) => s["id"] !== advisorId,
        );
        setLegal(updatedLegalAdvisors);
        setFinance(updatedFinanceAdvisors);
        setMarketing(updatedMarketingAdvisors);
        setSelectedAdvisor(null);
      });
    } catch (err) {
      alert(err.response.data.message);
      setIsError(true);
    }
  };
  if (!isLoading) {
    return (
      <div className="content-container">
        <div className="flex space-between">
          <h1 style={{ marginBottom: "1rem" }}>Content Management</h1>
          <button
            className="add-button"
            onClick={() => {
              setAddAdvisor(true);
            }}
          >
            Add Advisor
          </button>
        </div>
        <div className="flex row content-management-container">
          <div className="flex column table">
            <h2 style={{ color: "#326789" }}>Marketing Advisors</h2>

            {marketing.map((advisor, index) => (
              <div
                key={index}
                className="users-table-row flex row"
                onClick={() => showAdvisor(advisor)}
              >
                <img
                  src={`${baseURL}assets/images/${advisor["photo_url"]}`}
                  alt="Network Image"
                  className="profile-pic"
                />
                <div className="flex row">{advisor["name"]}</div>
              </div>
            ))}
          </div>
          <div className="flex column table">
            <h2 style={{ color: "#326789" }}>Accounting Advisors</h2>

            {finance.map((advisor, index) => (
              <div
                key={index}
                className="users-table-row flex row"
                onClick={() => showAdvisor(advisor)}
              >
                <img
                  src={`${baseURL}assets/images/${advisor["photo_url"]}`}
                  alt="Network Image"
                  className="profile-pic"
                />
                <div className="flex row">{advisor["name"]}</div>
              </div>
            ))}
          </div>
          <div className="flex column table">
            <h2 style={{ color: "#326789" }}>Legal Advisors</h2>

            {legal.map((advisor, index) => (
              <div
                key={index}
                className="users-table-row flex row"
                onClick={() => showAdvisor(advisor)}
              >
                <img
                  src={`${baseURL}assets/images/${advisor["photo_url"]}`}
                  alt="Network Image"
                  className="profile-pic"
                />
                <div className="flex row">{advisor["name"]}</div>
              </div>
            ))}
          </div>

          {selectedAdvisor && (
            <AdvisorModal
              advisor={selectedAdvisor}
              onClose={closeModal}
              onDelete={() => deleteAdvisor(selectedAdvisor["id"])}
            />
          )}
          {addAdvisor && <AddAdvisor onClose={closeModal} />}
        </div>
      </div>
    );
  } else {
    return <Spinner />;
  }
};

export default ContentManagement;
