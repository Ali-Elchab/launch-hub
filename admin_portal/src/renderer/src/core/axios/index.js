// axiosConfig.js
import axios from "axios";

// axios.defaults.baseURL = "http://13.37.250.77:80/api/";
axios.defaults.baseURL = "http://192.168.0.106:8000/api/";

export const requestData = async (route, method, data, headers = {}) =>
  await axios
    .request({
      url: `${route}`,
      method,
      data,
      headers: {
        "Content-Type": "application/json",
        ...headers,
      },
    })
    .then((res) => {
      return res.data;
    });

axios.interceptors.response.use(
  (response) => response,
  async (error) => {
    const originalRequest = error.config;
    if (error.response.status === 401 && !originalRequest._retry) {
      originalRequest._retry = true;
      try {
        const refreshToken = localStorage.getItem("refreshToken");
        const response = await axios.post("refresh", { refreshToken });
        const { accessToken } = response.data.authorisation.token;
        localStorage.setItem("accessToken", accessToken);
        axios.defaults.headers.common["Authorization"] =
          `Bearer ${accessToken}`;
        return axios(originalRequest);
      } catch (refreshError) {}
    }
    return Promise.reject(error);
  },
);
