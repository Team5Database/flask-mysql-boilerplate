import { get, post } from "@/utils/request"
import { message } from 'ant-design-vue'

// const getBaseUrl = () => `http://${location.hostname}:60001`
const getBaseUrl = () => `http://43.153.136.233:60001`

export const baseUrl = getBaseUrl()

export const layoffs = {
    get: (id) => get(baseUrl + "/layoffs/" + id, defaultCallback),
    list: () => get(baseUrl + "/layoffs/", defaultCallback),
}

export const trends = {
    get_by_people: () => get(baseUrl + "/trends/bypeople", defaultCallback),
    get_by_events: () => get(baseUrl + "/trends/byevents", defaultCallback),
}

export const companies = {
    get: (id) => get(baseUrl + "/companies/" + id, defaultCallback),
    list: () => get(baseUrl + "/companies/", defaultCallback),
}

export const forum = {
    get: (id) => get(baseUrl + "/forum/" + id, defaultCallback),
    list: () => get(baseUrl + "/forum/", defaultCallback),
    replies: {
        get: (id) => get(baseUrl + "/forum/replies/" + id, defaultCallback),
        post: (id, content) => post(baseUrl + "/forum/replies/" + id, { content }, defaultCallback),
    }
}

export const resources = {
    get: (id) => get(baseUrl + "/resources/" + id, defaultCallback),
    list: () => get(baseUrl + "/resources/", defaultCallback),
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
    trends,
    companies,
    forum,
    resources,
}