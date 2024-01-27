import "./styles.css";
import { BaseURL } from "../../core/helpers/BaseImageURL";

export const AdvisorModal = ({ advisor, onClose, onDelete }) => {
  return (
    <div className="modal-backdrop">
      <div className="modal-content">
        <div className="flex top-row space-between">
          <div className="flex center">
            <img
              src={`${BaseURL}assets/images/${advisor.photo_url}`}
              alt="Network Image"
              className="profile-pic"
            />
            <h2> {advisor["name"]}</h2>
          </div>
          <button className="exit-button" onClick={onClose}>
            <span>&times;</span>
          </button>
        </div>
        <div className="flex column about">
          <p>
            <strong>Category</strong> {advisor["category"]}
          </p>
          <p>
            <strong>Expertise</strong> {advisor["expertise"]}
          </p>
          <p>
            <strong>Name</strong> {advisor["name"]}
          </p>
          <p>
            <strong>Location</strong> {advisor["location"]}
          </p>
          <p>
            <strong>Phone</strong> {advisor["phone"]}
          </p>
          <p>
            <strong>Biography</strong> {advisor["bio"]}
          </p>
        </div>
        <div className="delete">
          <button onClick={onDelete} className="delete-button">
            Delete Account
          </button>
        </div>
      </div>
    </div>
  );
};
