storeTagIdAndShowNext = (questionIndex) => {
  const checkbox = document.getElementById(`checkbox${questionIndex}`);
  checkbox.checked = true;
  showNextQuestion(questionIndex);
}

reverseButton = (questionIndex) => {
  const checkbox = document.getElementById(`checkbox${questionIndex - 1}`);
  checkbox.checked = false;
  showBeforeQuestion(questionIndex);
}

showNextQuestion = (currentQuestionIndex) => {
  const currentQuestionContainer = document.getElementById(`question-container-${currentQuestionIndex}`);
  currentQuestionContainer.style.display = 'none';
  
  const nextQuestionContainer = document.getElementById(`question-container-${currentQuestionIndex + 1}`);
  nextQuestionContainer.style.display = 'block';
}

showBeforeQuestion = (currentQuestionIndex) => {
  const currentQuestionContainer = document.getElementById(`question-container-${currentQuestionIndex}`);
  currentQuestionContainer.style.display = 'none';
  
  const beforeQuestionContainer = document.getElementById(`question-container-${currentQuestionIndex - 1}`);
  beforeQuestionContainer.style.display = 'block';
}

yesAndSubmitForm = (questionIndex) => {
  const checkbox = document.getElementById(`checkbox${questionIndex}`);
  checkbox.checked = true;
  document.getElementById('submit-btn').click();
}

noAndSubmitForm = () => {
  document.getElementById('submit-btn').click();
}