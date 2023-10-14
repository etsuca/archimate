document.addEventListener('click', async (e) => {
  if (e.target.classList.contains('more-button')) {
    e.preventDefault();
    const nextPage = e.target.dataset.page;
    const architectureContainer = document.querySelector('.architecture-container');

    try {
      const selectedTagIds = Array.from(document.querySelectorAll('input[name="tag_ids[]"]:checked')).map((checkbox) => checkbox.value);
      const queryParams = new URLSearchParams();

      if (selectedTagIds.length > 0) {
        selectedTagIds.forEach((tagId) => {
          queryParams.append('tag_ids[]', tagId);
        });
      }

      queryParams.append('page', nextPage);

      const currentUrl = new URL(window.location.href);
      const existingParams = currentUrl.searchParams;

      const currentKeyword = existingParams.get('keyword');
      const currentPref = existingParams.get('pref');
      const currentCategory = existingParams.get('category');

      if (currentKeyword) {
        queryParams.set('keyword', currentKeyword);
      }

      if (currentPref) {
        queryParams.set('pref', currentPref);
      }

      if (currentCategory) {
        queryParams.set('category', currentCategory);
      }

      const response = await fetch(`/architecture?${queryParams.toString()}`, {
        method: 'GET',
      });

      if (!response.ok) {
        throw new Error('ネットワークエラーが発生しました。');
      }

      const data = await response.text();
      const newDiv = document.createElement('div');
      newDiv.innerHTML = data;

      // 新しい建築情報のみを追加
      const newArchitecture = newDiv.querySelectorAll('.architecture-container');

      newArchitecture.forEach((architecture) => {
        architecture.classList.add('added-by-pagination');
        architectureContainer.appendChild(architecture);
      });

      // もっとみるボタンを更新
      const moreButton = document.createElement('a');
      moreButton.href = `/architecture?${queryParams.toString()}`;

      // 既存のもっとみるボタンを置き換える
      const oldMoreButton = document.querySelector('.more-button');
      oldMoreButton.replaceWith(moreButton);
      
      const eachArchitecture = document.querySelectorAll('.group');
      const exisistingArchitectureCount = eachArchitecture.length;
      console.log(exisistingArchitectureCount);

      // 現在表示しているページが最後の場合、ページネーションを非表示にする
      if (exisistingArchitectureCount % 10 != 0) {
        const paginationContainer = document.querySelector('.more-button');
        paginationContainer.innerHTML = '';
      }

    } catch (error) {
      console.error('Fetch error:', error);
    }
  }
});
