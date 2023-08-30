document.addEventListener('turbolinks:load', () => {
  const preview = document.getElementById('preview');
  const imageTag = document.getElementById('image-tag');
  const fileField = document.querySelector('input[type="file"]');

  preview.addEventListener('click', () => {
    fileField.click();
  });

  fileField.addEventListener('change', () => {
    const file = fileField.files[0];
    const reader = new FileReader();

    reader.onload = () => {
      imageTag.src = reader.result;
    };

    reader.readAsDataURL(file);
  });
});