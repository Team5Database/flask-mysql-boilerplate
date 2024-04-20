import { get, post } from "@/utils/request"
import { message } from 'ant-design-vue'

// const getBaseUrl = () => `http://${location.hostname}:60001`
const getBaseUrl = () => `http://43.153.136.233:60001`

export const baseUrl = getBaseUrl()

export const layoffs = {
    get: (id) => get(baseUrl + "/layoffs/" + id, defaultCallback),
    list: () => get(baseUrl + "/layoffs/", defaultCallback),
}

export const defaultCallback = {
    succeed: (res) => {
        return res
    }, 
    failed: (res) => {
        message.error(res.msg || "Request failed")
        return res
    },
    network_error: (err) => {
        message.error("Network error")
        return err
    }
}

export const Api = {
    layoffs,
}