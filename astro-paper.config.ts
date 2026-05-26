import { defineAstroPaperConfig } from "./src/types/config";

export default defineAstroPaperConfig({
  site: {
    url: "https://bornnotknowing.com/",
    title: "Born Not Knowing",
    description:
      "A public notebook on engineering, English, markets, music, projects, and clearer thinking.",
    author: "Cruise Cao",
    profile: "https://x.com/cruisecao33",
    ogImage: "default-og.jpg",
    lang: "en",
    timezone: "Asia/Singapore",
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
    },
    search: "pagefind",
  },
  socials: [
    {
      name: "x",
      url: "https://x.com/cruisecao33",
      linkTitle: "Cruise Cao on X",
    },
  ],
  shareLinks: [
    { name: "whatsapp", url: "https://wa.me/?text=" },
    { name: "facebook", url: "https://www.facebook.com/sharer.php?u=" },
    { name: "x",        url: "https://x.com/intent/post?url=" },
    { name: "telegram", url: "https://t.me/share/url?url=" },
    { name: "pinterest", url: "https://pinterest.com/pin/create/button/?url=" },
    { name: "mail",     url: "mailto:?subject=See%20this%20post&body=" },
  ],
});
