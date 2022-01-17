import axios from "axios";

const instance = axios.create({
    baseURL: "http://172.16.55.172:8080/",
});

instance.interceptors.request.use( config  => {
    const token = localStorage.getItem("token");
    config.headers.Authorization = token ? `Bearer ${token}` : "";
    return config;
});

export { instance };
