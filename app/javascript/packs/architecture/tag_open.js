document.addEventListener('turbolinks:load', () => {
  const saveTagListState = () => {
    const tagList = document.querySelector('.tag-list');
    const isHidden = tagList.classList.contains('hidden');
    
    document.cookie = `tagListHidden=${isHidden ? '1' : '0'}; expires=Thu, 01 Jan 2030 00:00:00 UTC; path=/`;
  }

  const restoreTagListState = () => {
    const tagList = document.querySelector('.tag-list');
    const tagListHidden = getCookie('tagListHidden');
    const openIcon = document.querySelector('#open-icon');
    const closeIcon = document.querySelector('#close-icon');

    if (tagListHidden === '1') {
      tagList.classList.add('hidden');
      openIcon.classList.remove('hidden');
      closeIcon.classList.add('hidden');
    } else {
      tagList.classList.remove('hidden');
      openIcon.classList.add('hidden');
      closeIcon.classList.remove('hidden');
    }
  }

  const getCookie = (name) => {
    const value = `; ${document.cookie}`;
    const parts = value.split(`; ${name}=`);
    if (parts.length === 2) {
      return parts.pop().split(';').shift();
    }
    return null;
  }

  const toggleTagList = () => {
    const tagList = document.querySelector('.tag-list');
    const openIcon = document.querySelector('#open-icon');
    const closeIcon = document.querySelector('#close-icon');

    tagList.classList.toggle('hidden');
    openIcon.classList.toggle('hidden');
    closeIcon.classList.toggle('hidden');
    saveTagListState();
  }

  const openButton = document.querySelector('#open-button');
  openButton.addEventListener('click', toggleTagList);

  const form = document.querySelector('#search-form');
  form.addEventListener('submit', () => {
    saveTagListState();
  });

  restoreTagListState();
});
