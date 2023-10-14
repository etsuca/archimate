document.addEventListener('turbolinks:load', () => {
  const tagButtons = document.querySelectorAll('.tag-button');
  const gridElement = document.querySelector('.grid');
  const paginationContainer = document.querySelector('.pagination');

  tagButtons.forEach((button) => {
    button.addEventListener('click', () => {
      const addedByPaginationContainer = document.querySelector('.added-by-pagination');
      if (addedByPaginationContainer) {
        addedByPaginationContainer.remove();
      }

      const checkbox = button.previousElementSibling;
      checkbox.checked = !checkbox.checked;
      saveSelectedTagsToLocalStorage();
      if (checkbox.checked) {
        button.classList.remove('text-gray-600');
        button.classList.add('bg-fifth', 'text-white');
      } else {
        button.classList.remove('bg-fifth', 'text-white');
        button.classList.add('text-gray-600');
      }

      const selectedTagIds = Array.from(document.querySelectorAll('input[name="tag_ids[]"]:checked')).map((checkbox) => checkbox.value);

      const currentUrl = new URL(window.location.href);
      const existingParams = currentUrl.searchParams;

      const currentKeyword = existingParams.get('keyword');
      const currentPref = existingParams.get('pref');
      const currentCategory = existingParams.get('category');

      const newParams = new URLSearchParams();
      newParams.set('keyword', currentKeyword || '');
      newParams.set('pref', currentPref || '');
      newParams.set('category', currentCategory || '');

      if (selectedTagIds.length > 0) {
        selectedTagIds.forEach((tagId) => {
          newParams.append('tag_ids[]', tagId);
        });
      }

      const queryParams = newParams.toString();

      fetch(`/architecture?${queryParams}`, {
        method: 'GET',
      })
      .then((response) => response.text())
      .then((data) => {
        const resultContainer = document.createElement('div');
        resultContainer.innerHTML = data;

        const newResults = resultContainer.querySelector('.grid');
        const newPagination = resultContainer.querySelector('.pagination');

        if (gridElement) {
          if (newResults) {
            gridElement.innerHTML = newResults.innerHTML;
          } else {
            gridElement.innerHTML = '<p>条件に当てはまる建築がありません。</p>';
          }
        }

        if (newPagination) {
          paginationContainer.innerHTML = newPagination.innerHTML;
        } else {
          paginationContainer.innerHTML = '';
        }
      })
      .catch((error) => {
        console.error('Ajaxリクエストエラー:', error);
      });
    });
  });

  const saveSelectedTagsToLocalStorage = () => {
    const selectedTagIds = Array.from(document.querySelectorAll('input[name="tag_ids[]"]:checked')).map((checkbox) => checkbox.value);
    localStorage.setItem('selectedTags', JSON.stringify(selectedTagIds));
  }
});
