document.addEventListener('turbolinks:load', () => {
  initializeArchitecture();
});

const initializeArchitecture = () => {
  let images = $('.images').val();
  let architectureImages = JSON.parse(images);
  const image = document.querySelector(".image");
  const progressBar = document.querySelector(".progress-bar");
  let currentIndex = 0;

  const updateProgressBar = () => {
    const progressBarWidth = (currentIndex + 1) * (100 / architectureImages.length);
    progressBar.style.width = `${progressBarWidth}%`;
  }

  updateProgressBar();

  image.addEventListener("click", (event) => {
    const clickedX = event.clientX - event.target.getBoundingClientRect().left;
    const halfWidth = event.target.clientWidth / 2;

    if (clickedX >= halfWidth) {
      currentIndex = (currentIndex + 1) % architectureImages.length;
    } else {
      currentIndex = (currentIndex - 1 + architectureImages.length) % architectureImages.length;
    }
    if (architectureImages.length >= 2) {
      image.src = architectureImages[currentIndex];
    }
    updateProgressBar();
  });
}