import axios from "axios";
import RefreshAccessToken from "./refreshAccessToken";
const axiosApiInstance = axios.create();
axiosApiInstance.interceptors.request.use(
  async (config) => {
    const access_token = sessionStorage.getItem("access");
    config.headers = {
      Authorization: `Bearer ${access_token}`,
      Accept: "application/json",
      "Content-Type": "application/json",
    };
    return config;
  },
  (error) => {
    Promise.reject(error);
  }
);

axiosApiInstance.interceptors.response.use(
  (response) => {
    return response;
  },
  async function (error) {
    const originalRequest = error.config;
    if (error.response.status === 401 && !originalRequest._retry) {
      originalRequest._retry = true;
      const access_token = await RefreshAccessToken();
      axios.defaults.headers.common["Authorization"] = "Bearer " + access_token;
      return axiosApiInstance(originalRequest);
    }
    return Promise.reject(error);
  }
);

export default axiosApiInstance;
