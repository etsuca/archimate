document.addEventListener('turbolinks:load', () => {
  initializeArchitecture();
});

const initializeArchitecture = () => {
  let images = $('.images').val();
  let architectureImages = JSON.parse(images);
  const image = document.querySelector(".image");
  const progressBar = document.querySelector(".progress-bar");
  const arrowLeft = document.querySelector(".fa-chevron-left");
  const arrowRight = document.querySelector(".fa-chevron-right");
  let currentIndex = 0;

  const updateProgressBar = () => {
    const progressBarWidth = (currentIndex + 1) * (100 / architectureImages.length);
    progressBar.style.width = `${progressBarWidth}%`;
  };

  const updateImage = () => {
    image.src = architectureImages[currentIndex];
  };

  updateProgressBar();
  updateImage();

  arrowLeft.addEventListener("click", () => {
    currentIndex = (currentIndex - 1 + architectureImages.length) % architectureImages.length;
    updateImage();
    updateProgressBar();
  });

  arrowRight.addEventListener("click", () => {
    currentIndex = (currentIndex + 1) % architectureImages.length;
    updateImage();
    updateProgressBar();
  });

  // Add the event listener to the image for click on the left or right half of the image
  image.addEventListener('click', (event) => {
    const clickedX = event.clientX - event.target.getBoundingClientRect().left;
    const halfWidth = event.target.clientWidth / 2;

    if (clickedX >= halfWidth) {
      currentIndex = (currentIndex + 1) % architectureImages.length;
    } else {
      currentIndex = (currentIndex - 1 + architectureImages.length) % architectureImages.length;
    }

    updateImage();
    updateProgressBar();
  });
};
