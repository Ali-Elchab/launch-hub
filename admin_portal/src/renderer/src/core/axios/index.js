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
