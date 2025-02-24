import typography from "@tailwindcss/typography";
import defaultTheme from "tailwindcss/defaultTheme";
const colors = require('tailwindcss/colors');

/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./Sources/Mhoush/templates/*.swift", "./content/articles/*.md"],
  theme: {
    container: {
      center: true,
      padding: {
        DEFAULT: "0",
      },
    },
    screens: {
      sm: "315px",
      lg: "800px",
    },
    colors: {
      inherit: "inherit",
      transparent: "transparent",
      white: "#f1f5f9",
      orange: "#F5A87F",
      red: colors.red,
      blue: "#B4BEFE",
      green: "#A6E3A1",
      page: "#1E1E2E",
      nav: "#0e1112",
      sub: "#252f3f",
      light: "#64748b",
      gray: "#93a3b8",
      pink: "#EE72F1",
    },
    extend: {
      colors: {
        sky: colors.sky,
        blue: colors.blue
      },
      fontFamily: {
        avenir: ["Avenir", ...defaultTheme.fontFamily.sans],
        anonymous: ["Anonymous Pro", ...defaultTheme.fontFamily.mono],
      },
      typography: theme => ({
        DEFAULT: {
          css: {
            maxWidth: "100%",
            "--tw-prose-body": theme("colors.white"),
            "--tw-prose-headings": theme("colors.white"),
            "--tw-prose-code": theme("colors.white"),
            "--tw-prose-pre-bg": theme("colors.sub"),
            "--tw-prose-hr": theme("colors.light"),
            "--tw-prose-bullets": theme("colors.gray"),
            "--tw-prose-counters": theme("colors.gray"),
            "--tw-prose-quotes": theme("colors.gray"),
            "--tw-prose-quote-borders": theme("colors.gray"),
            a: {
              color: theme("colors.green"),
              textDecoration: "none",
              fontWeight: "400",
            },
            strong: {
              color: theme("colors.white"),
              fontWeight: "800",
            },
            pre: {
              fontSize: "1rem",
              lineHeight: "1.5rem",
            },
          },
        },
      }),
    },
  },
  corePlugins: {
    contain: false,
    ringWidth: false,
    backdropFilter: false,
    transform: false,
    filter: false,
    backgroundOpacity: false,
    textOpacity: false,
  },
  plugins: [
    typography({ target: "legacy" }),

    function ({ addBase, theme }) {
      function extractColorVars(colorObj, colorGroup = "") {
        return Object.keys(colorObj).reduce((vars, colorKey) => {
          const value = colorObj[colorKey];

          const newVars =
            typeof value === "string"
              ? { [`--color${colorGroup}-${colorKey}`]: value }
              : extractColorVars(value, `-${colorKey}`);

          return { ...vars, ...newVars };
        }, {});
      }

      addBase({
        ":root": extractColorVars(theme("colors")),
      });
    },
  ],
};
