import React from "react";
import { Chart as ChartJS, ArcElement, Tooltip, Legend } from "chart.js";
import { Doughnut } from "react-chartjs-2";
// ChartJS.register(ArcElement, Tooltip, Legend);
ChartJS.register(ArcElement, Tooltip);

export const options = {
  responsive: true,
  plugins: {
    legend: {
      position: "right",
    },
  },
};
export const DoughnutChart = ({ state_data }) => {
  const data = {
    labels: state_data
      ? Object.keys(state_data)
      : ["GUJ", "MAH", "BH", "KT", "J&K"],
    datasets: [
      {
        label: "Top Recyclers",
        data: state_data
          ? Object.keys(state_data).map((key) => state_data[key])
          : [12, 19, 3, 5, 2],
        backgroundColor: [
          "rgba(255, 99, 132, 0.5)",
          "rgba(54, 162, 235, 0.5)",
          "rgba(255, 206, 86, 0.5)",
          "rgba(75, 192, 192, 0.5)",
          "rgba(153, 102, 255, 0.5)",
        ],
        borderColor: [
          "rgba(255, 99, 132, 1)",
          "rgba(54, 162, 235, 1)",
          "rgba(255, 206, 86, 1)",
          "rgba(75, 192, 192, 1)",
          "rgba(153, 102, 255, 1)",
        ],
        borderWidth: 1,
      },
    ],
  };
  return (
    <div>
      <Doughnut data={data} options={options} />
    </div>
  );
};
