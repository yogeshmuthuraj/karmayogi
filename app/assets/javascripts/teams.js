function displaySiteAlert(type, message) {
  // type can be: primary, secondary, success, danger, warning, info, light, and dark

  $('#site-alert').html(`
    <div class="alert alert-${type}" role="alert">
      ${message}
      <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
      </button>
    </div>
  `);
  $('#site-alert').removeClass('d-none');
}

function registerTeam(data) {
  $.ajax({
    type: 'POST',
    url: '/teams',
    data,
    success: (result) => {
      displaySiteAlert(result['type'], result['message']);
    },
    error: (error) => {
      displaySiteAlert(error['type'], error['message']);
    },
  });
}




$(document).on('click', '#register-team-btn', function(event) {
  event.preventDefault();

  var data = {
    team_id: $('#team-id-input').val(),
    security_token: $('#team-security-token-input').val(),
  }

  registerTeam(data);
});
