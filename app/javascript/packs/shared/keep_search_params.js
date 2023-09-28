document.addEventListener('turbolinks:load', () => {
  // クエリパラメータから選択されたタグIDを取得し、対応するチェックボックスをチェック状態にする
  const urlParams = new URLSearchParams(window.location.search);
  const selectedTagIds = urlParams.getAll('tag_ids[]');
  const tagCheckboxes = document.querySelectorAll('input[type="checkbox"][name="tag_ids[]"]');

  tagCheckboxes.forEach(checkbox => {
    const tagId = checkbox.value;
    const isChecked = selectedTagIds.includes(tagId);
    checkbox.checked = isChecked;

    checkbox.addEventListener('change', () => {
      const selectedTags = Array.from(tagCheckboxes)
        .filter(checkbox => checkbox.checked)
        .map(checkbox => checkbox.value);
      updateQueryParam('tag_ids[]', selectedTags);
    });
  });

  // フリーワード検索欄の入力状態を保持・復元
  const searchField = document.getElementById('search-field');
  const initialSearchFieldValue = searchField ? searchField.value : '';
  if (searchField) {
    const storedSearchFieldValue = getStoredQueryParam('keyword', initialSearchFieldValue);
    searchField.value = storedSearchFieldValue;

    searchField.addEventListener('input', () => {
      const searchFieldValue = searchField.value;
      updateQueryParam('keyword', searchFieldValue);
    });

    searchField.addEventListener('change', () => {
      const searchFieldValue = searchField.value;
      if (!searchFieldValue) {
        removeQueryParam('keyword');
      }
    });
  }

  // 都道府県セレクトボックスの入力状態を保持・復元
  const prefSelect = document.getElementById('pref-select');
  const initialPrefSelectValue = prefSelect ? prefSelect.value : '';
  if (prefSelect) {
    const storedPrefSelectValue = getStoredQueryParam('pref', initialPrefSelectValue);
    prefSelect.value = storedPrefSelectValue;

    prefSelect.addEventListener('change', () => {
      const prefSelectValue = prefSelect.value;
      updateQueryParam('pref', prefSelectValue);
    });

    prefSelect.addEventListener('change', () => {
      const prefSelectValue = prefSelect.value;
      if (!prefSelectValue) {
        removeQueryParam('pref');
      }
    });
  }

  // ラジオボタンの要素を取得
  const visitedRadio = document.getElementById('visited-radio');
  const othersRadio = document.getElementById('others-radio');
  const likedRadio = document.getElementById('liked-radio');

  // 選択されたカテゴリに応じてラジオボタンの選択状態を設定
  if (visitedRadio || othersRadio || likedRadio) {
    const selectedCategory = urlParams.get('category');
    const form = document.querySelector('form');
    visitedRadio.checked = selectedCategory === 'visited_architecture';
    othersRadio.checked = selectedCategory === 'others_architecture';
    likedRadio.checked = selectedCategory === 'liked_architecture';

    visitedRadio.addEventListener('change', () => {
      if (visitedRadio.checked) {
        updateQueryParam('category', 'visited_architecture');
        form.submit();
      }
    });

    othersRadio.addEventListener('change', () => {
      if (othersRadio.checked) {
        updateQueryParam('category', 'others_architecture');
        form.submit();
      }
    });

    likedRadio.addEventListener('change', () => {
      if (likedRadio.checked) {
        updateQueryParam('category', 'liked_architecture');
        form.submit();
      }
    });
  }

  // クエリパラメータを更新する関数
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

  // クエリパラメータを削除する関数
  function removeQueryParam(paramName) {
    const newUrlParams = new URLSearchParams(window.location.search);
    newUrlParams.delete(paramName);
    // ページの URL を更新
    history.replaceState(null, null, `?${newUrlParams.toString()}`);
  }

  // クエリパラメータを取得し、指定したパラメータ名の値を返す関数
  function getStoredQueryParam(paramName, defaultValue) {
    const urlParams = new URLSearchParams(window.location.search);
    const storedValue = urlParams.get(paramName);
    return storedValue !== null ? storedValue : defaultValue;
  }

  const currentPageURL = window.location.pathname;
  if (currentPageURL === '/architecture') {
    const defaultCategory = 'visited_architecture';
    const currentCategory = urlParams.get('category');
    if (!currentCategory) {
      visitedRadio.checked = true;
    }
  }
});
