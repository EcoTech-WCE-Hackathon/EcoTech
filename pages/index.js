import { data } from "autoprefixer";
import axios from "axios";
import Head from "next/head";
import { useEffect, useState } from "react";
import { DoughnutChart } from "../components/Doughnut";
import { LineChart } from "../components/Line";
import { transactions } from "../utils/transactions";
export default function Home() {
  const [dashState, setDashState] = useState({
    prev_week_reports_approved: [],
    prev_week_reports_picked: [],
    total_approved: 0,
    total_recyclers: 0,
    total_reports: 0,
    toxins: 0,
    waste_types: {},
    weight: 0,
    appusers: 0,
    waste_in: undefined,
    waste_out: undefined,
    top_5_states: undefined,
    transactions: transactions,
    income: 1000,
  });
  useEffect(() => {
    getData();
  }, []);
  const getData = async () => {
    let resp = await axios.get(
      `${process.env.NEXT_PUBLIC_SERVER}/api/v1/dashboard/stats`
    );
    console.log(resp.data.data);
    setDashState({ dashState, ...resp.data.data.stats });
  };
  return (
    <div className="flex">
      <Head>
        <title>Admin | EchoTech</title>
        <meta name="description" content="Admin Website for Echotech" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      {/* card section 1*/}

      <div className=" bg-white min-h-screen p-5 w-1/6">
        <div className=" flex justify-start mb-10">
          <div className="w-14 h-14 bg-green-500 my-auto rounded-full"></div>
          <div className="text-4xl font-extrabold ml-3 my-auto">EcoTech</div>
        </div>
        <div className=" flex justify-start hover:bg-[#E7F4F4] p-3 hover:cursor-pointer">
          <div className="w-7 h-7 bg-black my-auto rounded-full"></div>
          <div className="text-2xl ml-5">Dashboard</div>
        </div>
        <div className=" flex justify-start hover:bg-[#E7F4F4] p-3 hover:cursor-pointer">
          <div className="w-7 h-7 bg-black my-auto rounded-full"></div>
          <div className="text-2xl ml-5">Transactions</div>
        </div>
        <div className=" flex justify-start hover:bg-[#E7F4F4] p-3 hover:cursor-pointer">
          <div className="w-7 h-7 bg-black my-auto rounded-full"></div>
          <div className="text-2xl ml-5">Reports</div>
        </div>
        <div className=" flex justify-start hover:bg-[#E7F4F4] p-3 hover:cursor-pointer">
          <div className="w-7 h-7 bg-black my-auto rounded-full"></div>
          <div className="text-2xl ml-5">Recyclers</div>
        </div>
      </div>
      <div className=" bg-[#E7F4F4] min-h-screen p-5 w-4/6">
        <div className="text-2xl font-bold">Overview</div>
        <div className="mt-7 flex justify-between">
          <div className=" rounded-3xl flex p-5 bg-white justify-start w-[350px]">
            <div className="h-10 w-10 bg-[#5BBBBB] rounded-full my-auto"></div>
            <div className="ml-4 m-auto">
              <div className=" font-normal">Users</div>
              <div className="font-bold text-2xl">
                {dashState.appusers ? dashState.appusers : 0}
              </div>
            </div>
          </div>
          <div className=" rounded-3xl flex p-5 bg-white justify-start w-[350px]">
            <div className="h-10 w-10 bg-[#5BBBBB] rounded-full my-auto"></div>
            <div className="ml-4 m-auto">
              <div className=" font-normal">Reports</div>
              <div className="font-bold text-2xl">
                {dashState.total_approved ? dashState.total_approved : 0}
              </div>
            </div>
          </div>
          <div className=" rounded-3xl flex p-5 bg-white justify-start w-[350px]">
            <div className="h-10 w-10 bg-[#5BBBBB] rounded-full my-auto"></div>
            <div className="ml-4 m-auto">
              <div className=" font-normal">Recyclers</div>
              <div className="font-bold text-2xl">
                {dashState.total_recyclers ? dashState.total_recyclers : 0}
              </div>
            </div>
          </div>
        </div>

        {/* graph section */}
        <div className="mt-14 flex justify-between">
          <div className=" rounded-3xl pl-5 pt-5 bg-white  w-[700px]">
            <div className=" font-extrabold">Top 5 Recycling States</div>
            <div className="w-[300px] mx-auto">
              <DoughnutChart />
            </div>
          </div>
          <div className=" rounded-3xl p-5 bg-[#5BBBBB]  w-[400px] text-white flex flex-col justify-between">
            <div>
              <div className=" font-normal text-lg mt-5">
                Types of waste collected
              </div>
              <div className="font-extrabold text-3xl">
                {dashState.waste_types
                  ? Object.keys(dashState.waste_types).length
                  : 0}
              </div>
            </div>
            <div>
              <div className=" font-normal text-lg mt-5">
                Total waste collected
              </div>
              <div className="flex">
                <div className="font-extrabold text-3xl">
                  {dashState.weight ? dashState.weight.toFixed(2) : 0}
                </div>
                <div className=" mt-3 ml-2 text-lg">kg</div>
              </div>
            </div>
            <div>
              <div className=" font-normal text-lg mt-5">
                Total waste recycled
              </div>
              <div className="flex">
                <div className="font-extrabold text-3xl">
                  {dashState.toxins ? dashState.toxins.toFixed(2) : 0}
                </div>
                <div className=" mt-3 ml-2 text-lg">kg</div>
              </div>
            </div>
          </div>
        </div>
        <div className="mt-14">
          <div className="bg-white p-5 rounded-3xl w-full">
            <div className="w-full mx-auto">
              <LineChart
                waste_in={dashState.waste_in}
                waste_out={dashState.waste_out}
              />
            </div>
          </div>
        </div>
      </div>
      <div className=" bg-white min-h-screen p-5 w-1/6">
        <div className=" rounded-3xl flex p-5 bg-[#5BBBBB] justify-start w-[275px] text-white mt-14">
          <div className="h-14 w-14 bg-white rounded-full my-auto"></div>
          <div className="ml-4 m-auto">
            <div className=" font-normal text-lg">Income</div>
            <div className="font-bold text-3xl">Rs. {dashState.income}</div>
          </div>
        </div>
        <div className="font-extrabold text-2xl mt-10 mb-2">
          Recent Transactions
        </div>

        {/* Transactions */}

        {dashState.transactions.length !== 0
          ? dashState.transactions.map((tx) => {
              let style =
                tx.type === "Credit"
                  ? "h-14 w-14 bg-green-500 rounded-full my-auto"
                  : "h-14 w-14 bg-red-500 rounded-full my-auto";
              return (
                <div className="flex justify-between mt-5" key={tx}>
                  <div className={style}></div>
                  <div className="my-auto">
                    <div className="font-bold text-md ">{tx.type}</div>
                    <div className="text-gray-400 text-sm">{tx.company}</div>
                  </div>
                  <div className="my-auto">
                    <div className="font-bold text-md">Rs. {tx.amount}</div>
                    <div className="text-gray-400 text-sm">{tx.date}</div>
                  </div>
                </div>
              );
            })
          : ""}
      </div>
    </div>
  );
}
