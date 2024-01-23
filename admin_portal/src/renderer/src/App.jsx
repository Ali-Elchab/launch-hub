import "./styles/index.css";
import Login from "./pages/Login";
import { Route, Routes } from "react-router";
import Statistics from "./pages/Statistics";
import { Sidebar } from "./components/Sidebar";

function App() {
  return (
    <div className="page flex row">
      <Sidebar />
      <div className="main">
        <Routes>
          <Route path="/" element={<Login />} />
          <Route path="/statistics" element={<Statistics />} />
        </Routes>
      </div>
    </div>
  );
}

export default App;
