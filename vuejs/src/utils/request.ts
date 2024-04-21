type Callback = {
    succeed?: (res: any) => void
    failed?: (res: any) => void
    network_error?: (err: any) => void
}

const setHeader = (ct = null) => {
    let headers = {}
    if (ct) headers['Content-Type'] = ct
    return headers
}

export const get = (url: string, callback: Callback, {isJSON = true} = {}): Promise<any> => {
    return fetch(url, {
        method: "GET",
        headers: setHeader(null),
    }).then((res: Response): void | Promise<void> | Response => {
        switch (res.status) {
            case 200:
                if (isJSON && callback?.succeed) return res.json().then(callback.succeed)
                else if (callback?.succeed) return res.text().then(callback.succeed)
                break

            case 400:
                if (callback?.failed) return res.text().then(callback.failed)

            default:
                console.log(res.status)
                if (callback?.failed) return res.text().then(callback.failed)
        }
        return res
    }).catch(function (err) {
        console.log(err)
        if (callback?.network_error) callback.network_error(err)
        return Promise.reject()
    })
}

export const post = (url: string, data: RequestInit["body"], callback: Callback, {ct = 'application/json', isJSON = true} = {}): Promise<any> => {
    return fetch(url, {
        method: "POST",
        headers: setHeader(ct),
        body: typeof (data) == 'string' ? data : JSON.stringify(data)
    }).then((res: Response): void | Promise<void> | Response => {
        switch (res.status) {
            case 200:
                if (isJSON && callback?.succeed) return res.json().then(callback.succeed)
                else if (callback?.succeed) return res.text().then(callback.succeed)
                break

            case 400:
                if (callback?.failed) return res.text().then(callback.failed)

            default:
                console.log(res.status)
                if (callback?.failed) return res.text().then(callback.failed)
        }
        return res
    }).catch(function (err) {
        console.log(err)
        if (callback?.network_error) callback.network_error(err)
        return Promise.reject()
    })
}

export const put = (url: string, data: RequestInit["body"], callback: Callback, {ct = 'application/json', isJSON = true} = {}) => {
    return fetch(url, {
        method: "PUT",
        headers: setHeader(ct),
        body: typeof (data) == 'string' ? data : JSON.stringify(data)
    }).then((res: Response): void | Promise<void> | Response => {
        switch (res.status) {
            case 200:
                if (isJSON && callback?.succeed) return res.json().then(callback.succeed)
                else if (callback?.succeed) return res.text().then(callback.succeed)
                break

            case 400:
                if (callback?.failed) return res.text().then(callback.failed)

            default:
                console.log(res.status)
                if (callback?.failed) return res.text().then(callback.failed)
        }
        return res
    }).catch(function (err) {
        console.log(err)
        if (callback?.network_error) callback.network_error(err)
        return Promise.reject()
    })
}

export const del = (url: string, data: RequestInit["body"], callback: Callback, {ct = 'application/json', isJSON = true} = {}) => {
    return fetch(url, {
        method: "DELETE",
        headers: setHeader(ct),
        body: typeof (data) == 'string' ? data : JSON.stringify(data)
    }).then((res: Response): void | Promise<void> | Response => {
        switch (res.status) {
            case 200:
                if (isJSON && callback?.succeed) return res.json().then(callback.succeed)
                else if (callback?.succeed) return res.text().then(callback.succeed)
                break

            case 400:
                if (callback?.failed) return res.text().then(callback.failed)

            default:
                console.log(res.status)
                if (callback?.failed) return res.text().then(callback.failed)
        }
        return res
    }).catch(function (err) {
        console.log(err)
        if (callback?.network_error) callback.network_error(err)
        return Promise.reject()
    })
}

export const eventStream = (url: string, method: string, data: RequestInit["body"], callback: Callback, {ct = 'application/json'} = {}) => {
    return fetch(url, {
        method: method,
        headers: setHeader(ct),
        body: JSON.stringify(data)
    }).then((res: Response): void | Promise<void> | Response => {
        switch (res.status) {
            case 200:
                if (res.body) {
                    const reader = res.body.getReader()
                    const decoder = new TextDecoder('utf-8')

                    const processStreamResult = (result) => {
                        const chunk = decoder.decode(result.value, { stream: !result.done })

                        //console.log(chunk)
                        const lines = chunk.split('\n')
                        //console.log(lines)
                        lines.forEach(line => {
                            if (line.trim().length > 0) {
                                let data = line.split('data: ')
                                if (data.length == 2) {
                                    if (data[1] != '[DONE]' && callback?.succeed) callback.succeed(data[1])
                                }
                            }
                        })

                        if (!result.done) {
                            return reader.read().then(processStreamResult)
                        }
                    }

                    return reader.read().then(processStreamResult)
                }
                break

            case 400:
                if (callback?.failed) return res.text().then(callback.failed)

            default:
                console.log(res.status)
                if (callback?.failed) return res.text().then(callback.failed)
        }
        return res
    }).catch(function (err) {
        console.log(err)
        if (callback?.network_error) callback.network_error(err)
        return Promise.reject()
    })
}