function getTeamId(event) {
  event.preventDefault();

  var teamLink = $('#team-link').val();

  $('#team-id').removeClass('invisible');

  if(teamLink.length === 0) {
    $('#team-id')[0].innerHTML = 'Field cannot be empty!';
  } else {
    var filtered1 = teamLink.replace('https://teams.microsoft.com/l/team/', '');
    var two = filtered1.split('@')[0];

    $('#team-id')[0].innerHTML = decodeURIComponent(two);
  }
}

function copyTeamIdToClipboard() {
  $('#team-id').select();
  document.execCommand('copy');
}

$(document).on('click', '#get-team-id-btn', function(event) {
  getTeamId(event)
});
