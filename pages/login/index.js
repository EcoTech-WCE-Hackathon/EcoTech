import Head from "next/head";
import { useRouter } from "next/router";
import { useState, useEffect } from "react";
import loginSVG from "../../assets/login.svg";
import { ToastContainer, toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import axios from "axios";
import { Fade } from "react-reveal";
export default function Login() {
  const errorToast = (message) => toast.error(message);
  const router = useRouter();
  const [formData, setFormData] = useState({ username: "", password: "" });
  const [isLoading, setLoading] = useState(false);

  useEffect(() => {
    if (
      sessionStorage.getItem("access") &&
      sessionStorage.getItem("access") !== undefined
    ) {
      router.push("/");
    }
  }, []);
  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    setLoading(true);
    e.preventDefault();

    try {
      let data = JSON.stringify(formData);
      let config = {
        method: "post",
        url: `${process.env.NEXT_PUBLIC_SERVER}/api/v1/auth/login`,
        headers: {
          "Content-Type": "application/json",
        },
        data: data,
      };
      let response = await axios(config);
      setFormData(() => ({ ...formData, username: "", password: "" }));
      sessionStorage.setItem("refresh", response.data.refresh);
      sessionStorage.setItem("access", response.data.access);
      router.push("/");
      setLoading(false);
    } catch (e) {
      errorToast("Invalid Credentials");
      setFormData(() => ({ ...formData, username: "", password: "" }));
      setLoading(false);
    }
  };
  return (
    <>
      <Head>
        <title>Login | EcoTech Recyclers</title>
        <meta
          name="description"
          content="A Website to generate your own Youtube Wrapped"
        />
        <link rel="icon" href="/favicon.png" />
      </Head>
      <div className="flex min-h-screen w-full flex-col bg-[#E7F4F4]">
        <div className="mx-auto my-auto flex h-fit w-full flex-col-reverse justify-between rounded-lg bg-none p-10 sm:w-1/2 sm:flex-row sm:bg-white">
          <Fade left cascade>
            <div className=" mx-auto my-auto h-fit w-fit rounded-md bg-white p-10  shadow-lg sm:bg-slate-200">
              <div className=" mb-2 flex justify-between">
                <h2 className="ml-1 cursor-pointer text-xl font-semibold text-[#5BBBBB]">
                  Login
                </h2>
              </div>
              <form className=" flex flex-col " onSubmit={handleSubmit}>
                <input
                  type="text"
                  placeholder="Enter Username"
                  className="m-auto my-1 w-fit rounded-sm border-2 border-gray-300 p-1 hover:border-[#5BBBBB] focus:border-[#5BBBBB]"
                  name="username"
                  required
                  onChange={handleChange}
                  value={formData.username}
                />
                <input
                  type="password"
                  placeholder="Enter Password"
                  minLength={6}
                  className="m-auto w-fit rounded-md border-2 border-gray-300 p-1 hover:border-[#5BBBBB] focus:border-[#5BBBBB]"
                  name="password"
                  required
                  onChange={handleChange}
                  value={formData.password}
                />
                {isLoading ? (
                  <p className=" mx-auto my-2 w-fit animate-bounce cursor-pointer rounded-md  bg-[#5BBBBB] px-2 py-1 text-red-100">
                    Loading...
                  </p>
                ) : (
                  <button
                    type="submit"
                    className="hover:text-black-600 mx-auto my-2 w-fit cursor-pointer rounded-md border-2 border-[#5BBBBB] bg-[#5BBBBB] px-2 py-1 text-white hover:bg-white hover:text-[#5BBBBB]  "
                  >
                    Login
                  </button>
                )}
              </form>
            </div>
          </Fade>
          <Fade right>
            <div className="my-auto ml-10 hidden w-full sm:block sm:w-96">
              <img src={loginSVG.src} className="w-full" alt="login" />
            </div>
          </Fade>
        </div>
        <ToastContainer />
      </div>
    </>
  );
}
