karmayogi
=========
Currently hosted at Heroku's free plan. So use judiciously.
###### Adding karmayogi to Microsoft Teams

*   1\. In 'Microsoft Teams', navigate to 'Manage team'
*   2\. Click on 'Apps' tab
*   3\. Click on 'Create an outgoing webhook'(bottom right)
*   4\. Enter the details as follows:
   *  * Name: karmayogi
   *  * Callback URL: https://karmayogi.herokuapp.com
   *  * Description: 'Your choice'
   *  * Upload image: 'Your choice'
*   5\. Copy the 'security token' generated after creating the webhook(this token will be used for registering team)

###### Registering team

*   1\. Navigate to https://karmayogi.herokuapp.com
*   2\. Navigate to 'Get link to team' within teams, copy the team link.
*   3\. Paste the link of the team on 'Get Team ID' to extract the 'team id'
*   4\. In 'Register Team' section paste the 'team ID' and 'security token'(copied in Step 4 of 'Adding karmayogi to Microsoft Teams')

###### Usage

*   1\. Adding karma(points): @karmayogi @user++
*   2\. Removing karma(points): @karmayogi @user--
*   3\. Leaderboard for the team: @karmayogi leaderboard
*   4\. Get random joke: @karmayogi jokeme
*   5\. Find buddy tester: @karmayogi findbuddy
*   6\. Add buddy tester: @karmayogi addbuddy @user
*   7\. Remove buddy tester: @karmayogi removebuddy @user
*   8\. List buddy testers: @karmayogi buddylist
*   9\. Help: @karmayogi help"

###### Roadmap

*   Encrypt the communication using HMAC
*   Get a domain and hosting space
*   Increase scalability
*   Feature to manage registered teams
*   Extend to Slack
*   Create Bot and a dedicated app

###### Note
*   No one can be held responsible for:
*  * Service down
*  * Data loss and other issues that comes with free hosting
*  * Feel free to contribute by either forking or raising a pull request
*  * Feel free to raise an issue if any bug is found

* * *

Yogesh Kumar Muthuraj
