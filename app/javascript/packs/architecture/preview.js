showPreview = (event) => {
  const previewContainer = document.getElementById('new-images-preview');
  previewContainer.innerHTML = '';

  const files = Array.from(event.target.files);

  files.forEach((file) => {
    const reader = new FileReader();

    reader.onload = (e) => {
      const previewDiv = document.createElement('div');
      previewDiv.classList.add('mb-4');

      const image = document.createElement('img');
      image.src = e.target.result;
      image.classList.add('block', 'object-cover', 'rounded-md', 'mr-2');

      const removeButton = document.createElement('i');
      removeButton.classList.add('fa-solid', 'fa-circle-xmark', 'fa-2xl', 'remove-image', 'absolute', 'top-2', 'right-0', 'p-4', 'text-third', 'cursor-pointer');
      removeButton.dataset.imageId = file.name;
      removeButton.addEventListener('click', () => {
        removePreviewImage(removeButton);
      });

      previewDiv.appendChild(image);
      previewDiv.appendChild(removeButton);
      previewContainer.appendChild(previewDiv);
    };

    reader.readAsDataURL(file);
  });
}

removePreviewImage = (removeButton) => {
  const imageId = removeButton.dataset.imageId;
  const imageInput = document.querySelector(`input[data-image-id="${imageId}"]`);
  if (imageInput) {
    imageInput.parentNode.removeChild(imageInput);
  }
  removeButton.parentNode.parentNode.removeChild(removeButton.parentNode);
}

document.addEventListener('turbolinks:load', () => {
  const removeButtons = document.querySelectorAll('.remove-image');
  removeButtons.forEach((button) => {
    button.addEventListener('click', () => {
      removePreviewImage(button);
    });
  });
});