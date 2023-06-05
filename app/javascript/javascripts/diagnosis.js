document.addEventListener('turbolinks:load', () => {
  const buttonOpen = document.getElementById('modalOpen');
  const modal = document.getElementById('easyModal');

  buttonOpen.addEventListener('click', () => {
    modal.classList.toggle('hidden');
  });

  addEventListener('click', (e) => {
    if (e.target == modal) {
      modal.classList.toggle('hidden');
    }
  });
});