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
        "selected-text": "#6e5777",
        theme: "#131335",
        secondary: "#e3ddc3",
        badge: "#d1b5ce",
        inputBorder: "#d0c3a4",
        input: "#2A2A33"
      },
      fontFamily: {
        open_sans: ["Open Sans", "sans-serif"],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
