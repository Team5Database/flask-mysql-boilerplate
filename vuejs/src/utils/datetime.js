export const toDateTimeString = (str) => {
    const date = new Date(str)
    return date.toLocaleDateString() + " " + date.toLocaleTimeString()
}

export default {
    toDateTimeString
}
