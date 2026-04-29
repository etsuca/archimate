document.addEventListener('turbolinks:load', () => {
  initializeBuilding();
});

const initializeBuilding = () => {
  const buildingContainers = document.querySelectorAll('[id^="matched_building_"]');

  buildingContainers.forEach((container) => {
    const imagesInput = container.querySelector('.images');
    const buildingImages = JSON.parse(imagesInput.value);
    const image = container.querySelector('.image');
    const progressBar = container.querySelector('.progress-bar');
    const arrowLeft = container.querySelector('.fa-chevron-left');
    const arrowRight = container.querySelector('.fa-chevron-right');
    let currentIndex = 0;

    const updateProgressBar = () => {
      const progressBarWidth = (currentIndex + 1) * (100 / buildingImages.length);
      progressBar.style.width = `${progressBarWidth}%`;
    };

    const updateImage = () => {
      image.src = buildingImages[currentIndex];
    };

    updateProgressBar();
    updateImage();

    arrowLeft.addEventListener('click', () => {
      currentIndex = (currentIndex - 1 + buildingImages.length) % buildingImages.length;
      updateImage();
      updateProgressBar();
    });

    arrowRight.addEventListener('click', () => {
      currentIndex = (currentIndex + 1) % buildingImages.length;
      updateImage();
      updateProgressBar();
    });

    image.addEventListener('click', (event) => {
      const clickedX = event.clientX - event.target.getBoundingClientRect().left;
      const halfWidth = event.target.clientWidth / 2;

      if (clickedX >= halfWidth) {
        currentIndex = (currentIndex + 1) % buildingImages.length;
      } else {
        currentIndex = (currentIndex - 1 + buildingImages.length) % buildingImages.length;
      }

      if (buildingImages.length >= 2) {
        updateImage();
        updateProgressBar();
      }
    });
  });
};
