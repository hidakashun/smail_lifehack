document.addEventListener('DOMContentLoaded', function() {
  let elem = document.querySelector('#post_raty');
  if (elem == null) return;

  elem.innerHTML = "";
  let opt = {
    starOn: "/assets/star-on.png", //<%= asset_path %> を直接埋め込む
    starOff: "/assets/star-off.png", //<%= asset_path %> を直接埋め込む
    scoreName: 'lifehack[star]',
  };
  raty(elem, opt);
});