import React from "react";
import { Chart as ChartJS, ArcElement, Tooltip, Legend } from "chart.js";
import { Doughnut } from "react-chartjs-2";
// ChartJS.register(ArcElement, Tooltip, Legend);
ChartJS.register(ArcElement, Tooltip);

export const data = {
  labels: ["MAH", "UP", "BH", "KT", "J&K"],
  datasets: [
    {
      label: "Top Recyclers",
      data: [12, 19, 3, 5, 2, 3],
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
export const options = {
  responsive: true,
  plugins: {
    legend: {
      position: "right",
    },
  },
};
export const DoughnutChart = () => {
  return (
    <div>
      <Doughnut data={data} options={options} />
    </div>
  );
};
