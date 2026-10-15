// api.js
// 切换环境只改这里一行
// const baseURL = "http://127.0.0.1:8000" //本地调试
window.baseURL = "http://81.70.119.19:8080" //natapp外网

axios.defaults.baseURL = baseURL

// 顺带把token请求头也写在这里，所有请求自动携带token
axios.interceptors.request.use(function(config){
    const token = localStorage.getItem("token")
    if(token){
        config.headers.Authorization = `Bearer ${token}`
    }
    return config
})
