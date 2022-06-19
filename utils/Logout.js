export default function Logout() {
  sessionStorage.removeItem("refresh");
  sessionStorage.removeItem("access");
}
