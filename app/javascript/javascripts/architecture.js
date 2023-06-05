document.addEventListener("turbolinks:load", () => {
  initializeArchitecture();
});

const initializeArchitecture = () => {
  const toggleBtn = document.querySelector('.toggle-btn');
  const description = document.querySelector('.description');
  const closeBtn = document.querySelector('.close-btn');
  
  const toggleDescription = () => {
    description.classList.toggle('hidden');
    toggleBtn.classList.toggle('hidden');
  }

  const hideDescription = () => {
    description.classList.add('hidden');
    toggleBtn.classList.remove('hidden');
  }

  toggleBtn.addEventListener('click', toggleDescription);
  closeBtn.addEventListener('click', hideDescription);
}