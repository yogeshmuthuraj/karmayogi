karmayogi
=========
Currently hosted at Heroku's free plan. So use judiciously.
###### Adding bot to Teams

*   1\. In 'Microsoft Teams' app, navigate to 'Manage Teams'
*   2\. Click on 'Apps' tab
*   3\. Click on 'Create an outgoing webhook'
*   4\. Enter the details as follows:
   *  * Name: karmayogi
   *  * Callback URL: https://karmayogi.herokuapp.com
   *  * Description: 'Your choice'
   *  * Upload image: 'Your choice'
*   5\. Copy the 'security token' generated after creating the webhook(this token will be used for registering team)

###### Registering team

*   1\. Get the link of the team from 'Microsoft Teams' app
*   2\. Paste the link of the team on 'Get Team ID', below this section to extract the 'team id'
*   3\. In 'Register Team' section paste the 'team ID' and 'security token'(copied in Step 4 of 'Adding bot to Teams')

###### Usage

*   1\. Adding karma(points): @karmayogi @user++
*   2\. Removing karma(points): @karmayogi @user--
*   3\. Leaderboard for the team: @karmayogi leaderboard
*   4\. Get random joke: @karmayogi jokeme
*   5\. Help: @karmayogi help"

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
*  * Data loss
*  * and other issues that comes with free hosting

* * *

Yogesh Kumar Muthuraj
