import Head from "next/head";
import { useEffect, useState } from "react";
import logoutPNG from "../assets/logout.png";
import { useRouter } from "next/router";
import axiosApiInstance from "../utils/axiosConfig";
import Logout from "../utils/Logout";

export default function Home() {
  const [wasteState, setWasteState] = useState({
    waste: [],
  });
  const router = useRouter();
  useEffect(() => {
    if (!sessionStorage.getItem("access")) {
      router.push("/login");
    }
    getData();
  }, []);
  const getData = async () => {
    let resp = await axiosApiInstance.get(
      `${process.env.NEXT_PUBLIC_SERVER}/api/v1/recycler/pickup`
    );
    setWasteState({ ...wasteState, waste: resp.data.data.waste });
  };
  const handleSubmit = async (e) => {
    e.preventDefault();
    wasteState.waste[e.target.id]["pickedUp"] =
      wasteState.waste[e.target.id]["approved"];
    let resp = await axiosApiInstance.patch(
      `${process.env.NEXT_PUBLIC_SERVER}/api/v1/recycler/pickup`,
      {
        data: wasteState.waste[e.target.id],
      }
    );
    getData();
  };
  const handleChange = (e) => {
    // Ik this is bad code , but just to make sure it wokrd I'm doing it :)
    let newWasteState = wasteState;
    newWasteState.waste[e.target.id][e.target.name] = e.target.value;
    setWasteState({ ...newWasteState });
  };
  return (
    <div className="w-full bg-[#E7F4F4] min-h-screen p-5">
      <Head>
        <title> Recyclers | EcoTech</title>
        <meta name="description" content="Website for ecotech recyclers" />
        <link rel="icon" href="/favicon.png" />
        <meta property="og:image" content="/site.png" />

        <meta property="og:url" content="https://recyclers.eco-tech.cf/" />
        <meta property="og:type" content="website" />
        <meta property="og:title" content="Admin | EchoTech" />
        <meta property="og:description" content="Admin Website for Echotech" />
        <meta name="twitter:card" content="summary_large_image" />
        <meta property="twitter:domain" content="recyclers.eco-tech.cf" />
        <meta property="twitter:url" content="https://recyclers.eco-tech.cf/" />
        <meta name="twitter:title" content="Admin | EchoTech" />
        <meta name="twitter:description" content="Admin Website for Echotech" />
        <meta
          name="twitter:image"
          content="https://recyclers.eco-tech.cf/site.png"
        />
      </Head>
      <div className=" font-bold text-3xl text-[#5BBBBB]">
        Welcome to Eco-Tech Recyclers dashboard
      </div>
      <div className="flex bg-[#E7F4F4] h-fit mt-10 justify-center border-green-600 w-full flex-wrap ">
        {wasteState.waste.length !== 0 ? (
          wasteState.waste.map((waste, i) => {
            return (
              <>
                <div className="bg-white rounded-xl p-5 w-[500px] m-5" key={i}>
                  <div className="flex">
                    <div className=" my-auto text-xl">Location: </div>
                    <textarea
                      value={waste.location}
                      className="ml-2 bg-[#E7F4F4] p-2 rounded-xl h-24 w-[350px] cursor-pointer"
                      readOnly
                    />
                  </div>
                  <form onSubmit={handleSubmit} id={i}>
                    <div className="flex mt-2">
                      <div className=" my-auto text-xl">Weight: </div>
                      <input
                        type="number"
                        value={wasteState.waste[i].weight}
                        className="ml-5 bg-[#E7F4F4] p-2 rounded-xl w-[350px]"
                        id={i}
                        name="weight"
                        onChange={handleChange}
                      />
                    </div>
                    <div className="flex mt-2">
                      <div className=" my-auto text-xl">Approve: </div>
                      <input
                        type="checkbox"
                        value={wasteState.waste[i].approved}
                        defaultChecked={wasteState.waste[i].approved}
                        className="ml-4 my-auto"
                        id={i}
                        name="approved"
                        onChange={() => {
                          // again bad practice but just to get the job done XD i'll fix it later
                          wasteState.waste[i].approved =
                            !wasteState.waste[i].approved;
                          setWasteState(wasteState);
                        }}
                      />
                    </div>
                    <div className="flex mt-2">
                      <div className=" my-auto text-xl">Type: </div>
                      <select
                        type="select"
                        value={wasteState.waste[i].wasteType}
                        className="ml-10 bg-[#E7F4F4] p-2 rounded-xl w-[350px]"
                        id={i}
                        name="wasteType"
                        onChange={handleChange}
                      >
                        <option value="computer">computer</option>
                        <option value="cables">cables</option>
                        <option value="display">display</option>
                        <option value="mobile">mobile</option>
                        <option value="others">others</option>
                      </select>
                    </div>
                    <div className="flex mt-2">
                      <div className=" my-auto text-lg">Reported: </div>
                      <input
                        disabled
                        className="ml-2 bg-[#E7F4F4] p-2 rounded-xl w-[350px]"
                        type="date"
                        value={wasteState.waste[i].created_at.split("T")[0]}
                      />
                    </div>
                    <div className="text-center">
                      <button
                        className="hover:text-black-600 mx-auto my-2 w-fit cursor-pointer rounded-md border-2 border-[#5BBBBB] bg-[#5BBBBB] px-2 py-1 text-white hover:bg-white hover:text-[#5BBBBB]"
                        type="submit"
                        id={i}
                      >
                        PickUp
                      </button>
                    </div>
                  </form>
                </div>
              </>
            );
          })
        ) : (
          <div className="text-5xl">Nothing To Pickup Today!</div>
        )}
      </div>
    </div>
  );
}
