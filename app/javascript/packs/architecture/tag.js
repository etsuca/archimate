document.addEventListener('turbolinks:load', () => {
  const tagButtons = document.querySelectorAll('.tag-button');
  const gridElement = document.querySelector('.grid');
  const paginationContainer = document.querySelector('.pagination'); // ページネーションを表示するコンテナ

  tagButtons.forEach((button) => {
    button.addEventListener('click', () => {
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

      // 現在のクエリパラメータからkeyword, pref, categoryを取得
      const currentKeyword = existingParams.get('keyword');
      const currentPref = existingParams.get('pref');
      const currentCategory = existingParams.get('category');

      // 新しいクエリパラメータを作成
      const newParams = new URLSearchParams();
      newParams.set('keyword', currentKeyword || ''); // keywordを追加、存在しなければ空文字列
      newParams.set('pref', currentPref || ''); // prefを追加、存在しなければ空文字列
      newParams.set('category', currentCategory || ''); // categoryを追加、存在しなければ空文字列

      if (selectedTagIds.length > 0) {
        selectedTagIds.forEach((tagId) => {
          newParams.append('tag_ids[]', tagId);
        });
      }

      const queryParams = newParams.toString();

      // リクエストを送信
      fetch(`/architecture?${queryParams}`, {
        method: 'GET',
      })
      .then((response) => response.text())
      .then((data) => {
        const resultContainer = document.createElement('div');
        resultContainer.innerHTML = data;
        const newResults = resultContainer.querySelector('.grid');
        const newPagination = resultContainer.querySelector('.pagination'); // 新しいページネーション

        gridElement.innerHTML = newResults.innerHTML;

        if (newPagination) {
          paginationContainer.innerHTML = newPagination.innerHTML;
        } else {
          // 新しいページネーションが存在しない場合はクリア
          paginationContainer.innerHTML = '';
        }
        
        // タグを選択または選択解除した後、クエリパラメータにpageが存在する場合はpageを削除
        const currentUrl = new URL(window.location.href);
        const existingParams = currentUrl.searchParams;
        if (existingParams.has('page')) {
          existingParams.delete('page');
          history.replaceState(null, null, `?${existingParams.toString()}`);
        }
      })
      .catch((error) => {
        console.error('Ajaxリクエストエラー:', error);
      });
    });
  });

  const saveSelectedTagsToLocalStorage = () => {
    const selectedTagIds = Array.from(document.querySelectorAll('input[name="tag_ids[]"]:checked')).map((checkbox) => checkbox.value);
    // キャッシュに選択されたタグ情報を保存
    localStorage.setItem('selectedTags', JSON.stringify(selectedTagIds));
  }
});
