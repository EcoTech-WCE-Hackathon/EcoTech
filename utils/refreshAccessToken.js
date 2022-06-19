import axios from "axios";
import Logout from "./Logout";
export default async function RefreshAccessToken() {
  var data = JSON.stringify({
    refresh: sessionStorage.getItem("refresh"),
  });
  let config = {
    method: "post",
    url: `${process.env.NEXT_PUBLIC_SERVER_BASE_URL}/api/v1/auth/token/refresh`,
    headers: {
      "Content-Type": "application/json",
    },
    data: data,
  };
  try {
    let result = await axios(config);
    if (result.data.access) {
      sessionStorage.setItem("access", result.data.access);
      return result.data.access;
    }
  } catch (e) {
    Logout();
  }
}
