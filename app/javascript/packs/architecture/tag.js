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

      form.submit();
    });
  });

  // ページロード時に選択されたタグIDをクエリパラメータから取得し、チェックボックスを選択状態にする
  const urlParams = new URLSearchParams(window.location.search);
  const selectedTagIds = urlParams.getAll('tag_ids[]');
  const tagCheckboxes = document.querySelectorAll('input[name="tag_ids[]"]');

  tagCheckboxes.forEach((checkbox) => {
    const tagId = checkbox.value;
    checkbox.checked = selectedTagIds.includes(tagId);

    if (checkbox.checked) {
      const button = checkbox.nextElementSibling;
      button.classList.remove('text-gray-600');
      button.classList.add('bg-fifth', 'text-white');
    }
  });
});
