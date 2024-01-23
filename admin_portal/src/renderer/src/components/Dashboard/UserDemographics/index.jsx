import { ResponsivePie } from "@nivo/pie";

const MyResponsivePie = ({ startups, jobSeekers }) => (
  <ResponsivePie
    data={[
      {
        id: "Startups",
        label: "Number of Startups",
        value: startups,
        color: "#D0E8FF",
      },
      {
        id: "Job Seekers",
        label: "Number of Job Seekers",
        value: jobSeekers,
        color: "#FF7060",
      },
    ]}
    margin={{ top: 20, right: 30, bottom: 80, left: 30 }}
    colors={["#D0E8FF", "#FF7060"]}
    enableArcLinkLabels={false}
    startAngle={-250}
    legends={[
      {
        anchor: "bottom",
        direction: "row",
        translateX: 0,
        translateY: 56,
        itemsSpacing: 0,
        itemWidth: 160,
        itemHeight: 25,
        itemTextColor: "#326789",
        itemDirection: "left-to-right",
        itemOpacity: 1,
        symbolSize: 22,
        symbolShape: "circle",
        symbolBorderWidth: 1,
      },
    ]}
    theme={{
      legends: {
        text: {
          fontSize: "12px",
          fontWeight: "bold",
        },
      },
    }}
  />
);
export default MyResponsivePie;
