export default {
  plugins: [
    {
      name: "preset-default",
      params: {
        overrides: {
          inlineStyles: {
            onlyMatchedOnce: false,
            removeMatchedSelectors: true,
          },
        },
      },
    },
    "convertStyleToAttrs",
    "prefixIds",
  ],
};
