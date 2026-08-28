import { defineAstroPaperConfig } from "./src/types/config";

export default defineAstroPaperConfig({
  site: {
    url: "https://www.sinanmohd.com/",
    title: "Sinan Mohd",
    description: "Personal blog of a Real Human Being",
    author: "Sinan Mohd",
    profile: "https://www.sinanmohd.com/",
    ogImage: "default-og.jpg",
    lang: "en",
    timezone: "IST",
    dir: "ltr",
  },
  posts: {
    perPage: 4,
    perIndex: 4,
    scheduledPostMargin: 15 * 60 * 1000,
  },
  features: {
    lightAndDarkMode: true,
    dynamicOgImage: true,
    showArchives: true,
    showBackButton: true,
    editPost: {
      enabled: false,
      // url: "https://github.com/sinanmohd/website/edit/master/",
    },
    search: "pagefind",
  },
  socials: [
    { name: "matrix", url: "https://matrix.to/#/@sinan:sinanmohd.com" },
    { name: "mail", url: "mailto:sinan@sinanmohd.com" },
    { name: "linkedin", url: "https://www.linkedin.com/in/sinanmohd/" },
    { name: "github", url: "https://github.com/sinanmohd" },
  ],
  shareLinks: [
    { name: "ycombinator", url: "https://news.ycombinator.com/submitlink?u=" },
    { name: "mastodon", url: "https://mastodonshare.com/?text=" },
    { name: "bsky", url: "https://bsky.app/intent/compose?text=" },
    { name: "threads", url: "https://www.threads.net/intent/post?text=" },
    // { name: "whatsapp", url: "https://wa.me/?text=" },
    // { name: "facebook", url: "https://www.facebook.com/sharer.php?u=" },
    // { name: "pinterest", url: "https://pinterest.com/pin/create/button/?url=" },
    // { name: "mail", url: "mailto:?subject=See%20this%20post&body=" },
    { name: "x", url: "https://x.com/intent/post?url=" },
    { name: "telegram", url: "https://t.me/share/url?url=" },
  ],
});
