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
        theme: "#2c2c2c",
        second: "#f4e464",
        third: "#f3f4f6",
        fourth: "#b2b2b2",
        fifth: "#0E3068",
        sixth: "#A6F147",
        seventh: "#C96040"
      },
      fontFamily: {
        open_sans: ["Open Sans", "sans-serif"],
      },
      width: {
        '128': '32rem',
        '144': '36rem',
        '160': '40rem',
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
