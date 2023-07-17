const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      colors: {
        first: "#1d1d1f",
        second: "#f4e464",
        third: "#f3f4f6",
        fourth: "#b2b2b2",
        fifth: "#0E3068",
        sixth: "#A6F147",
        seventh: "#C96040",
        eighth: '#1D9BF0',
        legend_1: '#F3E766',
        legend_2: '#F4AA19',
        legend_3: '#BC6548',
        legend_4: '#0E3068'
      },
      fontFamily: {
        open_sans: ["Open Sans", "sans-serif"],
      },
      width: {
        '128': '32rem',
        '144': '36rem',
        '160': '40rem',
      },
      height: {
        '128': '32rem',
      },
      lineHeight: {
        '16': '4rem',
      },
      animation: {
        "scale-in-hor-left": "scale-in-hor-left 0.4s cubic-bezier(0.250, 0.460, 0.450, 0.940)   both"
      },
      keyframes: {
        "scale-in-hor-left": {
          "0%": {
            transform: "scaleX(0)",
            "transform-origin": "0% 0%",
            opacity: "1"
          },
          to: {
            transform: "scaleX(1)",
            "transform-origin": "0% 0%",
            opacity: "1"
          }
        },
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ],
  important: true,
}
