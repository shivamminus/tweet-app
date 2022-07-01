import Axios from "axios";
import { base_url } from "./config";

async function login(loginid, password) {
    const res = await Axios.post(base_url+"/login", {loginid, password});
    console.log(res)
    const {data} = await res;
    if (data.error) {
        return data.error
    } else {
        console.log(data)
        localStorage.setItem("token", data.token);
        localStorage.setItem("refreshToken", data.refreshToken);
        localStorage.setItem("loginid", data.loginid);
        localStorage.setItem("user_id", data.user_id);
        return true
    }
}

async function check() {
    const token = localStorage.getItem("token")
    try {
        const res = await Axios.post(base_url+"/api/checkiftokenexpire", {}, {
            headers: {

                Authorization: "Bearer " + token
            },
            
        })
        console.log(res)
        const {data} = await res;
        return data.success
    } catch {
        console.log("catch of check() ")
        const refresh_token = localStorage.getItem("refreshToken")
        if (!refresh_token) {
            localStorage.removeItem("token")
            return false;
        }
        Axios.post(base_url+"/api/refreshtoken", {}, {
            headers: {
                Authorization: `Bearer ${refresh_token}`
            }
        }).then(res => {
            localStorage.setItem("token", res.data.token)
        })
        return true;
    }
}

function logout() {
    if (localStorage.getItem("token")) {
        const token = localStorage.getItem("token")
        Axios.post(base_url+"/api/logout/access", {}, {
            headers: {
                Authorization: `Bearer ${token}`
            }
        }).then(res => {
            if (res.data.error) {
                console.error(res.data.error)
            } else {
                localStorage.removeItem("token")
            }
        })
    }
    if (localStorage.getItem("refreshToken")) {
        const refreshToken = localStorage.getItem("refreshToken")
        Axios.post(base_url+"/api/logout/refresh", {}, {
            headers: {
                Authorization: `Bearer ${refreshToken}`
            }
        }).then(res => {
            if (res.data.error) {
                console.error(res.data.error)
            } else {
                localStorage.removeItem("refreshToken")
            }
        })
    }
    localStorage.clear();
    setTimeout(() => window.location = "/", 500)
}

export {login, check, logout};