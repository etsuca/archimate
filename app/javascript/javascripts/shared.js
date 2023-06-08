document.addEventListener('turbolinks:load', () => {
  const button = document.querySelector('#button');

  button.addEventListener('click', event => {
    bars.classList.toggle('hidden');
    xmark.classList.toggle('hidden');
    menu.classList.toggle('translate-x-full');
  })
})

document.addEventListener("turbolinks:load", () => {
  const toggleBtns = document.querySelectorAll('.toggle-btn');
  const descriptions = document.querySelectorAll('.description');
  const closeBtns = document.querySelectorAll('.close-btn');

  for (let i = 0; i < toggleBtns.length; i++) {
    const currentToggleBtn = toggleBtns[i];
    const currentDescription = descriptions[i];
    const currentCloseBtn = closeBtns[i];

    currentToggleBtn.addEventListener('click', () => {
      currentDescription.classList.toggle('hidden');
      currentToggleBtn.classList.toggle('hidden');
    });

    currentCloseBtn.addEventListener('click', () => {
      currentDescription.classList.add('hidden');
      currentToggleBtn.classList.remove('hidden');
    });
  }
});