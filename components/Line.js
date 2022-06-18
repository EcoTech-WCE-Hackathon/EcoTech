import React from "react";
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend,
} from "chart.js";
import { Line } from "react-chartjs-2";

ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend
);

export const options = {
  responsive: true,
  plugins: {
    legend: {
      position: "bottom",
    },
    title: {
      display: true,
      text: "Waste In vs Waste Out",
    },
  },
};

const labels = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

export const data = {
  labels,
  datasets: [
    {
      label: "Waste Out",
      data: [100, 120, 30, 40, 90, 110, 10],
      borderColor: "rgb(255, 99, 132)",
      backgroundColor: "rgba(255, 99, 132, 0.5)",
      //   lineTension: 0.8,
    },
    {
      label: "Waste In",
      data: [40, 90, 50, 100, 140, 20, 70],
      borderColor: "rgb(53, 162, 235)",
      backgroundColor: "rgba(53, 162, 235, 0.5)",
      //   lineTension: 0.8,
    },
  ],
};

export const LineChart = () => {
  return <Line options={options} data={data} />;
};
