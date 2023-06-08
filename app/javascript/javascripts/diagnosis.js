document.addEventListener('turbolinks:load', () => {
  const buttonsOpen = document.querySelectorAll('#modalOpen');
  const modals = document.querySelectorAll('#easyModal');

  for (let i = 0; i < buttonsOpen.length; i++) {
    const buttonOpen = buttonsOpen[i];
    const modal = modals[i];

    buttonOpen.addEventListener('click', () => {
      modals[modals.length - 1].classList.toggle('hidden');
    });

    addEventListener('click', (e) => {
      if (e.target == modal) {
        modals[modals.length - 1].classList.toggle('hidden');
      }
    });
  }
});