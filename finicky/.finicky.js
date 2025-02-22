// ~/.finicky.js

module.exports = {
  defaultBrowser: "Zen Browser",
  rewrite: [
    {
      // Redirect all urls to use https
      match: ({ url }) => url.protocol === "http",
      url: { protocol: "https" },
    },
  ],
  handlers: [
    {
      // Open apple.com and example.com urls in Safari
      match: finicky.matchHostnames(["apple.com", "icloud.com"]),
      browser: "Safari",
    },
    // {
    //   // Open any url that includes the string "workplace" in Firefox
    //   match: /workplace/,
    //   browser: "Firefox"
    // },
    {
      // Open google.com and *.google.com urls in Google Chrome
      match: [
        "meet.google.com/*", // match google.com urls
        // "*.google.com/*", // match google.com subdomains
      ],
      browser: "Google Chrome",
    },
  ],
};
