// axiosConfig.js
import axios from "axios";
import { BaseURL } from "../helpers/BaseImageURL";

axios.defaults.baseURL = `${BaseURL}api/`;

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
