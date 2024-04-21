export const toDateTimeString = (str) => {
    try {
        const date = new Date(str)
        if (isNaN(date.getTime())) {
            return ""
        }
        return date.toLocaleDateString() + " " + date.toLocaleTimeString()
    } catch (e) {
        return ""
    }
}

export const fromNow = (str) => {
    try {
        const date = new Date(str)
        if (isNaN(date.getTime())) {
            return ""
        }

        const now = new Date()
        const diff = now - date

        if (diff < 1000 * 60) {
            return "Just now"
        } else if (diff < 1000 * 60 * 60) {
            return Math.floor(diff / (1000 * 60)) + " minutes ago"
        } else if (diff < 1000 * 60 * 60 * 24) {
            return Math.floor(diff / (1000 * 60 * 60)) + " hours ago"
        }
        const days = Math.floor(diff / (1000 * 60 * 60 * 24))
        if (days < 30) {
            return days + " days ago"
        }
        const months = Math.floor(days / 30)
        if (months < 12) {
            return months + " months ago"
        }
        const years = Math.floor(months / 12)
        return years + " years ago"
    } catch (e) {
        return ""
    }
}

export default {
    toDateTimeString,
    fromNow,
}
