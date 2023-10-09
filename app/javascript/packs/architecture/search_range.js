document.addEventListener('turbolinks:load', () => {
  // ラジオボタンの要素を取得
  const visitedRadio = document.getElementById('visited-radio');
  const othersRadio = document.getElementById('others-radio');
  const likedRadio = document.getElementById('liked-radio');

  // ラベル要素を取得
  const visitedLabel = document.getElementById('visited-label');
  const othersLabel = document.getElementById('others-label');
  const likedLabel = document.getElementById('liked-label');

  // 選択されたカテゴリに応じてラジオボタンの選択状態を設定
  const urlParams = new URLSearchParams(window.location.search);
  const currentCategory = urlParams.get('category');
  const form = document.querySelector('form');

  if (visitedRadio || othersRadio || likedRadio) {
    visitedRadio.checked = currentCategory === 'visited_architecture';
    othersRadio.checked = currentCategory === 'others_architecture';
    likedRadio.checked = currentCategory === 'liked_architecture';

    // 選択されたラジオボタンのラベルにクラスを追加/削除
    const updateLabelClasses = () => {
      
      if (visitedRadio.checked) {
        visitedLabel.classList.remove('border-gray-400', 'text-gray-400');
        visitedLabel.classList.add('border-first', 'text-first');
      } else if (othersRadio.checked) {
        othersLabel.classList.remove('border-gray-400', 'text-gray-400');
        othersLabel.classList.add('border-first', 'text-first');
      } else if (likedRadio.checked) {
        likedLabel.classList.remove('border-gray-400', 'text-gray-400');
        likedLabel.classList.add('border-first', 'text-first');
      }
    };

    visitedRadio.addEventListener('change', () => {
      if (visitedRadio.checked) {
        updateQueryParam('category', 'visited_architecture');
        form.submit();
        updateLabelClasses(); // ラベルのクラスを更新
      }
    });

    othersRadio.addEventListener('change', () => {
      if (othersRadio.checked) {
        updateQueryParam('category', 'others_architecture');
        form.submit();
        updateLabelClasses(); // ラベルのクラスを更新
      }
    });

    likedRadio.addEventListener('change', () => {
      if (likedRadio.checked) {
        updateQueryParam('category', 'liked_architecture');
        form.submit();
        updateLabelClasses(); // ラベルのクラスを更新
      }
    });

    // ページロード時にラベルのクラスを設定
    if (!currentCategory) {
      visitedLabel.classList.remove('border-gray-400', 'text-gray-400');
      visitedLabel.classList.add('border-first', 'text-first');
    } else {
      updateLabelClasses();
    }
  }
});

// クエリパラメータを更新する関数
const updateQueryParam = (paramName, paramValue) => {
  const newUrlParams = new URLSearchParams(window.location.search);
  if (Array.isArray(paramValue)) {
    newUrlParams.delete(paramName); // 既存の同名パラメータを削除
    paramValue.forEach((value) => {
      newUrlParams.append(paramName, value); // 配列の要素を追加
    });
  } else {
    newUrlParams.set(paramName, paramValue); // パラメータを設定
  }
  // ページの URL を更新
  history.replaceState(null, null, `?${newUrlParams.toString()}`);
}
