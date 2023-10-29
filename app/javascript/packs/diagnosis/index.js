document.addEventListener('turbolinks:load', () => {
  const showImage = (entries) => {
    const keyframes = {
      opacity: [0, 1],
      translate: ['0 100px', 0],
    };

    const options = {
      duration: 700,
    }

    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.animate(keyframes, options);
      }
    });
  };

  const imageObserver = new IntersectionObserver(showImage);
  const images = document.querySelectorAll('.architecture-images');

  images.forEach(image => {
    imageObserver.observe(image);
  });
});
