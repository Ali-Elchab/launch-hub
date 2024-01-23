import React, { useEffect, useState } from "react";
import "./style.css";
import { useLocation, useNavigate } from "react-router";

export const Sidebar = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const [display, setDisplay] = useState(true);
  const [activeItem, setActiveItem] = useState(null);

  useEffect(() => {
    setDisplay(location.pathname !== "/");
  }, [location.pathname]);

  const handleItemClick = (itemName) => {
    navigate(`/${itemName}`);
    setActiveItem(itemName);
  };

  return display ? (
    <div className="sidebar flex column">
      <ul className="main-list">
        <li>
          LaunchHub
          <ul className="sub-list">
            <li
              className={activeItem === "statistics" ? "active" : ""}
              onClick={() => handleItemClick("statistics")}
            >
              Dashboard
            </li>
            <li
              className={activeItem === "passengers" ? "active" : ""}
              onClick={() => handleItemClick("passengers")}
            >
              User Management
            </li>
            <li
              className={activeItem === "jobs" ? "active" : ""}
              onClick={() => handleItemClick("jobs")}
            >
              Job Post Management
            </li>
            <li
              className={activeItem === "content" ? "active" : ""}
              onClick={() => handleItemClick("content")}
            >
              Content Management
            </li>
          </ul>
        </li>
      </ul>
    </div>
  ) : null;
};
