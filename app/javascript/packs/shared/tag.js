document.addEventListener('turbolinks:load', () => {
  const tagButtons = document.querySelectorAll('.tag-button');

  tagButtons.forEach((button) => {
    button.addEventListener('click', () => {
      const checkbox = button.previousElementSibling;

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

function updateQueryParam(paramName, paramValue) {
  const newUrlParams = new URLSearchParams(window.location.search);
  if (Array.isArray(paramValue)) {
    newUrlParams.delete(paramName); // 既存の同名パラメータを削除
    paramValue.forEach(value => {
      newUrlParams.append(paramName, value); // 配列の要素を追加
    });
  } else {
    newUrlParams.set(paramName, paramValue); // パラメータを設定
  }
  // ページの URL を更新
  history.replaceState(null, null, `?${newUrlParams.toString()}`);
}
