document.addEventListener('turbolinks:load', () => {
  initializeArchitecture();
});

const initializeArchitecture = () => {
  const architectureContainers = document.querySelectorAll('[id^="matched_architecture_"]');

  architectureContainers.forEach((container) => {
    const imagesInput = container.querySelector('.images');
    const architectureImages = JSON.parse(imagesInput.value);
    const image = container.querySelector('.image');
    const progressBar = container.querySelector('.progress-bar');
    const arrowLeft = container.querySelector('.fa-chevron-left');
    const arrowRight = container.querySelector('.fa-chevron-right');
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

    arrowLeft.addEventListener('click', () => {
      currentIndex = (currentIndex - 1 + architectureImages.length) % architectureImages.length;
      updateImage();
      updateProgressBar();
    });

    arrowRight.addEventListener('click', () => {
      currentIndex = (currentIndex + 1) % architectureImages.length;
      updateImage();
      updateProgressBar();
    });

    image.addEventListener('click', (event) => {
      const clickedX = event.clientX - event.target.getBoundingClientRect().left;
      const halfWidth = event.target.clientWidth / 2;

      if (clickedX >= halfWidth) {
        currentIndex = (currentIndex + 1) % architectureImages.length;
      } else {
        currentIndex = (currentIndex - 1 + architectureImages.length) % architectureImages.length;
      }

      if (architectureImages.length >= 2) {
        updateImage();
        updateProgressBar();
      }
    });
  });
};
