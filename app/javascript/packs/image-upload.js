document.getElementById('image-upload').addEventListener('change', function(e) {
  const files = e.target.files;
  if (files.length > 3) {
    document.getElementById('error-message').style.display = 'block';
    e.preventDefault();
  } else {
    document.getElementById('error-message').style.display = 'none';
  }
});