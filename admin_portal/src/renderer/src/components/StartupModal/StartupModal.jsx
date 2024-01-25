import React from "react";
import "./styles.css";

export const StartupModal = ({ startup, onClose }) => {
  return (
    <div className="modal-backdrop">
      <div className="modal-content">
        <h2>{startup["company_name"]}</h2>
        {/* other details */}
        <button onClick={onClose}>Close</button>
      </div>
    </div>
  );
};
