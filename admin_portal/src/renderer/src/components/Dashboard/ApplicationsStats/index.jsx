import { ResponsiveBar } from "@nivo/bar";

const MyResponsiveBar = ({ pending, rejected }) => (
  <ResponsiveBar
    data={[
      {
        application: "Pending",
        pending: pending,
      },
      {
        application: "Rejected",
        rejected: rejected,
      },
    ]}
    keys={["pending", "rejected"]}
    indexBy="application"
    margin={{ top: 50, bottom: 50 }}
    padding={0.25}
    colors={["#D0E8FF", "#FF7060"]}
    axisBottom={{
      tickSize: 7,
      tickPadding: 8,
      tickRotation: 0,
      legend: "Application Status",
      legendPosition: "middle",
      legendOffset: 35,
    }}
  />
);
export default MyResponsiveBar;
