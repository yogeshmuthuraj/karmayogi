// import asyncHandler from './vendor/asyncHandler';

function registerTeam(data) {
  console.log(data);
  $.ajax({
    type: 'POST',
    url: '/teams',
    data,
    success: (results) => {
      console.log('success');
      console.log(results);
    },
    error: (error) => {
      console.log('error');
      console.log(error);
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
