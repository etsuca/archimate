document.addEventListener('turbolinks:load', () => {
  const tagButtons = document.querySelectorAll('.tag-button');

  tagButtons.forEach((button) => {
    button.addEventListener('click', () => {
      const checkbox = button.previousElementSibling;
      const form = document.querySelector('form');

      checkbox.checked = !checkbox.checked;

      if (checkbox.checked) {
        button.classList.remove('text-gray-600');
        button.classList.add('bg-fifth', 'text-white');
      } else {
        button.classList.remove('bg-fifth', 'text-white');
        button.classList.add('text-gray-600');
      }

      const selectedTagIds = Array.from(document.querySelectorAll('input[name="tag_ids[]"]:checked'))
        .map((checkbox) => checkbox.value);

      updateQueryParam('tag_ids[]', selectedTagIds);
      form.submit();
    });
  });


});
